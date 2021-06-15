
#region basic

function functor_empty() {
	return undefined;
}

function functor_id(value) {
	return value;
}

function functor_skip(_0, value) {
	return value;
}

function functor_array_wrap(value) {
	return (is_array(value) ? value : [value]);
}

function functor_struct_wrap(value, key) {
	if (is_struct(value)) {
		return value;
	}
	var build = {};
	build[$ key] = value;
	return build;
}

#endregion
