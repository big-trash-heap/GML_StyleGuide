

/// @function apiDebugShow(array, [handler]);
function apiDebugShow(_array, _handler) {
	
	static _handler_def = function(_value) {
		
		return (string(_value) + " ");
	}
	
	if (is_undefined(_handler)) _handler = _handler_def;
	
	var _size = array_length(_array);
	var _text = "";
	
	for (var _i = 0; _i < _size; ++_i)
		_text += _handler(_array[_i]);
	
	return _text;
}

function apiDebugPrint() {
	
	//
	API_MACRO_ARGUMENT_PACK_READ;
	var _text = apiDebugShow(API_MACRO_ARGUMENT_PACK_GET);
	
	show_debug_message(_text);
	return _text;
}


function apiDebugAssert(_assert, _mess) {
	if (!_assert) {
		throw ("\n\t" + _mess);
	}
}
