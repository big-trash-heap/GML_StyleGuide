

function ApiTimerHandler() constructor {
	
	#region __private
	
	self.__ltlist = new ApiLListT();
	
	static __memMap = __apiTimerHandlerMemMap();
	
	#endregion
	
	static iter = function(_arg) {
		
		var _cell = self.__ltlist.topBegin();
		var _next, _timer;
		while (_cell != undefined) {
			
			_next  = _cell[__API_LINK_LIST.NEXT];
			_timer = _cell[__API_LINK_LIST.VALUE];
			
			if (_timer.__tick(_timer, _arg)) {
				
				self.__ltlist.rem(_cell);
				ds_map_delete(self.__memMap, _timer);
				
				_timer.__kill(self);
			}
			
			_cell = _next;
		}
	}
	
	static append = function(_timer) {
		
		if (ds_map_exists(self.__memMap, _timer)) {
			
			apiDebugError("Таймер уже занят обработчиком");
		}
		
		var _cell = self.__ltlist.insEnd(_timer);
		self.__memMap[? _timer] = [_cell, self];
		
		_timer.__init(self);
		return _timer;
	}
	
	static clear = function() {
		
		var _cell = self.__ltlist.topBegin();
		var _timer;
		while (_cell != undefined) {
			
			_timer = _cell[__API_LINK_LIST.VALUE];
			_cell  = _cell[__API_LINK_LIST.NEXT];
			
			ds_map_delete(self.__memMap, _timer);
			
			_timer.__kill(self);
		}
		
		self.__ltlist.clear();
	}
	
	static isBind = function(_timer) {
		
		var _timerMetaInfo = self.__memMap[? _timer];
		if (_timerMetaInfo != undefined)
			return (self == _timerMetaInfo[1]);
		return false;
	}
	
}

function apiTimerHandlerRem(_timer) {
	
	var _memMap = __apiTimerHandlerMemMap();
	var _timerMetaInfo = _memMap[? _timer];
	if (_timerMetaInfo != undefined) {
		
		_timerMetaInfo[1].__ltlist.rem(_timerMetaInfo[0]);
		ds_map_delete(_memMap, _timer);
		
		_timer.__kill(_timerMetaInfo[1]);
		return true;
	}
	return false;
}

function apiTimerHandlerIsBind(_timer) {
	
	return ds_map_exists(__apiTimerHandlerMemMap(), _timer);
}

function __apiTimerHandlerMemMap() {
	static __memMap = ds_map_create();
	return __memMap;
}

