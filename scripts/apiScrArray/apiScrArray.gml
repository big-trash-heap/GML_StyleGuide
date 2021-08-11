

#region modify

/// @function		apiArrPlace(array, [index=size], ...value);
/// @description	Заменят (и добавляет) элементы в массиве
function apiArrPlace(_array, _index) {
	var _count = argument_count - 2;
	if (_count > 0) {
		
		var _size = array_length(_array);
		if (is_undefined(_index)) _index = _size;
		
		array_resize(_array, max(_size, _index + _count));
		for (var _i = 0; _i < _count; ++_i) array_set(_array, _index + _i, argument[_i + 2]);
	}
}

/// @function		apiArrInsEm(array, index, count, [value]);
/// @description	Смещает элементы в массиве и устанавливает
//					значение value (если указанно) на их место
function apiArrInsEm(_array, _index, _count) {
    if (_count > 0) {
		
        var _length = array_length(_array);
		var _size   = _length - _index;
		var _insert = (_size > 0);
		
        array_resize(_array, max(_length, _index + _count));
		
        if (_insert) {
			
			// сдвиг элементов
            var shift = _index + _count;
            while (_size--) array_set(_array, _size + shift, array_get(_array, _size + _index));
        }
        if (argument_count > 3) {
            if (_insert) {
                
				// закраска элементов если вставили внутрь массива
				while (_count--) array_set(_array, _index + _count, argument[3]);
                return true;
            }
            
			// закраска элементов если вставили за пределы массива
			_size = array_length(_array);
            _length -= 1;
            while (++_length < _size) array_set(_array, _length, argument[3]);
        }
        return true;
    }
    return false;
}

/// @description	Удалит и вернёт первый элемент массива
//					Если элементов нету, вернёт undefined
//
/// @param			array
function apiArrShift(_array) {
    if (array_length(_array)) {
		
        var _value = array_get(_array, 0);
        array_delete(_array, 0, 1);
        return _value;
    }
    return undefined;
}

/// @function		apiArrUnshift(array, ...value);
/// @description	Вставит элементы в начало массива
function apiArrUnshift(_array) {
	var _argSize = argument_count;
    if (apiArrInsEm(_array, 0, _argSize - 1)) {
		
        var _i = 0;
        while (++_i < _argSize) 
			array_set(_array, _i - 1, argument[_i]);
		
		return (_argSize - 1);
    }
	return 0;
}

/// @param			array
function apiArrShuffle(_array) {
    var _size = array_length(_array);
    if (_size > 1) {
		
        var _i = -1, _swap, _j;
        while (++_i < _size) {
			
            _j = irandom(_size - 1);
            _swap = array_get(_array, _i);
            array_set(_array, _i, array_get(_array, _j));
            array_set(_array, _j, _swap);
        }
	}
}

/// @function		apiArrCop(dest, dest_index, src, [src_index=0], [length=max]);
/// @description	Аналог array_copy, поддерживающий копирование 
//					в двух одинаковых (по ссылкам) массивам
function apiArrCop(_dest, _destIndex, _src, _srcIndex=0, _length) {
	
    if (is_undefined(_length)) _length = array_length(_src) - _srcIndex;
    if (_length > 0) {
		
        array_resize(_dest, max(array_length(_dest), _destIndex + _length));
        if (_dest == _src) {
			
            if (_destIndex == _srcIndex) exit;
            if (_destIndex > _srcIndex) {
            	
				// копирование с конца
				// так работает array_copy
            	do {
            		_length -= 1;
            		array_set(_dest, _length + _destIndex, array_get(_src, _length + _srcIndex));
            	} until (_length <= 0);
                exit;
            }
        }
		
		// копирование с начала
        var _i = 0;
        do {
            array_set(_dest, _i + _destIndex, array_get(_src, _i + _srcIndex));
        } until (++_i == _length);
    }
}

/// @function		apiArrIns(dest, dest_index, src, [src_index=0], [length=max]);
/// @description	Вставка элементов, поддерживает вставку из
//					двух одинаковых (по ссылкам) массивам
function apiArrIns(_dest, _destIndex, _src, _srcIndex=0, _length) {
	
    if (is_undefined(_length)) _length = array_length(_src) - _srcIndex;
    if (_length > 0) {
		
		var _destLength = array_length(_dest);
        var _size = _destLength - _destIndex;
		array_resize(_dest, _destLength + _length);
		
        if (_size > 0) {
			
            var _destShift = _destIndex + _length;
            if (_dest == _src) {
				
                var _temp = array_create(_length), _i = -1;
                while (++_i < _length) array_set(_temp, _i,                 array_get(_src, _i + _srcIndex));
                while (_size--)        array_set(_dest, _size + _destShift, array_get(_dest, _size + _destIndex));
				
                _i = -1;
                while (++_i < _length) array_set(_dest, _i + _destIndex,    array_get(_temp, _i));
                exit;
            }
			// сдвиг элементов
            do {
				_size -= 1;
            	array_set(_dest, _size + _destShift, array_get(_dest, _size + _destIndex));
            } until (_size == 0);
        }
		// заливка элементов
        do {
        	_length -= 1;
        	array_set(_dest, _length + _destIndex, array_get(_src, _length + _srcIndex));
        } until (_length == 0);
    }
}

/// @function		apiArrRemNOrd(array, index);
/// @description	Удаляет элемент меняя его местами с последним
function apiArrRemNOrd(_array, _index) {
	var _size = array_length(_array) - 1;
	array_set(_array, _index, array_get(_array, _size));
	array_resize(_array, _size);
}

#endregion

#region build

/// @function		apiArrBul(...value);
function apiArrBul() {
	var _argSize  = argument_count;
	var _arrayBul = array_create(_argSize);
	for (var _i = 0; _i < _argSize; ++_i) 
		array_set(_arrayBul, _i, argument[_i]);
	return _arrayBul;
}

/// @function		apiArrBulConcat(...array_or_value);
/// @description	Функция для построение массива из
//					массивов и значений
function apiArrBulConcat() {
	var _argSize  = argument_count;
	var _arrayBul = [];
	if (_argSize > 0) {
		
		var _value, _jsize, _j, _temp, _size = 0;
		for (var _i = 0; _i < _argSize; ++_i) {
			_value = argument[_i];
			
			if (is_array(_value)) {
				
				_jsize = array_length(_value);
				_temp = _size + _jsize;
				
				array_resize(_arrayBul, _temp);
				
				for (_j = 0; _j < _jsize; _j++) 
					array_set(_arrayBul, _size + _j, _value[_j]);
				
				_size = _temp;
			}
			else {
				
				_size += 1;
				array_push(_arrayBul, _value);
			}
		}
	}
	return _arrayBul;
}

/// @param			array
/// @description	Клонирование массива с глубиной 1
function apiArrBulDup1d(_array) {
	var _size = array_length(_array);
	var _arrayBul = array_create(_size);
	array_copy(_arrayBul, 0, _array, 0, _size);
	return _arrayBul;
}

#endregion

#region find

/// @function		apiArrFindInd(array, value, [index=0]);
function apiArrFindInd(_array, _value, _index=0) {
	
	var _size = array_length(_array);
	for (; _index < _size; ++_index)
		if (_array[_index] == _value) return _index;
	
	return -1;
}

/// @function		apiArrExists(array, value);
function apiArrExists(_array, _value) {
	return (apiArrFindInd(_array, _value) != -1);
}

#endregion

#region range

/// @function		apiArrRangeGet(array, index, size);
function apiArrRangeGet(_array, _index, _length) {
	var _range = array_create(_length);
	array_copy(_range, 0, _array, _index, _length);
	return _range;
}

/// @function		apiArrRangeSet(array, index, range);
function apiArrRangeSet(_array, _index, _range) {
	apiArrCop(_array, _index, _range);
}

/// @function		apiArrRangeInsert(array, index, range);
function apiArrRangeInsert(_array, _index, _range) {
	apiArrIns(_array, _index, _range);
}

#endregion


#region tests - modify + apiArrBulConcat
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrArray"
		);
		
		var _f = apiFunctorId;
		var _array;
		
		#region apiArrPlace
		
		_array = [1, 2, 3, 4, 5];
		
		apiDebugAssert(
			array_equals(_f(_array, apiArrPlace(_array)), [1, 2, 3, 4, 5]),
			"<apiArrPlace empty>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrPlace(_array, _, 8, 9)), 
				[1, 2, 3, 4, 5, 8, 9]
			),
			"<apiArrPlace push>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrPlace(_array, 0, -1, -2)), 
				[-1, -2, 3, 4, 5, 8, 9]
			),
			"<apiArrPlace replace>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrPlace(_array, 3, -4, -5)), 
				[-1, -2, 3, -4, -5, 8, 9]
			),
			"<apiArrPlace replace>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrPlace(_array, 4, 0, 1, 2, 3, 4)), 
				[-1, -2, 3, -4, 0, 1, 2, 3, 4]
			),
			"<apiArrPlace resize>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrPlace(_array, 8, 0, 8, 16)), 
				[1, 2, 3, 4, 0, 0, 0, 0, 
					0, 8, 16]
			),
			"<apiArrPlace out>"
		);
		
		show_debug_message("\t apiArrPlace \t\tis work");
		
		#endregion
		
		#region apiArrInsEm
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrInsEm(_array, 0, 2)), 
				[1, 2, 1, 2, 3, 4, 5]
			),
			"<apiArrInsEm begin insert>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrInsEm(_array, 0, 2, -1)), 
				[-1, -1, 1, 2, 3, 4, 5]
			),
			"<apiArrInsEm begin insert and fill>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrInsEm(_array, 3, 4)), 
				[1, 2, 3, 4, 5, 0, 0, 4, 5]
			),
			"<apiArrInsEm begin insert middle>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrInsEm(_array, 3, 4, -1)), 
				[1, 2, 3, -1, -1, -1, -1, 4, 5]
			),
			"<apiArrInsEm begin insert middle and fill>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrInsEm(_array, 8, 4)), 
				[1, 2, 3, 4, 5, 0, 0, 0,
					0, 0, 0, 0]
			),
			"<apiArrInsEm begin insert out array>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrInsEm(_array, 5, 2)), 
				[1, 2, 3, 4, 5,
					0, 0]
			),
			"<apiArrInsEm push>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrInsEm(_array, 5, 2, 9)), 
				[1, 2, 3, 4, 5,
					9, 9]
			),
			"<apiArrInsEm push and fill>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrInsEm(_array, 8, 4, 9)), 
				[1, 2, 3, 4, 5, 
					9, 9, 9,
					9, 9, 9, 9]
			),
			"<apiArrInsEm begin insert out array and fill>"
		);
		
		show_debug_message("\t apiArrInsEm \t\tis work");
		
		#endregion
		
		#region apiArrUnshift
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrUnshift(_array, 8, 9)), 
				[8, 9, 1, 2, 3, 4, 5]
			),
			"<apiArrUnshift 0>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrUnshift(_array, 7, 0, 88)), 
				[7, 0, 88, 8, 9, 1, 2, 3, 4, 5]
			),
			"<apiArrUnshift 1>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrUnshift(_array)), 
				[7, 0, 88, 8, 9, 1, 2, 3, 4, 5]
			),
			"<apiArrUnshift 2>"
		);
		
		show_debug_message("\t apiArrUnshift \t\tis work");
		
		#endregion
		
		#region apiArrShuffle
		
		var _check = function(_array, _ref) {
			var _size = array_length(_array);
			var _rfsz = array_length(_ref);
			for (var _i = 0, _j; _i < _size; ++_i) {
				for (_j = 0;     _j < _rfsz; ++_j) {
					if (_array[_i] == _ref[_j]) {
						_j = -1;
						break;
					}
				}
				if (_j == -1) continue;
				return false;
			}
			return true;
		}
		var _modif;
		
		_array = [[], [], [], [], [], [], []];
		apiDebugAssert(
			_check(
				_array, _array
			),
			"<apiArrShuffle check>"
		);
		
		_modif = apiArrBulDup1d(_array);
		apiDebugAssert(
			_check(
				_array, _modif
			) && (_array != _modif),
			"<apiArrShuffle dup1d>"
		);
		
		apiDebugAssert(
			_check(
				_f(_array, apiArrShuffle(_array)),
				_modif
			),
			"<apiArrShuffle eq ref 0>"
		);
		
		apiDebugAssert(
			_check(
				_f(_array, apiArrShuffle(_array)),
				_modif
			),
			"<apiArrShuffle eq ref 1>"
		);
		
		apiDebugAssert(
			_check(
				_f(_array, apiArrShuffle(_array)),
				_modif
			),
			"<apiArrShuffle eq ref 2>"
		);
		
		var _countShuffle = 0;
		_array = [1, 2, 3, 4, 5, 6, 7, 8];
		repeat 150 {
			_modif = apiArrBulDup1d(_array);
			apiArrShuffle(_modif);
			_countShuffle += !array_equals(_array, _modif);
		}
		
		apiDebugAssert(
			_countShuffle > 0,
			"apiArrShuffle random"
		);
		
		show_debug_message("\t apiArrShuffle \t\tis work");
		
		#endregion
		
		#region apiArrCop
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 0, [1, 2, 3, 4, 5])), 
				[1, 2, 3, 4, 5]
			),
			"<apiArrCop 0>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 0, [8, 1, 2, 4, 2])), 
				[8, 1, 2, 4, 2]
			),
			"<apiArrCop 1>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 0, [0, 15, 9])), 
				[0, 15, 9, 4, 2]
			),
			"<apiArrCop 2>"
		);
		
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 0, [0, 1, 2, 4, 3, 2, 1])), 
				[0, 1, 2, 4, 3, 2, 1]
			),
			"<apiArrCop 3>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 8, [0, 6, 8, 9])), 
				[1, 2, 3, 4, 5, 0, 0, 0,
					0, 6, 8, 9]
			),
			"<apiArrCop 4>"
		);
		
		var _check = [1, 2, 3, 4, 5];
		array_copy(_check, 8, [0, 6, 8, 9], 0, 4);
		apiDebugAssert(
			array_equals(
				_array, 
				[1, 2, 3, 4, 5, 0, 0, 0,
					0, 6, 8, 9]
			),
			"<apiArrCop 4.1>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 20, [])), 
				[1, 2, 3, 4, 5]
			),
			"<apiArrCop 5>"
		);
		
		_array = [1, 2, 3, 4, 5];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 8, [0, 6, 8, 9], 1, 2)), 
				[1, 2, 3, 4, 5, 0, 0, 0,
					6, 8]
			),
			"<apiArrCop 6>"
		);
		
		_array = [1, 2, 3, 4, 5, 6, 7, 8];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 2, _array, 0, 4)), 
				[1, 2, 1, 2, 3, 4, 7, 8]
			),
			"<apiArrCop eq |-|>"
		);
		
		_check = [1, 2, 3, 4, 5, 6, 7, 8];
		array_copy(_check, 2, _check, 0, 4);
		apiDebugAssert(
			array_equals(
				_check, 
				_array
			),
			"<apiArrCop eq |-| def>"
		);
		
		_array = [1, 2, 3, 4, 5, 6, 7, 8];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrCop(_array, 0, _array, 2, 4)), 
				[3, 4, 5, 6, 5, 6, 7, 8]
			),
			"<apiArrCop eq |+|>"
		);
		
		_check = [1, 2, 3, 4, 5, 6, 7, 8];
		array_copy(_array, 0, _array, 2, 4);
		apiDebugAssert(
			!array_equals(
				_check, 
				_array
			),
			"<apiArrCop eq |+| def>"
		);
		
		// dest_index < src_index
		apiDebugPrint("\teq |+| def:", _array);
		
		show_debug_message("\t apiArrCop \t\t\tis work");
		
		#endregion
		
		#region apiArrIns
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 0, [8, 9])), 
				[8, 9, 1, 2, 3, 4]
			),
			"<apiArrIns 0>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 4, [8, 9])), 
				[1, 2, 3, 4, 8, 9]
			),
			"<apiArrIns 1>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 8, [8, 9])), 
				[1, 2, 3, 4, 0, 0, 0, 0,
					8, 9]
			),
			"<apiArrIns 2>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 2, [8, 9])), 
				[1, 2, 8, 9, 3, 4]
			),
			"<apiArrIns 3>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 2, [])), 
				[1, 2, 3, 4]
			),
			"<apiArrIns 4>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 10, [])), 
				[1, 2, 3, 4]
			),
			"<apiArrIns 5>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 0, [])), 
				[1, 2, 3, 4]
			),
			"<apiArrIns 6>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 0, _array)), 
				[1, 2, 3, 4, 1, 2, 3, 4]
			),
			"<apiArrIns 7>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 2, _array)), 
				[1, 2, 1, 2, 3, 4, 3, 4]
			),
			"<apiArrIns 8>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 8, _array)), 
				[1, 2, 3, 4, 0, 0, 0, 0,
					1, 2, 3, 4]
			),
			"<apiArrIns 9>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 8, _array, 2)), 
				[1, 2, 3, 4, 0, 0, 0, 0,
					3, 4]
			),
			"<apiArrIns 10>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 8, _array, 0, 2)), 
				[1, 2, 3, 4, 0, 0, 0, 0,
					1, 2]
			),
			"<apiArrIns 11>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 8, _array, 1, 2)), 
				[1, 2, 3, 4, 0, 0, 0, 0,
					2, 3]
			),
			"<apiArrIns 12>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 0, [10, 11, 12, 13], 2)), 
				[12, 13, 1, 2, 3, 4]
			),
			"<apiArrIns 13>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 0, [10, 11, 12, 13], 1, 2)), 
				[11, 12, 1, 2, 3, 4]
			),
			"<apiArrIns 14>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 8, [10, 11, 12, 13], 1, 2)), 
				[1, 2, 3, 4, 0, 0, 0, 0,
					11, 12]
			),
			"<apiArrIns 15>"
		);
		
		_array = [1, 2, 3, 4];
		apiDebugAssert(
			array_equals(
				_f(_array, apiArrIns(_array, 2, [10, 11, 12, 13], 1, 2)), 
				[1, 2, 11, 12, 3, 4]
			),
			"<apiArrIns 16>"
		);
		
		show_debug_message("\t apiArrIns  \t\t\tis work");
		
		#endregion
		
		#region apiArrBulConcat
		
		_array = apiArrBulConcat(1, 2, [3, 4, 5], 6);
		apiDebugAssert(
			array_equals(
				_array, 
				[1, 2, 3, 4, 5, 6]
			),
			"<apiArrBulConcat 0>"
		);
		
		_array = apiArrBulConcat([1, 2, 3], 9, [4, 5], 8);
		apiDebugAssert(
			array_equals(
				_array, 
				[1, 2, 3, 9, 4, 5, 8]
			),
			"<apiArrBulConcat 1>"
		);
		
		_array = apiArrBulConcat(1, 2, 3);
		apiDebugAssert(
			array_equals(
				_array, 
				[1, 2, 3]
			),
			"<apiArrBulConcat 2>"
		);
		
		_array = apiArrBulConcat([1], [2], [3]);
		apiDebugAssert(
			array_equals(
				_array, 
				[1, 2, 3]
			),
			"<apiArrBulConcat 3>"
		);
		
		_array = apiArrBulConcat([], []);
		apiDebugAssert(
			array_equals(
				_array, 
				[]
			),
			"<apiArrBulConcat 4>"
		);
		
		_array = apiArrBulConcat();
		apiDebugAssert(
			array_equals(
				_array, 
				[]
			),
			"<apiArrBulConcat 5>"
		);
		
		show_debug_message("\t apiArrBulConcat \t\tis work");
		
		#endregion
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

