

#region basic

/// @function apiFunctorEmpty(?value);
/// @param ?value
function apiFunctorEmpty() {
	return undefined;
}

/// @function apiFunctorId(value);
/// @param value
function apiFunctorId(_value) {
	return _value;
}

/// @function apiFunctorArray(value);
/// @param value
function apiFunctorArray(_value) {
	return (is_array(_value) ? _value : [_value]);
}

/// @function apiFunctorStruct(value, key);
/// @param value
/// @param ?key
function apiFunctorStruct(_value, _key) {
	
	if (is_struct(_value)) return _value;
	
	var _build = {};
	_build[$ (is_undefined(_key) ? "" : _key)] = _value;
	
	return _build;
}

#endregion

