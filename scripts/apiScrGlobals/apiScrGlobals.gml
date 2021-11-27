

#region once

if (variable_global_exists("__apiTxtBuffer")) exit;

#endregion

#region getter

function __apiGLGetter(_name) {
	
	static _once = apiScrGlobals();
	return variable_global_get(_name);
}

#endregion


#region apiTimeAsyncStep

#macro API_TIME_ASYNC_STEP			__apiTimeAsyncStep()

global.__apiTimeAsyncStep_s0 = current_time;
global.__apiTimeAsyncStep_s1 = 0;
global.__apiTimeAsyncStep_sd = 0;

function __apiTimeAsyncStep() {
	static _once = apiScrGlobals();
	return global.__apiTimeAsyncStep_sd;
}

function __apiTimeAsyncStepIter() {
	global.__apiTimeAsyncStep_s1 = global.__apiTimeAsyncStep_s0;
	global.__apiTimeAsyncStep_s0 = current_time;
	
	if (global.__apiTimeAsyncStep_s0 > global.__apiTimeAsyncStep_s1)
		global.__apiTimeAsyncStep_sd = global.__apiTimeAsyncStep_s0 - global.__apiTimeAsyncStep_s1;
}

#endregion

#region apiTxtBuffer

#macro ____API_GL_TXTBUF			__apiGLGetter("__apiTxtBuffer")
#macro ____API_GL_TXTBUF_READ		__apiGLTxtBufRead()

#macro ____API_GL_TXTBUF_SIZE_MIN	2048
#macro ____API_GL_TXTBUF_RESZ_PRC	60

global.__apiTxtBuffer      = apiBufTxtCreate(____API_GL_TXTBUF_SIZE_MIN);
global.__apiTxtBuffer_size = 0;
global.__apiTxtBuffer_iter = 0;

function __apiGLTxtBufRead() {
	
	static _buffer = ____API_GL_TXTBUF;
	
	global.__apiTxtBuffer_size += apiBufTxtSize(_buffer);
	++global.__apiTxtBuffer_iter;
	
	var _string = apiBufTxtCRead(_buffer);
	if (global.__apiTxtBuffer_size > 131072) {
		
		var _size = max(
			round(global.__apiTxtBuffer_size / global.__apiTxtBuffer_iter),
			____API_GL_TXTBUF_SIZE_MIN
		);
		
		var _bufsize = buffer_get_size(_buffer);
		if (_bufsize > _size) {
			
			var _percent = _size / _bufsize * 100;
			if (_percent <= ____API_GL_TXTBUF_RESZ_PRC) {
				
				buffer_resize(_buffer, _size);
			}
		}
		
		global.__apiTxtBuffer_size = 0;
		global.__apiTxtBuffer_iter = 0;
	}
	
	buffer_seek(_buffer, buffer_seek_start, 0);
	return _string;
}

#endregion

#region apiTimerHandler

#macro __API_TIMER_HANDLER			__apiGLGetter("__apiTimerHandler")

global.__apiTimerHandler = new ApiTimerHandlerSave();

function apiTHand_timer(_timer) {
	static _handler = __API_TIMER_HANDLER;
	return _handler.append(_timer);
}

function apiTHand_sync(_steps, _ftick, _finit, _fkill, _extType=true) {
	_extType = (_extType ? ApiTimerSyncTimeoutExt : ApiTimerSyncTimeout);
	return apiTHand_timer(new _extType(_steps, _ftick, _finit, _fkill));
}

function apiTHand_end_sync(_steps, _fkill) {
	return apiTHand_timer(new ApiTimerSyncTimeout(_steps, _, _, _fkill));
}

function apiTHand_async(_milisec, _ftick, _finit, _fkill, _extType=true) {
	_extType = (_extType ? ApiTimerAsyncTimeoutExt : ApiTimerAsyncTimeout);
	return apiTHand_timer(new _extType(_milisec, _ftick, _finit, _fkill));
}

function apiTHand_end_async(_milisec, _fkill) {
	return apiTHand_timer(new ApiTimerAsyncTimeout(_milisec, _, _, _fkill));
}

function apiTHand_loop(_ftick, _finit, _fkill) {
	return apiTHand_timer(new ApiTimerLoop(_ftick, _finit, _fkill));
}

function apiTHand_isBind(_timer) {
	return global.__apiTimerHandler.isBind(_timer);
}

#endregion

