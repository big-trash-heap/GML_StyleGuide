

#region modify

// f = function(value, index, data)
/// @function apiArrayMap(array, f, ?data);
/// @param array
/// @param f
/// @param ?data
function apiArrayMap(_array, _f, _data) {
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; _i += 1) array_set(_array, _i, _f(_array[_i], _i, _data));
}

// f = function(value, index, data)
/// @function apiArrayFilter(array, f, ?data);
/// @param array
/// @param f
/// @param ?data
function apiArrayFilter(_array, _f, _data) {
	apiArrayFill(_array, apiArrayBuildFilter(_array, _f, _data));
	// TODO: filtration optimize
}

#endregion

#region build

// f = function(value, index, data)
/// @function apiArrayBuildMap(array, f, ?data);
/// @param array
/// @param f
/// @param ?data
function apiArrayBuildMap(_array, _f, _data) {
	var _size = array_length(_array);
	var _dups = array_create(_size);
	for (var _i = 0; _i < _size; _i += 1) array_set(_dups, _i, _f(_array[_i], _i, _data));
	return _dups;
}

// f = function(value, index, data)
/// @function apiArrayBuildFilter(array, f, ?data);
/// @param array
/// @param f
/// @param ?data
function apiArrayBuildFilter(_array, _f, _data) {
	var _size = array_length(_array);
	var _newArray = array_create(_size);
    if (_size > 0) {
        var _i = 0, _value;
        do {
            _value = _array[_i];
            if (_f(_value, _i, _data)) array_push(_newArray, _value);
        } until (++_i == _size);
    }
    return _newArray;
}

#endregion

#region iterator

// f = function(array, index, data)
/// @function apiArrayForEach(array, f, ?data);
/// @param array
/// @param f
/// @param ?data
function apiArrayForEach(_array, _f, _data) {
	
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i)
		if (_f(_array, _i, _data)) return _i;
	
	return _i;
}

// f = function(array, index, data)
/// @function apiArrayForStep(array, f, ?data, ?step, ?index);
/// @param array
/// @param f
/// @param ?data
/// @param ?step
/// @param ?index
function apiArrayForStep(_array, _f, _data, _step, _index) {
	var _size = array_length(_array);
    if (_size--) {
        
		if (is_undefined(_step)) _step = 1;
		var _reverse = (sign(_step) == -1);
		
        if (is_undefined(_index)) _index = (_reverse ? _size : 0);
        if (_reverse) {
            do {
				
				if (_f(_array, _index, _data)) return _index;
				
                _index += _step;
            } until (_index < 0);
        } 
        else {
            do {
				
                if (_f(_array, _index, _data)) return _index;
				
                _index += _step;
            } until (_index > _size);
        }
    }
    return -1;
}

// f = function(init, value, data)
/// @function apiArrayFold(array, f, ?data, ?reverse, ?init);
/// @param array
/// @param f
/// @param ?data
/// @param ?reverse
/// @param ?init
function apiArrayFold(_array, _f, _data, _reverse) {
    var _size = array_length(_array);
	
	if (is_undefined(_reverse)) _reverse = false;
	
    var _init;
    if (_reverse) {
        _init = (argument_count > 4 ? argument[4] : _array[--_size]);
        while (_size--) _init = _f(_init, _array[_size], _data);
    } else {
        var _i = -1;
        _init = (argument_count > 4 ? argument[4] : _array[++_i]);
        while (++_i < _size) _init = _f(_init, _array[_i], _data);
    }
    return _init;
}

#endregion
