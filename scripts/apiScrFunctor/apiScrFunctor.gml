

#region basic

/// @param			...values
function apiFunctorEm() {
	API_GML_WARN_ARGS argument[-1];
	return undefined;
}

/// @function		apiFunctorId(value, ...values);
function apiFunctorId(_value) {
	API_GML_WARN_ARGS argument[-1];
	return _value;
}

/// @param			value
function apiFunctorArr(_value) {
	return (is_array(_value) ? _value : [_value]);
}

#endregion

