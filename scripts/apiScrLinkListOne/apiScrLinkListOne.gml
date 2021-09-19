

function ApiLinkListOne() constructor {
	
	self.__fst = undefined;
	
	static insBegin = function(_value) {
		
		self.__fst = [_value, self.__fst];
		return self.__fst;
	}
	
	static insAfter = function(_value, _cell) {
		
		_value = [_value, _cell[__API_LINK_LIST.NEXT]];
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
	
	static clear = function() {
		
		self.__fst = undefined;
	}
	
	static getValue = function(_cell) {
		
		return _cell[__API_LINK_LIST.VALUE];
	}
	
	static getNext = function(_cell) {
		
		return _cell[__API_LINK_LIST.NEXT];
	}
	
	static foreach = function(_f, _data) {
		
		var _cell = self.__fst;
		while (_cell != undefined) {
			
			_f(_cell[__API_LINK_LIST.VALUE],  _data);
		}
	}
	
	static find = function(_f, _data) {
		
		var _cell = self.__fst;
		while (_cell != undefined) {
			
			if (_f(_cell[__API_LINK_LIST.VALUE],  _data)) return _cell;
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
		
		var _clone = new ApiLinkListOne();
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

