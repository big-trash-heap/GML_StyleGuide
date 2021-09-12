
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
#macro API_GL_TXTBUF_RESZ_CFD	1.75
#macro API_GL_TXTBUF_RESZ_PRC	48

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
			mean(
				round(global.__apiTxtBuffer_size / global.__apiTxtBuffer_iter),
				round(global.__apiTxtBuffer_size / API_GL_TXTBUF_RESZ_PRC),
			),
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

