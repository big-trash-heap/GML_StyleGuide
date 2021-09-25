

#region class

function ApiLListO() constructor {
	
	#region __private
	
	self.__fst = undefined;
	
	static __build = function(_value, _next) {
		
		return [_value, _next];
	}
	
	#endregion
	
	static insBegin = function(_value) {
		
		self.__fst = self.__build(_value, self.__fst);
		return self.__fst;
	}
	
	static insAfter = function(_value, _cell) {
		
		_value = self.__build(_value, _cell[__API_LINK_LIST.NEXT]);
		_cell[@ __API_LINK_LIST.NEXT] = _value;
		
		return _value;
	}
	
	static topBegin = function() {
		
		return self.__fst;
	}
	
	static popBegin = function() {
		
		var _value = self.__fst;
		self.__fst = _value[__API_LINK_LIST.NEXT];
		return _value;
	}
	
	static rem = function(_cell, _prev) {
		
		_prev[@ __API_LINK_LIST.NEXT] = _cell[@ __API_LINK_LIST.NEXT];
	}
	
	static clear = function() {
		
		self.__fst = undefined;
	}
	
	static call = function(_f, _data) {
		
		var _cell = self.__fst;
		while (_cell != undefined) {
			
			_f(_cell[__API_LINK_LIST.VALUE], _data);
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
	}
	
	static find = function(_f, _data) {
		
		var _cell = self.__fst;
		while (_cell != undefined) {
			
			if (_f(_cell[__API_LINK_LIST.VALUE], _data)) return _cell;
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
		return undefined;
	}
	
	static mathSize = function() {
		
		var _size = 0;
		var _cell = self.__fst;
		while (_cell != undefined) {
			
			++_size;
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
		
		return _size;
	}
	
	static toClone = function(_f=apiFunctorId, _data) {
		
		var _clone = new ApiLListO();
		var _cell = self.__fst;
		if (_cell != undefined) {
			
			var _ceilBuild = _clone.insBegin(_f(_cell[__API_LINK_LIST.VALUE], _data));
			_cell          = _cell[__API_LINK_LIST.NEXT];
			
			while (_cell != undefined) {
				
				_ceilBuild = _clone.insAfter(_f(_cell[__API_LINK_LIST.VALUE], _data), _ceilBuild);
				_cell      = _cell[__API_LINK_LIST.NEXT];
			}
		}
		return _clone;
	}
	
	static toArray = function() {
		
		var _array = [];
		var _cell = self.__fst;
		while (_cell != undefined) {
			
			array_push(_array, _cell[__API_LINK_LIST.VALUE]);
			_cell = _cell[__API_LINK_LIST.NEXT];
		}
		
		return _array;
	}
	
	static toString = function() {
		
		return string(self.toArray());
	}
	
}

#endregion

#region functions

function apiLListOGetVal(_cell) {
	
	return _cell[__API_LINK_LIST.VALUE];
}

function apiLListOSetVal(_cell, _value) {
	
	_cell[@ __API_LINK_LIST.VALUE] = _value;
}

function apiLListOGetNext(_cell) {
	
	return _cell[__API_LINK_LIST.NEXT];
}

function apiLListOSwpVal(_cell1, _cell2) {
	
	if (_cell1 == _cell2) exit;
	
	var _value = _cell1[__API_LINK_LIST.VALUE];
	_cell1[@ __API_LINK_LIST.VALUE] = _cell2[__API_LINK_LIST.VALUE];
	_cell2[@ __API_LINK_LIST.VALUE] = _value;
}

#endregion


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL true;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrLinkListOne"
		);
		
		var _lolist = new ApiLListO();
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[]
			),
			"<apiScrLinkListOne empty>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 0,
			"<apiScrLinkListOne size empty>"
		);
		
		var _lolist_clone = _lolist.toClone();
		_lolist.insBegin(4);
		
		apiDebugAssert(
			array_equals(
				_lolist_clone.toArray(),
				[]
			),
			"<apiScrLinkListOne empty clone>"
		);
		
		apiDebugAssert(
			_lolist_clone.mathSize() == 0,
			"<apiScrLinkListOne size empty clone>"
		);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4]
			),
			"<apiScrLinkListOne insBegin 1>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 1,
			"<apiScrLinkListOne insBegin size 1>"
		);
		
		_lolist.insBegin(8);
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[8, 4]
			),
			"<apiScrLinkListOne insBegin 1>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 2,
			"<apiScrLinkListOne insBegin size 1>"
		);
		
		apiDebugAssert(
			array_equals(
				_lolist_clone.toArray(),
				[]
			),
			"<apiScrLinkListOne empty clone 2>"
		);
		
		apiDebugAssert(
			_lolist_clone.mathSize() == 0,
			"<apiScrLinkListOne size empty clone 2>"
		);
		
		var _pop;
		
		_pop = _lolist.popBegin();
		apiDebugAssert(
			apiLListOGetVal(_pop) == 8,
			"<apiScrLinkListOne getValue 1>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(apiLListOGetNext(_pop)) == 4,
			"<apiScrLinkListOne getValue 1 next>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 1,
			"<apiScrLinkListOne getValue 1 size>"
		);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4]
			),
			"<apiScrLinkListOne getValue 1 check>"
		);
		
		_pop = _lolist.popBegin();
		apiDebugAssert(
			apiLListOGetVal(_pop) == 4,
			"<apiScrLinkListOne getValue 2>"
		);
		
		apiDebugAssert(
			apiLListOGetNext(_pop) == undefined,
			"<apiScrLinkListOne getValue 2 next>"
		);
		
		apiDebugAssert(
			_lolist.mathSize() == 0,
			"<apiScrLinkListOne getValue 2 size>"
		);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[]
			),
			"<apiScrLinkListOne getValue 2 check>"
		);
		
		apiDebugAssert(
			_lolist.topBegin() == undefined,
			"<apiScrLinkListOne getValue empty>"
		);
		
		_lolist = new ApiLListO();
		
		var _v1 = _lolist.insBegin(4);
		var _v2 = _lolist.insBegin(8);
		
		apiLListOSwpVal(_v1, _v2);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4, 8]
			),
			"<apiScrLinkListOne swapValue>"
		);
		
		_lolist.rem(_v1, _v2);
		_lolist.insAfter("Hello", _v2);
		apiLListOSetVal(_v2, "World");
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				["World", "Hello"]
			),
			"<apiScrLinkListOne remValue>"
		);
		
		_lolist = new ApiLListO();
		_lolist.insBegin(4);
		_lolist.insBegin(8);
		var _arr = [];
		_lolist.call(function(_v, _a) {
			array_push(_a, _v);
		}, _arr);
		
		apiDebugAssert(
			array_equals(
				_arr,
				[8, 4]
			),
			"<apiScrLinkListOne call>"
		);
		
		var _clone = _lolist.toClone();
		
		var _v1 = _lolist.topBegin();
		var _v2 = apiLListOGetNext(_v1);
		
		apiLListOSwpVal(_v1, _v2);
		_lolist.insAfter(16, _v2);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4, 8, 16]
			),
			"<apiScrLinkListOne swp 1>"
		);
		
		apiDebugAssert(
			array_equals(
				_clone.toArray(),
				[8, 4]
			),
			"<apiScrLinkListOne swp 2>"
		);
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

