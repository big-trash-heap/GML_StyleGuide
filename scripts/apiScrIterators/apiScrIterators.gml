
// f_init = function(data, index, size)
// f_iter = function(data, index, count)
/// @function apiIteratorRange(?f_init, ?f_iter, data, size|index_begin, ?index_end, ?step)
/// @param ?f_init
/// @param ?f_iter
/// @param data
/// @param size|index_begin
/// @param ?index_end
/// @param ?step
function apiIteratorRange(_fInit, _fIter, _data, _i, _j, _step) {
	if (is_undefined(_step)) {
		
		if (is_undefined(_j)) {
			_j = _i;
			_i = 0;
		}
		_step = 1;
	}
	var _signStep = sign(_step);
	if (_signStep != 0) {
		var _size = _j - _i;
		if (sign(_size) == _signStep) {
			
			_size = _size div abs(_step) * _signStep;
			var _count = -1;
			
			if (!is_undefined(_fInit)) {
				
				if (_fInit(_data, _i, _size)) {
					
					_count += 1;
					_i += _step;
				}
			}
			if (!is_undefined(_fInit)) {
				
				while (_count < _size) {
					
					_fIter(_data, _i, ++_count);
					_i += _step;
				}
			}
		}
		else {
			if (!is_undefined(_fInit)) _fInit(_data, _i, 0);
		}
	}
	else {
		if (!is_undefined(_fInit)) _fInit(_data, _i, 0);
	}
	return _data;
}

// f_init = function(data, array, size)
// f_iter = function(data, array, index)
/// @function apiIteratorArrays(?f_init, ?f_iter, data, ...array);
/// @param ?f_init
/// @param ?f_iter
/// @param data
/// @param ...array
function apiIteratorArrays(_fInit, _fIter, _data) {
	
	var _argSize = argument_count;
	if (_argSize > 0) {
		
		var _argIndex = 3;
		var _array;
		var _size, _index;
		do {
			
			_array = apiFunctorArray(argument[_argIndex]);
			_size = array_length(_array);
			_index = 0;
			
			if (!is_undefined(_fInit)) {
				
				if (_fInit(_data, _array, _size)) _index += 1;
			}
			if (!is_undefined(_fIter)) 
				for (; _index < _size; ++_index) _fIter(_data, _array, _index);
		} until (++_argIndex < _argSize);
	}
	
	return _data;
}
