

#region modify

/// @function		apiDListResize(id, size);
/// @description	Аналог array_resize
function apiDListResize(_id, _size) {
	var _idSize = ds_list_size(_id);
	if (_size > _idSize) {
		
		repeat (_size - _idSize) ds_list_add(_id, 0);
	}
	else {
		
		while (_size != _idSize) ds_list_delete(_id, --_idSize);
	}
}

/// @function		apiDListDel(id, index, count);
/// @description	Аналог array_delete
function apiDListDel(_id, _index, _count) {
	
	var _idSize = ds_list_size(_id);
	var _mSize = _idSize - _index;
	
	_count = min(_count, _mSize);
	if (_count <= 0) exit;
	
	repeat (_mSize - _count) {
		
		_id[| _index] = _id[| _index + _count];
		++_index;
	}
	apiDListResize(_id, _idSize - _count);
}

#endregion

#region build

/// @param			...value
/// @description	Строит список из аргументов
function apiDListBul() {
	var _id = ds_list_create();
	var _argSize = argument_count;
	
	for (var _i = 0; _i < _argSize; ++_i)
		ds_list_add(_id, argument[_i]);
	
	return _id;
}

#endregion

#region other

/// @param			id
/// @description	Запишет список в массив
function apiDListToArr(_id) {
	var _idSize = ds_list_size(_id);
	var _array = array_create(_idSize);
	
	for (var _i = 0; _i < _idSize; ++_i) 
		_array[_i] = _id[| _i];
	
	return _array;
}

#endregion


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrDsList"
		);
		
		var _lcheck = function(_id, _array) {
			
			var _idSize = ds_list_size(_id);
			var _size = array_length(_array);
			if (_idSize != _size) return false;
			
			for (var _i = 0; _i < _size; ++_i) {
				
				if (_id[| _i] != _array[_i]) return false;
			}
			
			return true;
		}
		var _id;
		
		#region apiDListBul
		
		_id = apiDListBul(0, "Hello", "World", -1, undefined, 32);
		
		apiDebugAssert(
			_lcheck(_id, [0, "Hello", "World", -1, undefined, 32]),
			"<apiDListBul 0>"
		);
		
		ds_list_destroy(_id);
		
		_id = apiDListBul();
		
		apiDebugAssert(
			_lcheck(_id, []),
			"<apiDListBul 1>"
		);
		
		ds_list_destroy(_id);
		
		_id = apiDListBul(1, 2, ".");
		
		apiDebugAssert(
			_lcheck(_id, [1, 2, "."]),
			"<apiDListBul 2>"
		);
		
		ds_list_destroy(_id);
		
		show_debug_message("\t apiDListBul \t\tis work");
		
		#endregion
		
		#region apiDListToArr
		
		_id = apiDListBul(0, "Hello", "World", -1, undefined, 32);
		
		apiDebugAssert(
			array_equals(apiDListToArr(_id), [0, "Hello", "World", -1, undefined, 32]),
			"<apiDListToArr 0>"
		);
		
		ds_list_destroy(_id);
		
		_id = apiDListBul();
		
		apiDebugAssert(
			array_equals(apiDListToArr(_id), []),
			"<apiDListToArr 1>"
		);
		
		ds_list_destroy(_id);
		
		_id = apiDListBul(1, 2, ".");
		
		apiDebugAssert(
			array_equals(apiDListToArr(_id), [1, 2, "."]),
			"<apiDListToArr 2>"
		);
		
		ds_list_destroy(_id);
		
		show_debug_message("\t apiDListToArr \t\tis work");
		
		#endregion
		
		#region apiDListResize
		
		_id = apiDListBul(0, 1, 2, 3, 4, 5);
		
		apiDListResize(_id, ds_list_size(_id) + 5);
		
		apiDebugAssert(
			11 == ds_list_size(_id),
			"<apiDListResize 0.size>"
		);
		
		apiDebugAssert(
			_lcheck(_id, [0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0]),
			"<apiDListResize 0.data>"
		);
		
		apiDListResize(_id, ds_list_size(_id) - 7);
		
		apiDebugAssert(
			4 == ds_list_size(_id),
			"<apiDListResize 1.size>"
		);
		
		apiDebugAssert(
			_lcheck(_id, [0, 1, 2, 3]),
			"<apiDListResize 1.data>"
		);
		
		apiDListResize(_id, 0);
		
		apiDebugAssert(
			0 == ds_list_size(_id),
			"<apiDListResize 2.size>"
		);
		
		apiDebugAssert(
			_lcheck(_id, []),
			"<apiDListResize 2.data>"
		);
		
		ds_list_add(_id, 11);
		apiDListResize(_id, 5);
		
		apiDebugAssert(
			5 == ds_list_size(_id),
			"<apiDListResize 3.size>"
		);
		
		apiDebugAssert(
			_lcheck(_id, [11, 0, 0, 0, 0]),
			"<apiDListResize 3.data>"
		);
		
		ds_list_destroy(_id);
		
		show_debug_message("\t apiDListResize \t\tis work");
		
		#endregion
		
		#region apiDListDel
		
		_id = apiDListBul(0, 8, 1, 2, 24, 7);
		
		apiDListDel(_id, 0, 3);
		
		apiDebugAssert(
			_lcheck(_id, [2, 24, 7]),
			"<apiDListDel 0>"
		);
		
		ds_list_add(_id, 2, 52, 12, 2);
		
		var _array = [2, 24, 7, 2, 52, 12, 2];
		array_delete(_array, 1, 2);
		array_delete(_array, 3, 3);
		array_delete(_array, 3, 3);
		
		apiDListDel(_id, 1, 2);
		apiDListDel(_id, 3, 3);
		
		apiDebugAssert(
			_lcheck(_id, _array),
			"<apiDListDel 1>"
		);
		
		array_push(_array, 1, 23, 234, 519, "h", undefined);
		ds_list_add(_id, 1, 23, 234, 519, "h", undefined);
		
		array_delete(_array, 1, 2);
		array_delete(_array, 1, 2);
		array_delete(_array, 3, 2);
		
		apiDListDel(_id, 1, 2);
		apiDListDel(_id, 1, 2);
		apiDListDel(_id, 3, 2);
		
		apiDebugAssert(
			_lcheck(_id, _array),
			"<apiDListDel 2>"
		);
		
		array_delete(_array, array_length(_array), 5);
		apiDListDel(_id, ds_list_size(_id), 5);
		
		apiDebugAssert(
			_lcheck(_id, _array),
			"<apiDListDel 3>"
		);
		
		ds_list_destroy(_id);
		
		show_debug_message("\t apiDListDel \t\tis work");
		
		#endregion
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

