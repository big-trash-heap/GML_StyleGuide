
#region simple

/*
	
*/

/// @function		apiFileJsonSave(filename, map_or_json);
/// @description	
function apiFileJsonSave(_filename, _json) {
	
	var _type = is_numeric(_json);
	var _file = file_text_open_write(_filename);
	file_text_write_real(_file, _type);
	file_text_write_string(_file,
		(_type ? json_encode : json_stringify)(_json)
	);
	file_text_close(_file);
}

/// @description	
//
/// @param filename
function apiFileJsonLoad(_filename) {
	
	var _file = file_text_open_read(_filename);
	if (_file == -1) {
		
		file_text_close(_filename);
		return undefined;
	}
	
	var _type = file_text_read_real(_file);
	if (_type) {
		
		_type = json_decode(file_text_readln(_file));
		if (_type == -1) _type = undefined;
	}
	else {
		_type = json_parse(file_text_readln(_file));
	}
	
	file_text_close(_file);
	return _type;
}

#endregion