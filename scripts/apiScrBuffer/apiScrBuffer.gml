
/// @function apiToStringBuffer(buffer, [ignore_seek])
/// @param buffer
/// @param [ignore_seek]
function apiToStringBuffer(_buffer, _ignoreSeek=false) {
	
	var _size = buffer_get_size(_buffer);
	var _seek = (_ignoreSeek ? -1 : buffer_tell(_buffer));
	var _string = "<Buffer";
	for (var _i = 0; _i < _size; _i += 1) {
		
		if (_i == _seek) {
			
			_string += " | bytes..." + string(_size - _i);
			break;
		}
		
		_string += " ";
		_string += apiToStringInteger(buffer_peek(_buffer, _i, buffer_u8), _, 2);
	}
	return (_string + ">");
}


