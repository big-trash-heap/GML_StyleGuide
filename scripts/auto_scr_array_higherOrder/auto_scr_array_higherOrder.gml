

#region modify

// f = function(value, index, data)
/// @function apiArrayMap(array, f, _data);
/// @param array
/// @param f
/// @param _data
function apiArrayMap(_array, f, _data) {
	var _size = array_length(_array);
	for (var i = 0; i < _size; i += 1) array_set(_array, i, f(_array[i], i, _data));
}

// f = function(value, index, data)
/// @function apiArrayFilter(array, f, _data);
/// @param array
/// @param f
/// @param _data
function apiArrayFilter(_array, f, _data) {
	apiArrayFill(_array, apiBuildFilter(_array, f, _data));
}

#endregion

#region build

// f = function(value, index, data)
/// @function apiArrayBuildMap(array, f, _data);
/// @param array
/// @param f
/// @param _data
function apiArrayBuildMap(_array, f, _data) {
	var _size = array_length(_array);
	var _dups = array_create(_size);
	for (var i = 0; i < _size; i += 1) array_set(_dups, i, f(_array[i], i, _data));
	return _dups;
}

// f = function(value, index, data)
/// @function apiBuildFilter(array, f, _data);
/// @param array
/// @param f
/// @param _data
function apiBuildFilter(_array, f, _data) {
	var _size = array_length(_array), _new_array = [];
    if (_size > 0) {
        var i = 0, _value;
        do {
            _value = _array[i];
            if (f(_value, i, _data)) array_push(_new_array, _value);
        } until (++i == _size);
    }
}

#endregion

#region iterator

// f = function(value, index, data, _array)
function array_foreach(_array, f, _data, _reverse, _index, _step) {
	var _size = array_length(_array);
    if (_size--) {
        
		var result = {index: -1, data: _data};
		
		if (is_undefined(_reverse)) _reverse = false;
        if (is_undefined(_index)) {
			
			_index = (_reverse ? _size : 0);
		} else {
			
            if (_index < 0 or _index > _size) return result;
        }
        if (is_undefined(_step)) {
			
			_step = 1;
		} else {
			
            if (_step < 1) return result;
        }
        if (_reverse) {
            do {
				
				if (f(_array[_index], _index, _data, _array)) {
					
					result.index = _index;
					return result;
				}
				
                _index -= _step;
            } until (_index < 0);
        } else {
            do {
				
                if (f(_array[_index], _index, _data, _array)) {
					
					result.index = _index;
					return result;
				}
				
                _index += _step;
            } until (_index > _size);
        }
    }
    return result;
}

// f = function(init, value, data)
 /// @function array_fold(_array, f, _data, _reverse, _init);
function array_fold(_array, f, _data, _reverse) {
    var _size = array_length(_array);
	
	if (is_undefined(_reverse)) _reverse = false;
	
    var _init;
    if (_reverse) {
        _init = (argument_count > 4 ? argument[4] : _array[--_size]);
        while (_size--) _init = f(_init, _array[_size], _data);
    } else {
        var _i = -1;
        _init = (argument_count > 4 ? argument[4] : _array[++_i]);
        while (++_i < _size) _init = f(_init, _array[_i], _data);
    }
    return _init;
}

#endregion

#region find

// f = function(value, index, data, _array)
function array_find(_array, f, _data, _reverse, _index, _step) {
	return array_foreach(_array, f, _data, _reverse, _index, _step).index;
}

#endregion
