

#region modify

//					f = f(struct, key, data)
/// @function		apiStructForEach(struct, f, [data]);
function apiStructForEach(_struct, _f, _data) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys);
	while (_size > 0) _f(_struct, _keys[--_size], _data);
	
}

//					f = f(struct, key, data)
/// @function		apiStructFind(struct, f, [data]);
function apiStructFind(_struct, _f, _data) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys);
	while (_size > 0) {
		--_size;
		if (_f(_struct, _keys[_size], _data)) return _keys[_size];
	}
	
    return undefined;
}

#endregion

