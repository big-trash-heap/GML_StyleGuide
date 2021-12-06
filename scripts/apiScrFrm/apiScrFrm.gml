
#macro API_FRM_CHAR	37 /* ord('%') */

/// @function		apiFrm(string_format, ...args);
/// @description	Формат строки
function apiFrm(_string) {
	
	static _buffer = ____API_GL_TXTBUF;
	
	var _size = string_length(_string);
	var _i = 1, _j = 1, _a = 1, _k;
	for (; _i <= _size; ++_i) {
		
		if (string_ord_at(_string, _i) == API_FRM_CHAR) {
			
			_k = _i - _j;
			if (_k > 0)
				apiBufTxtAppend(_buffer, string_copy(_string, _j, _k));
			
			if (string_ord_at(_string, _i + 1) != API_FRM_CHAR) {
				
				apiBufTxtAppend(_buffer, string(argument[_a++]));
			}
			else {
				apiBufTxtAppend(_buffer, "%");
			}
			
			_j = ++_i + 1;
		}
	}
	
	_k = _i - _j;
	if (_k > 0)
		apiBufTxtAppend(_buffer, string_copy(_string, _j, _k));
	
	return ____API_GL_TXTBUF_READ;
}

