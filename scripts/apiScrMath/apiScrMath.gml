

/// @function		apiMthARound(number, f);
function apiMthARound(_number, _f) {
	return (sign(_number) * _f(abs(_number)));
}

/// @param			number
function apiMthTrunc(_number) {
	return (sign(_number) == -1 ? ceil(_number) : floor(_number));
}

/// @function		apiMthSign(number, [positive=true]);
function apiMthSign(_number, _positive=true) {
	_number = sign(_number);
	return (_number != 0 ? _number : (_positive ? 1 : -1));
}

