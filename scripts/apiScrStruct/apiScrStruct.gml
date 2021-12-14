

#region modify

/// @param			struct
function apiStructClear(_struct) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys);
	while (_size > 0) variable_struct_remove(_struct, _keys[--_size]);
}

/// @function		apiStructMerge(struct_merge, struct, [union=false]);
/// @description	Добавление полей struct в struct_merge
function apiStructMerge(_struct_merge, _struct, _union=false) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys), _key;
	while (_size > 0) {
        
        _key = _keys[--_size];
        if (_union and variable_struct_exists(_struct_merge, _key)) continue;
        _struct_merge[$ _key] = _struct[$ _key];
    }
	
	return _struct_merge;
}

#endregion

#region build

/// @param			...["key":value]
function apiStructBul() {
    var _argSize = argument_count;
    var _structBul = {};
    var _pair;
    for (var _i = 0; _i < _argSize; ++_i) {
        
        _pair = argument[_i];
        _structBul[$ _pair[0]] = _pair[1];
    }
    return _structBul;
}

/// @description	Клонирование структуры с глубиной 1
//
/// @param			struct
function apiStructBulDup1d(_struct) {
    
    var _structBul = {};
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys), _key;
    while (_size > 0) {
        
        _key = _keys[--_size];
        _structBul[$ _key] = _struct[$ _key];
    }
    
    return _structBul;
}

#endregion

