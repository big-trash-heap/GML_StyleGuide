

#region modify

//					f = function(value, index, data)
/// @function		apiArrMap(array, f, [data]);
function apiArrMap(_array, _f, _data) {
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i) 
		array_set(_array, _i, _f(_array[_i], _i, _data));
}

//					f = function(value, index, data)
/// @function		apiArrFilter(array, f, [data]);
function apiArrFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
	if (_size > 0) {
		
		var _i = 0, _j = 0, _value;
		do {
		
			_value = _array[_i];
			if (_f(_value, _i, _data))
				_array[@ _j++] = _value;
		} until (++_i == _size);
		array_resize(_array, _j);
	}
}

#endregion

#region build

//					f = function(value, index, data)
/// @function		apiArrBulMap(array, f, [data]);
function apiArrBulMap(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _arrayBul = array_create(_size);
	
	for (var _i = 0; _i < _size; ++_i) 
		array_set(_arrayBul, _i, _f(_array[_i], _i, _data));
	
	return _arrayBul;
}

//					f = function(value, index, data)
/// @function		apiArrBulFilter(array, f, [data]);
function apiArrBulFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _arrayBul = [];
    
	if (_size > 0) {
		
        var _i = 0, _value;
        do {
			
            _value = _array[_i];
            if (_f(_value, _i, _data)) array_push(_arrayBul, _value);
        } until (++_i == _size);
    }
    
	return _arrayBul;
}

#endregion

#region other

//					f = function(value, index, data)
/// @function		apiArrCall(array, f, [data]);
function apiArrCall(_array, _f, _data) {
	
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i) 
		_f(_array[_i], _i, _data);
}

#endregion


#region tests - apiArrFilter + apiArrBulFilter
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrArrayHigher"
		);
		
		var _f = function(_value) { return _value > 5; };
		var _array;
		
		var _sample0 = [1, 8, 4, 1, 10, 20, -1, 3, 7, 11, 1];
		var _sample1 = [1, "hello", 1, 2, undefined, "world", [], {}, 123, 1];
		
		#region apiArrFilter
		
		_array = apiArrBulDup1d(_sample0);
		apiArrFilter(_array, _f);
		
		apiDebugAssert(
			array_equals(_array, [8, 10, 20, 7, 11]),
			"<apiArrFilter 0>"
		);
		
		_array = apiArrBulDup1d(_sample1);
		apiArrFilter(_array, is_string);
		
		apiDebugAssert(
			array_equals(_array, ["hello", "world"]),
			"<apiArrFilter 1>"
		);
		
		show_debug_message("\t apiArrFilter  \t\tis work");
		
		#endregion
		
		#region apiArrBulFilter
		
		apiDebugAssert(
			array_equals(apiArrBulFilter(_sample0, _f), [8, 10, 20, 7, 11]),
			"<apiArrBulFilter 0>"
		);
		
		apiDebugAssert(
			array_equals(apiArrBulFilter(_sample1, is_string), ["hello", "world"]),
			"<apiArrBulFilter 1>"
		);
		
		show_debug_message("\t apiArrBulFilter \tis work");
		
		#endregion
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

