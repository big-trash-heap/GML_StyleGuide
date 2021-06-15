
#region modify

function array_presset(array, arrayPresset) {
	var size = array_length(arrayPresset);
    array_resize(array, size);
	array_copy(array, 0, arrayPresset, 0, size);
}

/// @function array_place(array, index, ...value);
function array_place(array, index) {
	var count = argument_count - 2;
	if (count > 0) {
		
		array_resize(array, max(array_length(array), index + count));
		for (var i = 0; i < count; i++) array_set(array, index + i, argument[i + 1]);
		
		return count;
	}
	return 0;
}

/// @function array_place_concat(array, ...arrayOrValue);
function array_place_concat(array) {
	if (argument_count > 1) {
		
		var value, jsize, j, temp;
		var size = array_length(array);
		var count = size;
		
		for (var i = 1; i < argument_count; i++) {
			value = argument[i];
			
			if (is_array(value)) {
				
				jsize = array_length(jsize);
				temp = size + jsize;
				
				array_resize(array, temp);
				
				for (j = 0; j < jsize; j++) array_set(array, size + j, value[j]);
				
				size = temp;
			} else {
				size += 1;
				array_push(array, value);
			}
		}
		
		return (array_length(array) - count);
	}
	return 0;
}

/// @function array_insert_row(array, index, count, _value);
function array_insert_row(array, index, count) {
    if (count > 0) {
		
        var length = array_length(array), size = length - index, _insert = (size > 0);
        array_resize(array, max(length, index + count));
		
        if (_insert) {
			
            var shift = index + count;
            while (size--) array_set(array, size + index, array_get(array, size + shift));
        }
        if (argument_count > 3) {
            if (_insert) {
                
				while (count--) array_set(array, index + count, argument[3]);
                return true;
            }
            
			size = array_length(array);
            length -= 1;
            while (++length < size) array_set(array, length, argument[3]);
        }
        return true;
    }
    return false;
}

function array_shift(array) {
    if (array_length(array)) {
		
        var _value = array_get(array, 0);
        array_delete(array, 0, 1);
        return _value;
    }
    return undefined;
}

/// @function array_unshift(array, ...value);
function array_unshift(array) {
    if (array_insert_row(array, 0, argument_count - 1)) {
		
		var size = array_length(array);
        var i = 0;
        while (++i < argument_count) array_set(array, i - 1, argument[i]);
		
		return (array_length(array) - size);
    }
	return 0;
}

function array_shuffle(array) {
    var size = array_length(array);
    if (size > 1) {
		
        var i = -1, swap, j;
        while (++i < size) {
			
            j = irandom(size - 1);
            swap = array_get(array, i);
            array_set(array, i, array_get(array, j));
            array_set(array, j, swap);
        }
	}
}

function array_clear(array) {
	array_resize(array, 0);
}

function array_resizeup(array, sizeup) {
	array_resize(array, array_length(array) + sizeup);
}

function array_ext_copy(dest, src, _dest_index, _src_index, _length) {
    var dest_length = array_length(dest);
    var src_length = array_length(src);
    if (is_undefined(dest_length)) _dest_index = dest_length;
    if (is_undefined(_src_index))  _src_index  = 0;
    if (is_undefined(_length)) {
		
		_length = src_length - _src_index;
	} else {
		
		_length = min(_length, src_length - _src_index);
	}
    if (_length > 0) {
		
        array_resize(dest, max(dest_length, _dest_index + _length));
        if (dest == src) {
			
            if (_dest_index == _src_index) exit;
            if (_dest_index > _src_index) {
                while (_length--) array_set(dest, _length + _dest_index, array_get(src, _length + _src_index));
                exit;
            }
        }
        var i = 0;
        do {
            array_set(dest, i + _dest_index, array_get(src, i + _src_index));
        } until (++i == _length);
    }
}

function array_ext_insert(dest, scr, _dest_index, _src_index, _length) {
    var _dest_length = array_length(dest);
    var _src_length = array_length(scr);
    if (is_undefined(_dest_length)) _dest_index = 0;
    if (is_undefined(_src_index))   _src_index  = 0;
    if (is_undefined(_length)) {
		
		_length = _src_length - _src_index;
	} else {
		
		_length = min(_length, _src_length - _src_index);
	}
    if (_length > 0) {
		
        array_resize(dest, _dest_length + _length);
        var size = _dest_length - _dest_index;
        if (size > 0) {
			
            var _dest_shift = _dest_index + _length;
            if (dest == scr) {
				
                var _temp = array_create(_length), i = -1;
                while (++i < _length)  array_set(_temp, i                  , array_get(scr,   i + _src_index)); i = -1;
                while (size--)        array_set(dest,  size + _dest_index, array_get(dest,  size + _dest_shift));
                while (++i < _length)  array_set(dest,  i + _dest_index    , array_get(_temp, i));
                exit;
            }
            while (size--) array_set(dest, size + _dest_index, array_get(dest, size + _dest_shift));
        }
        while (_length--) array_set(dest, _length + _dest_index, array_get(scr , _length + _src_index));
    }
}

function array_reverse(array) {
	var size = array_length(array);
	if (size > 1) {
        var _swap, i = -1;
        repeat (size div 2) {
            _swap = array_get(array, ++i);
            array_set(array, i, array_get(array, --size));
            array_set(array, size, _swap);
        }
    }
}

#endregion

#region build

function array_build_dup1d(array) {
	return array_presset([], array);
}

function array_build_reverse(array) {
	var size = array_length(array);
	var _new_array = array_create(size);
	for (var i = 0; i < size; i++) array_set(_new_array, i, array_get(array, --size));
	return _new_array;
}

#endregion

#region find

function array_find_index(array, value, _reverse, _index, _step) {
	return array_find(array, GeneratorCompareEq(value), undefined, _reverse, _index, _step);
}

function array_exists(array, value) {
	return (array_find_index(array, value) != -1);
}

#endregion
