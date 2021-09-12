
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

#macro API_GL_TXTBUF_SIZE_MIN	8192
#macro API_GL_TXTBUF_RESZ_CFD	2.25

global.__apiTxtBuffer      = apiBufTxtCreate(API_GL_TXTBUF_SIZE_MIN);
global.__apiTxtBuffer_size = 0;
global.__apiTxtBuffer_iter = 0;

function __apiGLTxtBufRead() {
	
	static _buffer = API_GL_TXTBUF;
	
	global.__apiTxtBuffer_size += apiBufTxtSize(_buffer);
	++global.__apiTxtBuffer_iter;
	
	var _string = apiBufTxtCRead(_buffer);
	if (global.__apiTxtBuffer_size > API_MACRO_UINT16_MAX) {
		
		var _size = max(
			round(global.__apiTxtBuffer_size / global.__apiTxtBuffer_iter),
			round(global.__apiTxtBuffer_size / API_GL_TXTBUF_RESZ_CFD),
			API_GL_TXTBUF_SIZE_MIN
		);
		
		global.__apiTxtBuffer_size = 0;
		global.__apiTxtBuffer_iter = 0;
		
		apiBufTxtClear(_buffer, _size);
	}
	else {
		apiBufTxtClear(_buffer);
	}
	return _string;
}

#endregion

