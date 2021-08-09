
#region simple

/// @function		apiFileTextWrite(filename, string, [append=false]);
/// @description	
function apiFileTextWrite(_filename, _string, _append=false) {
	
	var _file = (_append ? file_text_open_append : file_text_open_write)(_filename);
	file_text_write_string(_file, _string);
	file_text_close(_file);
}


/// @description	
//
/// @param filename
function apiFileTextRead(_filename) {
	
	var _file = file_text_open_read(_filename);
	if (_file == -1) {
		
		file_text_close(_filename);
		return undefined;
	}
	
	var _textbuf = apiBufferTextCreate();
	
	while (!file_text_eof(_file))
		apiBufferTextAppend(_textbuf, file_text_readln(_file));
	
	file_text_close(_file);
	return apiBufferTextFree(_textbuf);
}

#endregion