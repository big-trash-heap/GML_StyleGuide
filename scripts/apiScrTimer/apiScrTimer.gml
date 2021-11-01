
API_GML_WARN_ARGS ApiTimer;
API_GML_WARN_ARGS [__init, __tick, __kill];

#region abstract-class timer

function ApiTimer() constructor {
	
	#region __private
	
	static __init = apiFunctorEm /* handler   */;
	static __tick = apiFunctorEm /* arg, self */;
	static __kill = apiFunctorEm /* handler   */;
	
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
function ApiTimerSyncTimeout(_step, _ftick, _finit, _fkill) : __ApiTimerBaseTimeout(_step, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	static __tick = function(_arg) {
		
		if (self.__step > 0) {
			
			--self.__step;
			self.__ftick(_arg, self);
		}
		return (self.__step <= 0);
	}
	
	#endregion
	
}

function ApiTimerAsyncTimeout(_step, _ftick, _finit, _fkill) : __ApiTimerBaseTimeout(_step, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	self.__time = current_time;
	
	static __tick = function(_arg) {
		
		if (current_time - self.__time < self.__step) {
			
			self.__ftick(self, _arg);
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
	
	apiSelfSet("__ftick", _fkill);
	apiSelfSet("__finit", _finit);
	
	self.__ftick = _ftick;
	
	static __tick = function(_0, _arg) {
		
		self.__ftick(self, _arg);
	}
	
	static __init = function(_handler) {
		
		var _f = self[$ "__finit"];
		if (_f != undefined) _f(_handler);
	}
	
	static __kill = function(_handler) {
		
		var _f = self[$ "__fkill"];
		if (_f != undefined) _f(_handler);
	}
	
	#endregion
	
}

function __ApiTimerBaseTimeout(_step, _ftick, _finit, _fkill) : __ApiTimerBaseLoop(_ftick, _finit, _fkill) constructor {
	
	#region __private
	
	self.__step = _step;
	
	#endregion
	
}

#endregion

