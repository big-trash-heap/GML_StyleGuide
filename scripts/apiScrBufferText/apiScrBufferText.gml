
function apiBufferTextCreate() {
	
	return buffer_create(32, buffer_grow, 1);
}

function apiBufferTextAppend(_buffer, _text) {
	
	buffer_write(_buffer, buffer_text, _text);
}

function apiBufferTextPush(_buffer) {
	
	var _argSize = argument_count;
	for (var _i = 0; _i < _argSize; ++_i) 
		buffer_write(_buffer, buffer_text, argument[_i]);
}

function apiBufferTextRead(_buffer) {
	
	var _seek = buffer_tell(_buffer);
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_seek(_buffer, buffer_seek_start, _seek);
	return _string;
}

function apiBufferTextClear(_buffer, _size) {
	
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	if (!is_undefined(_size) and buffer_get_size(_buffer) > _size)
		buffer_resize(_buffer, _size);
}

function apiBufferTextFree(_buffer) {
	
	var _string = apiBufferTextRead(_buffer);
	buffer_delete(_buffer);
	return _string;
}
