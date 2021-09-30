

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
		
		if (_cell == self.__fst) {
			
			self.__fst = self.__fst[__API_LINK_LIST.NEXT];
			exit;
		}
		
		_prev[@ __API_LINK_LIST.NEXT] = _cell[__API_LINK_LIST.NEXT];
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
	
	static remFst = function(_f, _data) {
		
		var _prev = undefined, _next;
		var _cell = self.__fst;
		
		while (_cell != undefined) {
			
			_next = _cell[__API_LINK_LIST.NEXT];
			if (_f(_cell[__API_LINK_LIST.VALUE], _data)) {
				
				if (_prev != undefined) {
				
					_prev[@ __API_LINK_LIST.NEXT] = _next;
					if (_next == undefined) return _prev;
				}
				else {
					self.__fst = _next;
				}
				
				return undefined;
			}
			
			_prev = _cell;
			_cell = _next;
		}
	}
	
	static remAll = function(_f, _data) {
		
		var _prev = undefined, _next;
		var _cell = self.__fst;
		
		while (_cell != undefined) {
			
			_next = _cell[__API_LINK_LIST.NEXT];
			if (_f(_cell[__API_LINK_LIST.VALUE], _data)) {
				
				if (_prev != undefined) {
				
					_prev[@ __API_LINK_LIST.NEXT] = _next;
					if (_next == undefined) return _prev;
				}
				else {
					self.__fst = _next;
				}
			}
			else {
				_prev = _cell;
			}
			
			_cell = _next;
		}
	}
	
	static indexOf = function(_index) {
		
		var _cell = self.__fst;
		while (_cell != undefined) {
			
			if (_index == 0) return _cell;
			--_index;
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
		
		apiLListOSwpVal(_v1, _v2); // -understanding
		
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
		
		_lolist = new ApiLListO();
		_lolist.insBegin(5);
		var _fst = _lolist.insBegin(4);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[4, 5]
			),
			"<apiScrLinkListOne rem fst mode>"
		);
		
		_lolist.rem(_fst);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[5]
			),
			"<apiScrLinkListOne rem fst mode 1>"
		);
		
		_lolist = new ApiLListO();
		_lolist.insBegin(5);
		_lolist.insBegin(4);
		_lolist.insBegin(3);
		_lolist.insBegin(2);
		_lolist.insBegin(1);
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[1, 2, 3, 4, 5]
			),
			"<apiScrLinkListOne remFst, remAll 0>"
		);
		
		_lolist.remFst(function(_value) { return _value == 1; });
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[2, 3, 4, 5]
			),
			"<apiScrLinkListOne remFst, remAll 1>"
		);
		
		var _last = _lolist.remFst(function(_value) { return _value == 5; });
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[2, 3, 4]
			),
			"<apiScrLinkListOne remFst, remAll 2>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_last) == 4,
			"<apiScrLinkListOne remFst, remAll 2.5>"
		);
		
		_lolist.clear();
		
		_lolist.insBegin(8);
		_lolist.insBegin(7);
		_lolist.insBegin(6);
		_lolist.insBegin(5);
		_lolist.insBegin(4);
		_lolist.insBegin(3);
		_lolist.insBegin(2);
		_lolist.insBegin(1);
		
		var _last = _lolist.remAll(function(_value) { 
			return _value == 1 || _value == 2 || _value == 5 || _value == 7 || _value == 8; 
		});
		
		apiDebugAssert(
			array_equals(
				_lolist.toArray(),
				[3, 4, 6]
			),
			"<apiScrLinkListOne remFst, remAll 3>"
		);
		
		apiDebugAssert(
			apiLListOGetVal(_last) == 6,
			"<apiScrLinkListOne remFst, remAll 3.5>"
		);
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

#region tests - random
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL true;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrLinkListOne random"
		);
		
		var _build = function() {
			
			var _build = {
				l: new ApiLListO(),
				s: 0,
				al: [],
				av: [],
			};
			
			var _size   = irandom_range(20, 100);
			var _insert = false;
			
			for (var _i = 0; _i < _size; ++_i) {
				
				if (_insert) {
					
					switch (choose("push", "insBegin", "insRand")) {
						
						case "push":
							array_push(_build.al, _build.l.insAfter(_i, _build.al[_i - 1]));
							array_push(_build.av, _i);
							break;
						case "insBegin":
							array_insert(_build.al, 0, _build.l.insBegin(_i));
							array_insert(_build.av, 0, _i);
							break;
						case "insRand":
							var _j = irandom(_i - 1) + 1;
							array_insert(_build.al, _j, _build.l.insAfter(_i, _build.al[_j - 1]));
							array_insert(_build.av, _j, _i);
							break;
					}
				}
				else {
					
					_insert = true;
					array_push(_build.al, _build.l.insBegin(_i));
					array_push(_build.av, _i);
				}
			}
			
			_build.s = _size;
			
			repeat irandom_range(10, 50) {
				
				var _i = irandom(_build.s - 1);
				var _j = irandom(_build.s - 1);
				
				if (_i != _j and _i > -1 and _j > -1) {
					
					apiLListOSwpVal(_build.al[_i], _build.al[_j]);
					
					var _tmp = _build.av[_i];
					_build.av[_i] = _build.av[_j];
					_build.av[_j] = _tmp;
				}
			}
			
			apiDebugAssert(
				array_equals(
					_build.l.toArray(),
					_build.av,
				),
				"<apiScrLinkListOne rand values>"
			);
			
			var _ref = _build.l.topBegin();
			for (var _i = 0; _i < _build.s; ++_i) {
				
				apiDebugAssert(_ref == _build.al[_i], "<apiScrLinkListOne rand ref>");
				_ref = apiLListOGetNext(_ref);
			}
		}
		
		repeat 1000 _build();
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

