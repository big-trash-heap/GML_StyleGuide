
API_GML_WARN_ARGS ApiTimer;
API_GML_WARN_ARGS [__init, __tick, __kill];

#region abstract-class timer

function ApiTimer() constructor {
	
	#region __private
	
	static __init = apiFunctorEm /* self, ?handler? */;
	static __tick = apiFunctorEm /* self, arg       */;
	static __kill = apiFunctorEm /* self, ?handler? */;
	
	#endregion
	
	static rem = function() {
		
		return apiTimerHandlerRem(self);
	}
	
	static isBind = function() {
		
		return apiTimerHandlerIsBind(self);
	}
	
	static set = function(_key, _data) {
		
		self[$ _key] = _data;
		return self;
	}
	
	static impl = function(_struct) {
		
		apiStructMerge(self, _struct, true);
		return self;
	}
	
}

#endregion

#region base timers

// Timeout
function ApiTimerSyncTimeout(_steps, _ftick, _finit, _fkill) : __ApiTimerBaseTimeout(_steps, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	static __tick = function(_timer, _arg) {
		
		if (self.__step > 0) {
			
			--self.__step;
			self.__ftick(_timer, _arg);
		}
		return (self.__step <= 0);
	}
	
	#endregion
	
}

function ApiTimerAsyncTimeout(_milisec, _ftick, _finit, _fkill) : __ApiTimerBaseTimeout(_milisec, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	self.__time = current_time;
	
	static __tick = function(_timer, _arg) {
		
		if (current_time - self.__time < self.__step) {
			
			self.__ftick(_timer, _arg);
			return false;
		}
		return true;
	}
	
	#endregion
	
}

// Loop
function ApiTimerLoop(_ftick, _finit, _fkill) : __ApiTimerBaseLoop(_ftick, _finit, _fkill) constructor {}

#endregion


#region __private

function __ApiTimerBaseLoop(_ftick=apiFunctorEm, _finit=undefined, _fkill=undefined) : ApiTimer() constructor {
	
	#region __private
	
	apiSelfSet("__finit", _finit);
	apiSelfSet("__fkill", _fkill);
	
	self.__ftick = _ftick;
	
	static __tick = function(_arg) {
		
		return self.__ftick(self, _arg);
	}
	
	static __init = function(_timer, _handler) {
		
		var _f = self[$ "__finit"];
		if (_f != undefined) _f(_timer, _handler);
	}
	
	static __kill = function(_timer, _handler) {
		
		var _f = self[$ "__fkill"];
		if (_f != undefined) _f(_timer, _handler);
	}
	
	#endregion
	
}

function __ApiTimerBaseTimeout(_step, _ftick, _finit, _fkill) : __ApiTimerBaseLoop(_ftick, _finit, _fkill) constructor {
	
	#region __private
	
	self.__step = _step;
	
	#endregion
	
}

#endregion

