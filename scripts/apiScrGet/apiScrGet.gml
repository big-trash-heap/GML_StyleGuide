

function apiGetBoolT() { return true;  };
function apiGetBoolF() { return false; };

function apiGetAny(_value) {
	static _any = apiFunctorFunc(function() {
		return self.value;
	});
	return method({ value: _value }, _any);
}

function apiGetAccess() {
	
	static _table = function() {
		
		var _table = {};
		
		_table[$ "@"] = array_get;
		_table[$ "$"] = variable_struct_get;
		_table[$ "?"] = ds_map_find_value;
		_table[$ "|"] = ds_list_find_value;
		_table[$ "s"] = string_char_at;
		_table[$ "i"] = variable_instance_get;
		_table[$ "g"] = variable_global_get;
		_table[$ "m"] = apiFunctorFunc(function(_data, _key) {
			return (_key(_data));
		});
		
		return _table;
	}();
	
	static _read = function(_value) {
		
		var _size = array_length(self.array);
		var _state;
		for (var _i = 0; _i < _size; ++_i) {
			
			_state = self.array[_i];
			_value = _state[0](_value, _state[1]);
		}
		
		return _value;
	}
	
	var _argSize = argument_count div 2;
	var _array = array_create(_argSize);
	for (var _i = 0, _j; _i < _argSize; ++_i) {
		
		_j = _i * 2;
		_array[_i] = [_table[$ argument[_j]], argument[_j + 1]];
	}
	
	return method({ array: _array }, _read);
}

