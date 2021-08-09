


function apiStringReplace(_substring, _string, _index, _count) {
	return (
		string_copy(_string, 1, _index - 1) +
		_substring +
		string_delete(_string, 1, _index + _count - 1)
	);
}

function apiStringFindBalance(_string, _left_ord, _right_ord, _index=1) {
	
	var _type = string_ord_at(_string, _index), _limit;
	if (_type == _left_ord) {
		
		_type = 1;
		_limit = string_length(_string) + 1;
	}
	else
	if (_type == _right_ord) {
		
		_type      = _left_ord;
		_left_ord  = _right_ord;
		_right_ord = _type;
		
		_type = -1;
		_limit = 0;
	}
	else {
		return 0;
	}
	
	_index += _type;
	var _ord, _count = 1;
	while (_index != _limit) {
			
		_ord = string_ord_at(_string, _index);
		if (_ord == _left_ord)
			_count += 1;
		else
		if (_ord == _right_ord) {
				
			if (_count == 1) return _index;
			_count -= 1;
		}
			
		_index += _type;
	}
	return 0;
}

function apiStringFormat(_textbuf, _ord=37, _handler=string, _string) {
	
	var _size = string_length(_string);
	var _i = 1, _j = 1, _a = 4, _k;
	for (; _i <= _size; ++_i) {
		
		if (string_ord_at(_string, _i) == _ord) {
			
			_k = _i - _j;
			if (_k > 0)
				apiBufTxtPush(_textbuf,
					string_copy(_string, _j, _k),
					_handler(argument[_a++])
				);
			
			_j = _i + 1;
		}
	}
	
	_k = _i - _j;
	if (_k > 0)
		apiBufTxtAppend(_textbuf, string_copy(_string, _j, _k));
}

