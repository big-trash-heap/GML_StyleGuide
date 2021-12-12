
API_GML_WARN_ARGS ApiCaller;

function ApiCaller() constructor {
	
	#region __private
	
	API_MACRO_CONSTRUCTOR_WRAP {
		var _wrap = argument[0];
		self.__lolist = _wrap.list;
		self.__last   = _wrap.last;
	}
	else
	API_MACRO_CONSTRUCTOR_DEFL {
		self.__lolist = new ApiLListO();
		self.__last   = undefined;
	}
	
	static __fnum = function(_value, _f) {
		
		if (is_numeric(_value)) return (_value == _f);
		return (method_get_index(_value) == _f);
	}
	
	static __fmet = function(_value, _f) {
		
		if (is_numeric(_value)) exit;
		return (method_get_index(_value) == method_get_index(_f) 
			&&  method_get_self(_value)  == method_get_self(_f));
	}
	
	#endregion
	
	static append = function(_f) {
		
		if (self.__last == undefined) {
			self.__last = self.__lolist.insBegin(_f);
		}
		else {
			self.__last = self.__lolist.insAfter(_f, self.__last);
		}
	}
	
	static push = function() {
		
		var _argSize = argument_count;
		for (var _i = 0; _i < _argSize; ++_i) self.append(argument[_i]);
	}
	
	static remFst = function(_f) {
		
		var _last;
		if (is_numeric(_f)) {
			
			_last = self.__lolist.remFst(self.__fnum, _f);
		}
		else {
			
			_last = self.__lolist.remFst(self.__fmet, _f);
		}
		
		if (_last != undefined) {
			
			self.__last = _last[0];
		}
	}
	
	static remAll = function(_f) {
		
		if (is_numeric(_f)) {
			self.__last = self.__lolist.remAll(self.__fnum, _f);
		}
		else {
			self.__last = self.__lolist.remAll(self.__fmet, _f);
		}
	}
	
	static exec = function(_arg) {
		
		var _cell = self.__lolist.topBegin();
		while (_cell != undefined) {
			
			_cell[__API_LINK_LIST.VALUE](_arg);
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
	}
	
	static clear = function() {
		
		self.__lolist.clear();
		self.__last = undefined;
	}
	
	static toArray = function() {
		
		return self.__lolist.toArray();
	}
	
	static toString = function() {
		
		return string(self.__lolist);
	}
	
	static toClone = function(_f=apiFunctorId, _data) {
		var _list = new ApiLListO();
		var _last = undefined;
		var _cell = self.__lolist.__fst;
		if (_cell != undefined) {
			
			_last = _list.insBegin(_f(_cell[__API_LINK_LIST.VALUE], _data));
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
		
		while (_cell != undefined) {
			
			_last = _list.insAfter(_f(_cell[__API_LINK_LIST.VALUE], _data), _last);
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
		return new ApiCaller(
			new __ApiWrap()
				._set("list", _list)
				._set("last", _last)
		);
	}
	
}


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrCaller"
		);
		
		var _cl = new ApiCaller();
		var _ref = {
			
			num: 0,
		}
		
		var _add_1   = method(_ref, function(_n) { self.num += _n; });
		var _add_10  = method(_ref, function(_n) { self.num += _n * 10; });
		var _add_100 = method(_ref, function(_n) { self.num += _n * 100; });
		
		_cl.push(_add_1, _add_1, _add_10, _add_100);
		_cl.exec(1);
		
		apiDebugAssert(
			_ref.num == 112,
			"<apiScrCaller exec 0>"
		);
		
		_cl.remAll(_add_1);
		_cl.remFst(_add_100);
		
		_ref.num = 0;
		_cl.exec(1);
		
		apiDebugAssert(
			_ref.num == 10,
			"<apiScrCaller exec 1>"
		);
		
		_cl.push(_add_100, _add_100, _add_1);
		
		_ref.num = 0;
		_cl.exec(2);
		
		apiDebugAssert(
			_ref.num == 422,
			"<apiScrCaller exec 2>"
		);
		
		#region stack-check
		
		var _ref = {
			stack: [],
			f0: 0,
			f1: 0,
			f2: 0,
			reset: function() { stack = []; f0 = 0; f1 = 0; f2 = 0; }
		}
		
		var f0 = method(_ref, function() { array_push(stack, "0." + string(self.f0++)); });
		var f1 = method(_ref, function() { array_push(stack, "1." + string(self.f1++)); });
		var f2 = method(_ref, function() { array_push(stack, "2." + string(self.f2++)); });
		
		_cl.clear();
		
		_cl.append(f0);
		_cl.append(f0);
		_cl.push(f2, f1, f1, f2);
		_cl.exec();
		
		apiDebugAssert(
			array_equals(
				_ref.stack,
				["0.0", "0.1", "2.0", "1.0", "1.1", "2.1"]
			),
			"<apiScrCaller exec 2>"
		);
		
		_ref.reset();
		_cl.exec();
		
		apiDebugAssert(
			array_equals(
				_ref.stack,
				["0.0", "0.1", "2.0", "1.0", "1.1", "2.1"]
			),
			"<apiScrCaller exec 2 two>"
		);
		
		_ref.reset();
		
		_cl.remFst(f0);
		_cl.remAll(f2);
		
		_cl.exec();
		
		apiDebugAssert(
			array_equals(
				_ref.stack,
				["0.0", "1.0", "1.1"]
			),
			"<apiScrCaller exec 3>"
		);
		
		_ref.reset();
		
		_cl.remFst(f1);
		_cl.push(f0, f2);
		
		_cl.exec();
		
		apiDebugAssert(
			array_equals(
				_ref.stack,
				["0.0", "1.0", "0.1", "2.0"]
			),
			"<apiScrCaller exec 4>"
		);
		
		_ref.reset();
		
		_cl.remAll(method_get_index(f2));
		_cl.remAll(method_get_index(f1));
		_cl.remAll(method_get_index(f0));
		
		_cl.exec();
		
		apiDebugAssert(
			array_equals(
				_ref.stack,
				[]
			),
			"<apiScrCaller exec 5>"
		);
		
		_cl.push(f2, f0, f2, f1, f0, f1);
		
		_cl.exec();
		
		apiDebugAssert(
			array_equals(
				_ref.stack,
				["2.0", "0.0", "2.1", "1.0", "0.1", "1.1"]
			),
			"<apiScrCaller exec 6>"
		);
		
		_ref.reset();
		
		_cl.remFst(f1);
		_cl.remFst(f1);
		_cl.remFst(f0);
		_cl.remFst(f0);
		_cl.remFst(f2);
		_cl.remFst(f2);
		
		_cl.exec();
		
		apiDebugAssert(
			array_equals(
				_ref.stack,
				[]
			),
			"<apiScrCaller exec 7>"
		);
		
		#endregion
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

