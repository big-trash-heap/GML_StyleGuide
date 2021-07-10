
#region modify

/// @function apiStructClear(struct);
/// @param struct
function apiStructClear(_struct) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys);
    for (var _i = 0; _i < _size; ++_i) variable_struct_remove(_struct, _keys[_i]);
}

/// @function apiStructMerge(struct_merge, struct, ?union);
/// @param dest
/// @param src
/// @param ?union
function apiStructMerge(_struct_merge, _struct, _union) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys), _key;
    for (var _i = 0; _i < _size; ++_i) {
        
        _key = _keys[_i];
        if (_union and variable_struct_exists(_struct_merge, _key)) continue;
        _struct_merge[$ _key] = _struct[$ _key];
    }
}

#endregion

#region build

/// @function apiStructBuild(...["key":value]);
/// @param ...["key":value]
function apiStructBuild() {
    var _argSize = argument_count;
    var _structBuild = {};
    var _pair;
    for (var _i = 0; _i < _argSize; ++_i) {
        
        _pair = argument[_i];
        _structBuild[$ _pair[0]] = _pair[1];
    }
    return _structBuild;
}

/// @function apiStructBuildDup1d(struct);
/// @param struct
function apiStructBuildDup1d(_struct) {
    
    var _build = {};
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys), _key;
    for (var _i = 0; _i < _size; ++_i) {
        
        _key = _keys[_i];
        _build[$ _key] = _struct[$ _key];
    }
    
    return _build;
}

#endregion
