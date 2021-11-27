

#region class

function ApiTimerHandlerSave() constructor {
	
	#region __private
	
	self.__ltlist = new ApiLListT();
	
	self.__forEach_enable = 0;
	self.__forEach_next   = undefined;
	self.__forEach_end    = undefined;
	
	self.__countTimer = 0;
	
	static __memMap = __apiTimerHandlerMemMap();
	
	static __castInit = __apiTimerHandler_castInit;
	static __castKill = __apiTimerHandler_castKill;
	
	static __forEach = apiFunctorFunc(function(_f, _arg) {
		
		var _cell = self.__ltlist.topBegin();
		if (_cell != undefined) {
			
			self.__forEach_end = self.__ltlist.topEnd();
			
			while (_cell != self.__forEach_end) {
				
				self.__forEach_next = _cell[__API_LINK_LIST.NEXT];
				
				_f(_cell[__API_LINK_LIST.VALUE], _arg);
				_cell = self.__forEach_next;
			}
			
			if (_cell != undefined) {
				self.__forEach_next = undefined;
				self.__forEach_end  = undefined;
				
				_f(_cell[__API_LINK_LIST.VALUE], _arg);
			}
		}
	});
	
	#endregion
	
	static getCount = function() {
		return self.__countTimer;
	}
	
	static iter = function(_arg) {
		
		if (self.__forEach_enable > 0) {
			
			apiDebugError("ApiTimerHandler: Нельзя вызывать метод iter во время вызова в этом обработчике iter или clear методов");
			return;
		}
		
		var _cell = self.__ltlist.topBegin();
		if (_cell != undefined) {
			
			++self.__forEach_enable;
			self.__forEach_end = self.__ltlist.topEnd();
			
			while (_cell != self.__forEach_end) {
				
				self.__forEach_next = _cell[__API_LINK_LIST.NEXT];
				
				_cell = _cell[__API_LINK_LIST.VALUE];
				if (_cell.__tick(_cell, _arg)) apiTimerHandlerRem(_cell);
				
				_cell = self.__forEach_next;
			}
			
			if (_cell != undefined) {
				self.__forEach_next = undefined;
				self.__forEach_end  = undefined;
				
				_cell = _cell[__API_LINK_LIST.VALUE];
				if (_cell.__tick(_cell, _arg)) apiTimerHandlerRem(_cell);
			}
			
			--self.__forEach_enable;
		}
	}
	
	static append = function(_timer) {
		
		if (ds_map_exists(self.__memMap, _timer)) {
			
			apiDebugError("Таймер уже занят обработчиком");
		}
		
		var _cell = self.__ltlist.insEnd(_timer);
		self.__memMap[? _timer] = [_cell, self];
		
		++self.__countTimer;
		self.__castInit(_timer, self);
		return _timer;
	}
	
	static clear = function() {
		
		++self.__forEach_enable;
		self.__forEach(apiTimerHandlerRem);
		--self.__forEach_enable;
	}
	
	static clearAll = function() {
		
		++self.__forEach_enable;
		
		var _cell = self.__ltlist.popBegin();
		while (_cell != undefined) {
			
			apiTimerHandlerRem(_cell[__API_LINK_LIST.VALUE]);
			_cell = self.__ltlist.popBegin();
		}
		--self.__forEach_enable;
		
		if (self.__forEach_next != undefined) {
			self.__forEach_next = undefined;
			self.__forEach_end  = undefined;
		}
	}
	
	static isBind = function(_timer) {
		
		var _timerMetaInfo = self.__memMap[? _timer];
		if (_timerMetaInfo != undefined)
			return (self == _timerMetaInfo[1]);
		return false;
	}
	
	static isEmpty = function() {
		return self.__ltlist.isEmpty();
	}
	
	static toString = function() {
		return (instanceof(self) + "; number of timers: " + string(self.__countTimer));
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
	
	static _memMap = __apiTimerHandlerMemMap();
	
	if (_timer == undefined) return false;
	
	var _cell = _memMap[? _timer];
	if (_cell != undefined) {
		
		var _handler = _cell[1];
		_cell        = _cell[0];
		
		ds_map_delete(_memMap, _timer);
		
		if (_handler.__forEach_next != undefined) {
			
			if (_handler.__forEach_next == _cell) {
				if (_handler.__forEach_end == _cell) {
					_handler.__forEach_next = undefined;
					_handler.__forEach_end = undefined;
				}
				else {
					_handler.__forEach_next = _cell[__API_LINK_LIST.NEXT];
				}
			}
			else
			if (_handler.__forEach_end == _cell) {
				_handler.__forEach_end = _cell[__API_LINK_LIST.PREV];
			}
		}
		
		--_handler.__countTimer;
		_handler.__ltlist.rem(_cell);
		_handler.__castKill(_timer, _handler);
		
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
	static _memMap = ds_map_create();
	return _memMap;
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

