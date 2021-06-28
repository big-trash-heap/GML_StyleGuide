
/*
	Тестируется в "auto_test_array"
*/


#region modify

/// @function apiArrayPlace(array, arrayFill)
/// @param array
/// @param arrayFill
function apiArrayFill(_array, _arrayFill) {
	var _size = array_length(_arrayFill);
    array_resize(_array, _size);
	array_copy(_array, 0, _arrayFill, 0, _size);
	return _array;
}

/// @function apiArrayPlace(array, index, ...value);
/// @param array
/// @param index
/// @param ...value
function apiArrayPlace(_array, _index) {
	var _count = argument_count - 2;
	if (_count > 0) {
		
		var _size = array_length(_array);
		if (is_undefined(_index)) _index = _size;
		
		array_resize(_array, max(_size, _index + _count));
		for (var i = 0; i < _count; i++) array_set(_array, _index + i, argument[i + 2]);
	}
}

/// @function apiArrayPlaceExt(array, index, ...arrayOrValue);
/// @param array
/// @param index
/// @param ...arrayOrValue
function apiArrayPlaceExt(_array, _index) {
	if (argument_count > 2) {
		
		var _value, jsize, j, _temp;
		var baseSize = array_length(_array);
		var _size = (is_undefined(_index) ? baseSize : _index);
		
		for (var i = 2; i < argument_count; i++) {
			_value = argument[i];
			
			if (is_array(_value)) {
				
				jsize = array_length(_value);
				_temp  = _size + jsize;
				array_resize(_array, max(_temp, baseSize));
				
				for (j = 0; j < jsize; j++) array_set(_array, _size + j, _value[j]);
				
				_size = _temp;
			} else {
				
				array_set(_array, _size, _value);
				_size += 1;
			}
		}
	}
}

/// @function apiArrayInsertEmpty(array, index, count, _value);
/// @param array
/// @param index
/// @param count
/// @param _value
function apiArrayInsertEmpty(_array, _index, _count) {
    if (_count > 0) {
		
        var _length = array_length(_array), _size = _length - _index, _insert = (_size > 0);
        array_resize(_array, max(_length, _index + _count));
		
        if (_insert) {
			
            var shift = _index + _count;
            while (_size--) array_set(_array, _size + shift, array_get(_array, _size + _index));
        }
        if (argument_count > 3) {
            if (_insert) {
                
				while (_count--) array_set(_array, _index + _count, argument[3]);
                return true;
            }
            
			_size = array_length(_array);
            _length -= 1;
            while (++_length < _size) array_set(_array, _length, argument[3]);
        }
        return true;
    }
    return false;
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

/// @function apiArrayUnshift(array, ...value);
/// @param array
/// @param ...value
function apiArrayUnshift(_array) {
    if (apiArrayInsertEmpty(_array, 0, argument_count - 1)) {
		
        var i = 0;
        while (++i < argument_count) array_set(_array, i - 1, argument[i]);
		
		return (argument_count - 1);
    }
	return 0;
}

/// @function apiArrayShuffle(array);
/// @param array
function apiArrayShuffle(_array) {
    var _size = array_length(_array);
    if (_size > 1) {
		
        var i = -1, _swap, j;
        while (++i < _size) {
			
            j = irandom(_size - 1);
            _swap = array_get(_array, i);
            array_set(_array, i, array_get(_array, j));
            array_set(_array, j, _swap);
        }
	}
}

/// @function apiArrayClear(array);
/// @param array
function apiArrayClear(_array) {
	array_resize(_array, 0);
}

/// @function apiArrayClear(array, sizeup);
/// @param array
/// @param sizeup
function apiArrayResizeUp(_array, _sizeup) {
	array_resize(_array, array_length(_array) + _sizeup);
}

/// @function apiArrayCopy(dest, scr, _dest_index, _src_index, _length);
/// @param dest
/// @param src
/// @param _dest_index
/// @param _src_index
/// @param _length
function apiArrayCopy(_dest, _src, _dest_index, _src_index, _length) {
    var _dest_length = array_length(_dest);
    var _src_length = array_length(_src);
    if (is_undefined(_dest_length)) _dest_index = _dest_length;
    if (is_undefined(_src_index))   _src_index  = 0;
    if (is_undefined(_length)) {
		
		_length = _src_length - _src_index;
	} else {
		
		_length = min(_length, _src_length - _src_index);
	}
    if (_length > 0) {
		
        array_resize(_dest, max(_dest_length, _dest_index + _length));
        if (_dest == _src) {
			
            if (_dest_index == _src_index) exit;
            if (_dest_index > _src_index) {
                while (_length--) array_set(_dest, _length + _dest_index, array_get(_src, _length + _src_index));
                exit;
            }
        }
        var i = 0;
        do {
            array_set(_dest, i + _dest_index, array_get(_src, i + _src_index));
        } until (++i == _length);
    }
}

/// @function apiArrayInsert(dest, scr, _dest_index, _src_index, _length);
/// @param dest
/// @param src
/// @param _dest_index
/// @param _src_index
/// @param _length
function apiArrayInsert(_dest, scr, _dest_index, _src_index, _length) {
    var _dest_length = array_length(_dest);
    var _src_length = array_length(scr);
    if (is_undefined(_dest_length)) _dest_index = 0;
    if (is_undefined(_src_index))   _src_index  = 0;
    if (is_undefined(_length)) {
		
		_length = _src_length - _src_index;
	} else {
		
		_length = min(_length, _src_length - _src_index);
	}
    if (_length > 0) {
		
        array_resize(_dest, _dest_length + _length);
        var _size = _dest_length - _dest_index;
        if (_size > 0) {
			
            var _dest_shift = _dest_index + _length;
            if (_dest == scr) {
				
                var _temp = array_create(_length), i = -1;
                while (++i < _length)  array_set(_temp, i                 , array_get(scr,   i + _src_index)); i = -1;
                while (_size--)         array_set(_dest,  _size + _dest_index, array_get(_dest,  _size + _dest_shift));
                while (++i < _length)  array_set(_dest,  i + _dest_index   , array_get(_temp, i));
                exit;
            }
            while (_size--) array_set(_dest, _size + _dest_index, array_get(_dest, _size + _dest_shift));
        }
        while (_length--) array_set(_dest, _length + _dest_index, array_get(scr , _length + _src_index));
    }
}

/// @function apiArrayReverse(array);
/// @param array
function apiArrayReverse(_array) {
	var _size = array_length(_array);
	if (_size > 1) {
        var _swap, i = -1;
        repeat (_size div 2) {
            _swap = array_get(_array, ++i);
            array_set(_array, i, array_get(_array, --_size));
            array_set(_array, _size, _swap);
        }
    }
}

/// @function apiArrayRemoveNoOrder(array, index);
/// @param array
/// @param index
function apiArrayRemoveNoOrder(_array, _index) {
	var _size = array_length(_array) - 1;
	array_set(_array, _index, array_get(_array, _size));
	array_resize(_array, _size);
}

#endregion

#region build

/// @function apiArrayBuildDup1d(array);
/// @param array
function apiArrayBuildDup1d(_array) {
	return apiArrayFill([], _array);
}

/// @function apiArrayBuildReverse(array);
/// @param array
function apiArrayBuildReverse(_array) {
	var _size = array_length(_array);
	var _new_array = array_create(_size);
	for (var i = 0; i < _size; i++) array_set(_new_array, i, array_get(_array, --_size));
	return _new_array;
}

/// @function apiArrayBuildConcat(...arrayOrValue);
/// @param ...arrayOrValue
function apiArrayBuildConcat() {
	var _build = [];
	if (argument_count > 0) {
		
		var _value, _jsize, j, _temp, _size = 0;
		for (var i = 0; i < argument_count; i++) {
			_value = argument[i];
			
			if (is_array(_value)) {
				
				_jsize = array_length(_value);
				_temp = _size + _jsize;
				
				array_resize(_build, _temp);
				
				for (j = 0; j < _jsize; j++) array_set(_build, _size + j, _value[j]);
				
				_size = _temp;
			} else {
				_size += 1;
				array_push(_build, _value);
			}
		}
	}
	return _build;
}

/// @function apiArrayBuildRange(size|indexBegin, _indexEnd, _step);
/// @param size|indexBegin
/// @param _indexEnd
/// @param _step
function apiArrayBuildRange(i, j, _step) {
	return apiIteratorRange(
		function(_array, _0, _size) {
			
			array_resize(_array, _size);
		},
		function(_array, _index, _count) {
			
			array_set(_array, _count, _index);
		}, [], i, j, _step
	);
}

#endregion

#region find

function array_find_index(_array, _value, _reverse, _index, _step) {
	return array_find(_array, generator_compare_eq(_value), undefined, _reverse, _index, _step);
}

function array_exists(_array, _value) {
	return (array_find_index(_array, _value) != -1);
}

#endregion

#region range

function array_range_get(_array, _index, _length) {
	var range = [];
	array_copy(range, 0, _array, _index, _length);
	return range;
}

function array_range_set(_array, _index, range) {
	array_ext_copy(_array, range, _index, 0, array_length(range));
}

function array_range_insert(_array, _index, range) {
	array_ext_insert(_array, range, _index, 0, array_length(range));
}

#endregion

