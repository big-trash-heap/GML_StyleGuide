

#region simple

/// @function		apiFTextWrite(filename, string, [append=false]);
function apiFTextWrite(_filename, _string, _append=false) {
	
	var _file = (_append ? file_text_open_append : file_text_open_write)(_filename);
	file_text_write_string(_file, _string);
	file_text_close(_file);
}

/// @param			filename
function apiFTextRead(_filename) {
	
	var _file = file_text_open_read(_filename);
	if (_file == -1) {
		
		file_text_close(_filename);
		return undefined;
	}
	
	var _textbuf = apiBufTxtCreate();
	
	while (!file_text_eof(_file))
		apiBufTxtAppend(_textbuf, file_text_readln(_file));
	
	file_text_close(_file);
	return apiBufTxtFree(_textbuf);
}

#endregion

