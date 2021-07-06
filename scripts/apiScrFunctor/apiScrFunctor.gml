

#region basic

function functor_empty() {
	return undefined;
}

function functor_id(_value) {
	return _value;
}

function functor_array_wrap(_value) {
	return (is_array(_value) ? _value : [_value]);
}

function functor_struct_wrap(_value, _key) {
	if (is_struct(_value)) return _value;
	var _build = {};
	_build[$ (is_undefined(_key) ? "" : _key)] = _value;
	return _build;
}

#endregion

