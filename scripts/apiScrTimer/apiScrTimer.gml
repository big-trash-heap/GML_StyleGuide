
API_GML_WARN_ARGS ApiTimer;
API_GML_WARN_ARGS [__init, __tick, __kill];

#region abstract-class timer

function ApiTimer() constructor {
	
	#region __private
	
	// self        <- handler.timer
	// ?handler?   <- handler.self | undefined
	// ??more...?? <- timer.arguments...
	
	static __init = apiFunctorEm /* self, ?handler?, ??more...?? */;
	static __tick = apiFunctorEm /* self, arg,       ??more...?? */;
	static __kill = apiFunctorEm /* self, ?handler?, ??more...?? */;
	
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
	
	static toString = function() {
		return instanceof(self);	
	}
	
}

#endregion

#region base timers

// Timeout
function ApiTimerSyncTimeout(_steps, _ftick, _finit, _fkill) : __ApiTimerBaseTimeout(_steps, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	static __tick = __apiTimer_tickSync;
	
	#endregion
	
}

function ApiTimerAsyncTimeout(_milisec, _ftick, _finit, _fkill) : __ApiTimerBaseTimeout(_milisec, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	static __tick = __apiTimer_tickAsync;
	
	#endregion
	
}

// Loop
function ApiTimerLoop(_ftick, _finit, _fkill) : __ApiTimerBaseLoop(_ftick, _finit, _fkill) constructor {}

#endregion

#region ext timers

// Timeout
function ApiTimerSyncTimeoutExt(_steps, _ftick, _finit, _fkill) : __ApiTimerBaseTimeoutExt(_steps, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	static __tick = __apiTimer_tickSync;
	
	#endregion
	
}

function ApiTimerAsyncTimeoutExt(_milisec, _ftick, _finit, _fkill) : __ApiTimerBaseTimeoutExt(_milisec, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	static __tick = __apiTimer_tickAsync;
	
	#endregion
	
}

#endregion


#region __private


function __ApiTimerBaseLoop(_ftick=undefined, _finit=undefined, _fkill=undefined) : ApiTimer() constructor {
	
	#region __private
	
	apiSelfSet("__init", _finit);
	apiSelfSet("__tick", _ftick);
	apiSelfSet("__kill", _fkill);
	
	#endregion
	
}

function __ApiTimerBaseTimeout(_steps, _ftick, _finit, _fkill) : ApiTimer() constructor {
	
	#region __private
	
	self.__step = apiMthARound(_steps, ceil);
	
	apiSelfSet("__init", _finit);
	apiSelfSet("__kill", _fkill);
	
	static __ftick = apiFunctorEm;
	apiSelfSet("__ftick", _ftick);
	
	#endregion
	
	static setTime = function(_steps) {
		self.__step = apiMthARound(_steps, ceil);
		return self;
	}
	
	static getTime = function() {
		return abs(self.__step);
	}
	
	static pause = function() {
		if (self.__step > 0) self.__step = -self.__step;
		return self;
	}
	
	static resume = function() {
		if (self.__step < 0) self.__step = -self.__step;
		return self;
	}
	
	static isPause = function() {
		return (self.__step < 0);
	}
	
	static isPlay = function() {
		return (self.__step > 0);
	}
	
	static isEnd = function() {
		return (self.__step == 0);
	}
	
}

function __ApiTimerBaseTimeoutExt(_steps, _ftick, _finit, _fkill) : __ApiTimerBaseTimeout(_steps, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	self.__max_step = abs(self.__step);
	
	#endregion
	
	static setTime = function(_steps) {
		self.__step = apiMthARound(_steps, ceil);
		self.__max_step = abs(self.__step);
		return self;
	}
	
	static getTimeMax = function() {
		return self.__max_step;
	}
	
	static getPast = function() {
		return (self.__max_step - abs(self.__step));
	}
	
	static getLeft = self.getTime;
	
	static getPastCf = function() {
		return (1 - abs(self.__step) / self.__max_step);
	}
	
	static getLeftCf = function() {
		return (abs(self.__step) / self.__max_step);
	}
	
	static resetTime = function(_endPlay=false) {
		self.__step = self.__max_step * apiMthSign(self.__step, _endPlay);
		return self;
	}
	
}


function __apiTimer_tickSync(_timer, _arg) {
	
	if (self.__step > 0) {
		
		--self.__step;
		self.__ftick(_timer, _arg);
		return (self.__step == 0);
	}
}

function __apiTimer_tickAsync(_timer, _arg) {
		
	if (self.__step > 0) {
		
		var _step = API_TIME_ASYNC_STEP;
		if (self.__step > _step) {
			self.__step -= _step;
		}
		else {
			_step = self.__step;
			self.__step = 0;
		}
		
		self.__ftick(_timer, _arg, _step);
		return (self.__step == 0);
	}
}


#endregion

