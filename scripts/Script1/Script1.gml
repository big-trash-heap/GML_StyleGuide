
/*
// f = function(init, value, data)
/// @function apiArrayFold(array, f, [data], [reverse], [init]);
/// @param array
/// @param f
/// @param [data]
/// @param [reverse]
/// @param [init]
function apiArrayFold(_array, _f, _data, _reverse=false) {
    var _size = array_length(_array);
	
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


/// @function apiArrayBuildReverse(array);
/// @param array
function apiArrayBuildReverse(_array) {
	var _size = array_length(_array);
	var _newArray = array_create(_size);
	for (var _i = 0; _i < _size; ++_i) array_set(_newArray, _i, array_get(_array, --_size));
	return _newArray;
}

/// @function apiArrayBuildConcat(...array_or_value);
/// @param ...array_or_value
function apiArrayBuildConcat() {
	var _argSize = argument_count;
	var _build = [];
	if (_argSize > 0) {
		
		var _value, _jsize, _j, _temp, _size = 0;
		for (var _i = 0; _i < _argSize; ++_i) {
			_value = argument[_i];
			
			if (is_array(_value)) {
				
				_jsize = array_length(_value);
				_temp = _size + _jsize;
				
				array_resize(_build, _temp);
				
				for (_j = 0; _j < _jsize; _j++) array_set(_build, _size + _j, _value[_j]);
				
				_size = _temp;
			}
			else {
				_size += 1;
				array_push(_build, _value);
			}
		}
	}
	return _build;
}


/// @function apiArrayReverse(array);
/// @param array
function apiArrayReverse(_array) {
	var _size = array_length(_array);
	if (_size > 1) {
        var _swap, _i = -1;
        repeat (_size div 2) {
        	
            _swap = array_get(_array, ++_i);
            array_set(_array, _i, array_get(_array, --_size));
            array_set(_array, _size, _swap);
        }
    }
}

/// @function apiArrayClear(array, sizeup);
/// @param array
/// @param sizeup
function apiArrayResizeUp(_array, _sizeup) {
	array_resize(_array, array_length(_array) + _sizeup);
}

/// @function apiArrayClear(array);
/// @param array
function apiArrayClear(_array) {
	array_resize(_array, 0);
}

/// @function apiArrayPlaceExt(array, [index], ...array_or_value);
/// @param array
/// @param [index]
/// @param ...array_or_value
function apiArrayPlaceExt(_array, _index) {
	var _argSize = argument_count;
	if (_argSize > 2) {
		
		var _value, jsize, _j, _temp;
		var baseSize = array_length(_array);
		var _size = (is_undefined(_index) ? baseSize : _index);
		
		for (var _i = 2; _i < _argSize; ++_i) {
			_value = argument[_i];
			
			if (is_array(_value)) {
				
				jsize = array_length(_value);
				_temp  = _size + jsize;
				array_resize(_array, max(_temp, baseSize));
				
				for (_j = 0; _j < jsize; ++_j) array_set(_array, _size + _j, _value[_j]);
				
				_size = _temp;
			} 
			else {
				
				array_set(_array, _size, _value);
				_size += 1;
			}
		}
	}
}

/// @function apiArrayShift(array)
/// @param array
function apiArrayShift(_array) {
    if (array_length(_array)) {
		
        var _value = array_get(_array, 0);
        array_delete(_array, 0, 1);
        return _value;
    }
    return undefined;
}

/// @function apiArrayEmpty(array);
/// @param array
function apiArrayEmpty(_array) {
	return (array_length(_array) == 0);
}

// f = function(init, value, data)
/// @function apiArrayFold(array, f, [data], [reverse], [init]);
/// @param array
/// @param f
/// @param [data]
/// @param [reverse]
/// @param [init]
function apiArrayFold(_array, _f, _data, _reverse=false) {
    var _size = array_length(_array);
	
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


// show_debug_message("1");
// show_message("heI")