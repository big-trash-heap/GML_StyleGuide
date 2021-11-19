

#region once

if (variable_global_exists("__apiTxtBuffer")) exit;

#endregion

#region getter

function __apiGLGetter(_name) {
	
	static _once = apiScrGlobals();
	return variable_global_get(_name);
}

#endregion


#region apiTxtBuffer

#macro API_GL_TXTBUF			__apiGLGetter("__apiTxtBuffer")
#macro API_GL_TXTBUF_READ		__apiGLTxtBufRead()

#macro API_GL_TXTBUF_SIZE_MIN	2048
#macro API_GL_TXTBUF_RESZ_PRC	60

global.__apiTxtBuffer      = apiBufTxtCreate(API_GL_TXTBUF_SIZE_MIN);
global.__apiTxtBuffer_size = 0;
global.__apiTxtBuffer_iter = 0;

function __apiGLTxtBufRead() {
	
	static _buffer = API_GL_TXTBUF;
	
	global.__apiTxtBuffer_size += apiBufTxtSize(_buffer);
	++global.__apiTxtBuffer_iter;
	
	var _string = apiBufTxtCRead(_buffer);
	if (global.__apiTxtBuffer_size > 131072) {
		
		var _size = max(
			round(global.__apiTxtBuffer_size / global.__apiTxtBuffer_iter),
			API_GL_TXTBUF_SIZE_MIN
		);
		
		var _bufsize = buffer_get_size(_buffer);
		if (_bufsize > _size) {
			
			var _percent = _size / _bufsize * 100;
			if (_percent <= API_GL_TXTBUF_RESZ_PRC) {
				
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

#region apiTimeSync

#macro API_TIME_SYNC	__apiTimeSync_get()
#macro API_TIME_SYNC_RS	__apiTimeSyncRS_get()

#macro API_TIME_SYNC_LM	API_MACRO_INT32_MAX

global.__apiTimeSync   = 0;
global.__apiTimeSyncRS = 0;

function __apiTimeSync_get() {
	static _once = apiScrGlobals();
	return global.__apiTimeSync;
}

function __apiTimeSyncRS_get() {
	static _once = apiScrGlobals();
	return global.__apiTimeSyncRS;
}

function __apiTimeSyncIter() {
	
	if (++global.__apiTimeSync >= API_TIME_SYNC_LM) {
		global.__apiTimeSync = 0;
	}
	
	if (++global.__apiTimeSyncRS >= room_speed) {
		global.__apiTimeSyncRS = 0;
	}
}

#endregion

#region apiTimeAsync

#macro API_TIME_ASYNC_STEP	__apiTimeAsync()

global.__apiTimeAsync_s0 = current_time;
global.__apiTimeAsync_s1 = global.__apiTimeAsync_s0;
global.__apiTimeAsync_sd = 0;

function __apiTimeAsync() {
	static _once = apiScrGlobals();
	return global.__apiTimeAsync_sd;
}

function __apiTimeAsyncIter() {
	global.__apiTimeAsync_s1 = global.__apiTimeAsync_s0;
	global.__apiTimeAsync_s0 = current_time;
	global.__apiTimeAsync_sd = global.__apiTimeAsync_s0 - global.__apiTimeAsync_s1;
}

#endregion

