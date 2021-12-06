

function ApiQPriority(_wrap) constructor {
	
	#region __private
	
	enum __API_QPRIORITY { PRIORITY, VALUE };
	
	if (__apiIsWrap(_wrap)) {
		self.__ltlist = _wrap.list;
		self.__size   = _wrap.size;
	}
	else {
		self.__ltlist = new ApiLListT();
		self.__size   = 0;
	}
	
	#endregion
	
	static insert = function(_priority, _value) {
		
		++self.__size;
		self.__ltlist.insAfterIf([_priority, _value],
			function(_value, _priority) {
				
				return (_value[__API_QPRIORITY.PRIORITY] <= _priority);
			}, _priority);
	}
	
	static topMin = function() {
		var _value = self.__ltlist.topBegin();
		if (_value != undefined) 
			return _value[__API_LINK_LIST.VALUE][__API_QPRIORITY.VALUE];
	}
	
	static popMin = function() {
		var _value = self.__ltlist.popBegin();
		if (_value != undefined) {
			
			--self.__size;
			return _value[__API_LINK_LIST.VALUE][__API_QPRIORITY.VALUE];
		}
	}
	
	static topMax = function() {
		var _value = self.__ltlist.topEnd();
		if (_value != undefined) 
			return _value[__API_LINK_LIST.VALUE][__API_QPRIORITY.VALUE];
	}
	
	static popMax = function() {
		var _value = self.__ltlist.popEnd();
		if (_value != undefined) {
			
			--self.__size;
			return _value[__API_LINK_LIST.VALUE][__API_QPRIORITY.VALUE];
		}
	}
	
	static size = function() {
		return self.__size;	
	}
	
	static clear = function() {
		self.__size = 0;
		self.__ltlist.clear();
	}
	
	static isEmpty = function() {
		return self.__ltlist.isEmpty();
	}
	
	static toClone = function(_f=apiFunctorId, _data) {
		return new ApiQPriority(
			new __ApiWrap()
				._set("size", self.__size)
				._set("list", self.__ltlist.toClone(
					function(_value, _data) {
						return [
							_value[__API_QPRIORITY.PRIORITY],
							_data.f(_value[__API_QPRIORITY.VALUE], _data.data)
						];
					}, {f: _f, data: _data}))
		);
	}
	
	static toArray = function() {
		if (self.__size > 0) {
			
			var _array = array_create(self.__size);
			var _cell = self.__ltlist.__fst;
			var _indx = 0;
			while (_indx < self.__size) {
				
				_array[++_indx] = _cell[__API_LINK_LIST.VALUE][__API_QPRIORITY.VALUE];
				_cell = _cell[__API_LINK_LIST.NEXT];
			}
			
			return _array;
		}
		return [];
	}
	
}

