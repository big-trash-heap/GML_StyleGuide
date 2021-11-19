

#region class

function ApiTimerHandlerSave() constructor {
	
	#region __private
	
	self.__ltlist = new ApiLListT();
	
	static __memMap = __apiTimerHandlerMemMap();
	
	static __castInit = __apiTimerHandler_castInit;
	static __castKill = __apiTimerHandler_castKill;
	
	#endregion
	
	static iter = function(_arg) {
		
		var _cell = self.__ltlist.topBegin();
		var _next, _timer;
		while (_cell != undefined) {
			
			_next  = _cell[__API_LINK_LIST.NEXT];
			_timer = _cell[__API_LINK_LIST.VALUE];
			
			if (_timer.__tick(_timer, _arg)) {
				
				self.__castKill(_timer, self);
				self.__ltlist.rem(_cell);
				ds_map_delete(self.__memMap, _timer);
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
		
		self.__castInit(_timer, self);
		return _timer;
	}
	
	static clear = function() {
		
		var _cell = self.__ltlist.topBegin();
		var _timer;
		while (_cell != undefined) {
			
			_timer = _cell[__API_LINK_LIST.VALUE];
			_cell  = _cell[__API_LINK_LIST.NEXT];
			
			self.__castKill(_timer, self);
			ds_map_delete(self.__memMap, _timer);
		}
		
		self.__ltlist.clear();
	}
	
	static isBind = function(_timer) {
		
		var _timerMetaInfo = self.__memMap[? _timer];
		if (_timerMetaInfo != undefined)
			return (self == _timerMetaInfo[1]);
		return false;
	}
	
	static toString = function() {
		
		var _size = self.__ltlist.mathSize();
		return (instanceof(self) + "; size: " + string(_size));
	}
	
}

function ApiTimerHandler() : ApiTimerHandlerSave() constructor {
	
	#region __private
	
	static __castInit = __apiTimerHandler_castInitSelf;
	static __castKill = __apiTimerHandler_castKillSelf;
	
	#endregion
	
}

#endregion

#region functions

function apiTimerHandlerRem(_timer) {
	
	var _memMap = __apiTimerHandlerMemMap();
	var _timerMetaInfo = _memMap[? _timer];
	if (_timerMetaInfo != undefined) {
		
		_timerMetaInfo[1].__castKill(_timer, _timerMetaInfo[1]);
		_timerMetaInfo[1].__ltlist.rem(_timerMetaInfo[0]);
		
		ds_map_delete(_memMap, _timer);
		return true;
	}
	return false;
}

function apiTimerHandlerIsBind(_timer) {
	
	return ds_map_exists(__apiTimerHandlerMemMap(), _timer);
}

#endregion


#region __private

function __apiTimerHandlerMemMap() {
	static __memMap = ds_map_create();
	return __memMap;
}

function __apiTimerHandler_castInit(_timer) {
	_timer.__init(_timer);
}

function __apiTimerHandler_castKill(_timer) {
	_timer.__kill(_timer);
}

function __apiTimerHandler_castInitSelf(_timer, _handler) {
	_timer.__init(_timer, _handler);
}

function __apiTimerHandler_castKillSelf(_timer, _handler) {
	_timer.__kill(_timer, _handler);
}

#endregion

