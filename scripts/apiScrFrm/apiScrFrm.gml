
#macro API_FRM_CHAR				37
#macro API_FRM_MODIFY_SIZE_ITER 30
#macro API_FRM_MODIFY_SIZE_CF   2.5
#macro API_FRM_MODIFY_SIZE_MINS 1024

/// @function		apiFrm(string_format, ...args);
/// @description	Формат строки
function apiFrm(_string) {
	
	static _buffer = apiBufTxtCreate(1024);
	static _msize  = 1024;
	static _iter   = 1;
	
	var _size = string_length(_string);
	var _i = 1, _j = 1, _a = 1, _k;
	for (; _i <= _size; ++_i) {
		
		if (string_ord_at(_string, _i) == API_FRM_CHAR) {
			
			_k = _i - _j;
			if (_k > 0)
				apiBufTxtAppend(_buffer, string_copy(_string, _j, _k));
			
			apiBufTxtAppend(_buffer, string(argument[_a++]));
			_j = _i + 1;
		}
	}
	
	_k = _i - _j;
	if (_k > 0)
		apiBufTxtAppend(_buffer, string_copy(_string, _j, _k));
	
	_string = apiBufTxtRead(_buffer);
	
	++_iter;
	_msize += apiBufTxtSize(_buffer);
	
	if (_iter == API_FRM_MODIFY_SIZE_ITER) {
		
		_msize = max(
			round(_msize / _iter),
			round(_msize / API_FRM_MODIFY_SIZE_CF), 
			API_FRM_MODIFY_SIZE_MINS
		);
		
		_iter  = 1;
		apiBufTxtClear(_buffer, _msize);
	}
	else {
		apiBufTxtClear(_buffer);
	}
	
	return _string;
}

