
function apiFrm(_string) {
	
	static _buffer = apiBufTxtCreate(1024);
	static _msize  = 1024;
	static _iter   = 1;
	
	var _size = string_length(_string);
	var _i = 1, _j = 1, _a = 1, _k;
	for (; _i <= _size; ++_i) {
		
		if (string_ord_at(_string, _i) == 37) {
			
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
	
	if (_iter == 30) {
		
		_msize = max(_msize div _iter, _msize div 3);
		_iter  = 1;
		
		apiBufTxtClear(_buffer, _msize);
	}
	else {
		apiBufTxtClear(_buffer);
	}
	
	return _string;
}

