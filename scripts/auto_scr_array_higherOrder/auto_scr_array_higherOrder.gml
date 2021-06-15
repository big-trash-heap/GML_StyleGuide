

#region modify

// f = function(value, index, data)
function array_map(array, f, _data) {
	var size = array_length(array);
	for (var i = 0; i < size; i += 1) array_set(array, i, f(array[i], i, _data));
}

// f = function(value, index, data)
function array_filter(array, f, _data) {
	array_presset(array, array_build_filter(array, f, _data));
}

#endregion

#region build

// f = function(value, index, data)
function array_build_map(array, f, _data) {
	var size = array_length(array);
	var dups = array_create(size);
	for (var i = 0; i < size; i += 1) array_set(dups, i, f(array[i], i, _data));
	return dups;
}

// f = function(value, index, data)
function array_build_filter(array, f, _data) {
	var size = array_length(array), _new_array = [];
    if (size > 0) {
        var i = 0, _value;
        do {
            _value = array[i];
            if (f(_value, i, _data)) array_push(_new_array, _value);
        } until (++i == size);
    }
}

#endregion

#region iterator

// f = function(value, index, data, array)
function array_foreach(array, f, _data, _reverse, _index, _step) {
	var size = array_length(array);
    if (size--) {
        
		var result = {index: -1, data: _data};
		
		if (is_undefined(_reverse)) _reverse = false;
        if (is_undefined(_index)) {
			
			_index = (_reverse ? size : 0);
		} else {
			
            if (_index < 0 or _index > size) return result;
        }
        if (is_undefined(_step)) {
			
			_step = 1;
		} else {
			
            if (_step < 1) return result;
        }
        if (_reverse) {
            do {
				
				if (f(array[_index], _index, _data, array)) {
					
					result.index = _index;
					return result;
				}
				
                _index -= _step;
            } until (_index < 0);
        } else {
            do {
				
                if (f(array[_index], _index, _data, array)) {
					
					result.index = _index;
					return result;
				}
				
                _index += _step;
            } until (_index > size);
        }
    }
    return result;
}

#endregion

#region find

// f = function(value, index, data, array)
function array_find(array, f, _data, _reverse, _index, _step) {
	return array_foreach(array, f, _data, _reverse, _index, _step).index;
}

#endregion

