

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
	
	var _size = array_length(_array);
    if (_size > 0) {
		
		var _count = 0;
		do {
			
			_size -= 1;
			if (_f(_array[_size], _size, _data)) {
				
				array_delete(_array, _size + 1, _count);
				_count = 0;
			}
			else {

				_count += 1;
			}
		} until (_size == 0);
		array_delete(_array, 0, _count);
    }
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
	
	for (var _i = 0; _i < _size; _i += 1) 
		array_set(_dups, _i, _f(_array[_i], _i, _data));
	
	return _dups;
}

// f = function(value, index, data)
/// @function apiArrayBuildFilter(array, f, ?data);
/// @param array
/// @param f
/// @param ?data
function apiArrayBuildFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _newArray = [];
    
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

#region other

// f = function(value, index, data)
/// @function apiArrayCall(array, f, [data]);
/// @param array
/// @param f
/// @param [data]
function apiArrayCall(_array, _f, _data) {
	
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i) 
		_f(_array[_i], _i, _data);
}

#endregion
