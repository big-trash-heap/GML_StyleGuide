

//					f = function(value, index, data)
/// @function		apiDListFilter(array, f, [data]);
function apiDListFilter(_id, _f, _data) {
	
	var _idSize = ds_list_size(_id);
	if (_idSize > 0) {
		
		var _i = 0, _j = 0, _value;
		do {
		
			_value = _id[| _i];
			if (_f(_value, _i, _data))
				_id[| _j++] = _value;
		} until (++_i == _idSize);
		apiDListResize(_id, _j);
	}
}


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL true;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrDsListHigher"
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

		var _f = function(_value) { return _value > 5; };
		var _id0 = apiDListBul(1, 8, 4, 1, 10, 20, -1, 3, 7, 11, 1);
		var _id1 = apiDListBul(1, "hello", 1, 2, undefined, "world", [], {}, 123, 1);
		
		#region apiDListFilter
		
		apiDListFilter(_id0, _f);
		
		apiDebugAssert(
			array_equals(apiDListToArr(_id0), [8, 10, 20, 7, 11]),
			"<apiDListFilter 0>"
		);
		
		apiDListFilter(_id1, is_string);
		
		apiDebugAssert(
			array_equals(apiDListToArr(_id1), ["hello", "world"]),
			"<apiDListFilter 1>"
		);
		
		ds_list_destroy(_id0);
		ds_list_destroy(_id1);
		
		show_debug_message("\t apiDListFilter  \t\tis work");
		
		#endregion
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

