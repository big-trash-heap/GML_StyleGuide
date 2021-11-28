

function ApiQS(_wrap) constructor {

	#region __private
	
	if (__apiIsWrap(_wrap)) {
		self.__ltlist = _wrap.list;
		self.__size   = _wrap.size;
	}
	else {
		self.__ltlist = new ApiLListT();
		self.__size   = 0;
	}
	
	#endregion
	
	static push = function() {
		
		var _argSize = argument_count;
		for (var _i = 0; _i < _argSize; ++_i)
			self.__ltlist.insEnd(argument[_i]);
		
		self.__size += _argSize;
	}
	
	static enqueue = function() {
		
		var _argSize = argument_count;
		for (var _i = 0; _i < _argSize; ++_i)
			self.__ltlist.insBegin(argument[_i]);
		
		self.__size += _argSize;
	}
	
	static top = function() {
		var _value = self.__ltlist.topEnd();
		if (_value != undefined) return _value[__API_LINK_LIST.VALUE];
	}
	
	static pop = function() {
		var _value = self.__ltlist.popEnd();
		if (_value != undefined) {
			
			--self.__size;
			return _value[__API_LINK_LIST.VALUE];
		}
	}
	
	static head = self.top;
	
	static tail = self.pop;
	
	static size = function() {
		return self.__size;	
	}
	
	static indexOf = function(_index) {
		var _value = self.__ltlist.indexOf(_index);
		if (_value != undefined) return _value[__API_LINK_LIST.VALUE];
	}
	
	static indexOfInv = function(_index) {
		var _value = self.__ltlist.indexOfInv(_index);
		if (_value != undefined) return _value[__API_LINK_LIST.VALUE];
	}
	
	static clear = function() {
		self.__size = 0;
		self.__ltlist.clear();
	}
	
	static isEmpty = function() {
		return self.__ltlist.isEmpty();
	}
	
	static toArray = function() {
		return self.__ltlist.toArray();	
	}
	
	static toClone = function(_f, _data) {
		return new ApiQS(
			new __ApiWrap()
				._set("size", self.__size)
				._set("list", self.__ltlist.toClone(_f, _data))
		);
	}
	
}

