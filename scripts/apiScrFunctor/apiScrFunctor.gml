

#region basic

function apiFunctorEmpty() {
	return undefined;
}

function apiFunctorId(_value) {
	return _value;
}

function apiFunctorArray(_value) {
	return (is_array(_value) ? _value : [_value]);
}

function apiFunctorStruct(_value, _key) {
	if (is_struct(_value)) return _value;
	var _build = {};
	_build[$ (is_undefined(_key) ? "" : _key)] = _value;
	return _build;
}

#endregion

