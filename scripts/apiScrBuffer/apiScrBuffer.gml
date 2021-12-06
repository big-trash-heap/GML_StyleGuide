

#region toString

/*
	Предназначенно для отладки
*/

/// @function		apiTStrBuffer(buffer, [bytesize], [bytestart], [metainfo]);
/// @description	Генерирует строку, где каждый байт буфера
//					будет представлен в виде числа в HEX (шестнадцатеричном) формате
//					
/// @param			buffer
/// @param			[bytesize] - количество байтов, которые нужно отобразить
/// @param			[bytestart] - байт с которого нужно начать отображение
/// @param			[metainfo] - нужно ли отображать мета информацию,
//						или только последовательность байтов
function apiTStrBuffer(_buffer, _j, _i, _meta=true) {
	
	/*
		u8 = buffer_u8
		buffer <32:u8, 255:u8, 9:u8> -> <Buffer 20 FF 09>
	*/
	
	var _size   = buffer_get_size(_buffer);
	var _string = (_meta ? "<Buffer" : "");
	
	if (is_undefined(_i)) {

		_i = 0;
	} 
	else
	if (_meta) {
		
		_string += " start of " + string(_i) + " |";
	}
	
	_j = (is_undefined(_j) ? -1 : _i + _j);
	for (; _i < _size; _i += 1) {
		
		if (_i == _j) {
			
			if (_meta) _string += " | ...bytes " + string(_size - _i);
			break;
		}
		
		_string += " ";
		_string += apiTStrInt(buffer_peek(_buffer, _i, buffer_u8), undefined, 2);
	}
	return (_meta ? _string + ">" : string_delete(_string, 1, 1));
}

#endregion


#region tests - toString
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiTStrBuffer"
		);
		
		var _f      = apiTStrBuffer;
		var _buffer = buffer_create(8, buffer_fixed, 1);
		
		apiDebugAssert(
			_f(_buffer) == "<Buffer 00 00 00 00 00 00 00 00>",
			"<apiTStrBuffer 1>"
		);
		
		apiDebugAssert(
			_f(_buffer, undefined, undefined, false) == "00 00 00 00 00 00 00 00",
			"<apiTStrBuffer 1.1>"
		);
		
		buffer_poke(_buffer, 0, buffer_u8, 254);
		buffer_poke(_buffer, 1, buffer_u8, 255);
		buffer_poke(_buffer, 7, buffer_u8, 32);
		
		apiDebugAssert(
			_f(_buffer, 4) == "<Buffer FE FF 00 00 | ...bytes 4>",
			"<apiTStrBuffer 2>"
		);
		
		apiDebugAssert(
			_f(_buffer, 4, undefined, false) == "FE FF 00 00",
			"<apiTStrBuffer 2.1>"
		);
		
		apiDebugAssert(
			_f(_buffer, 4, 1) == "<Buffer start of 1 | FF 00 00 00 | ...bytes 3>",
			"<apiTStrBuffer 3>"
		);
		
		apiDebugAssert(
			_f(_buffer, 4, 1, false) == "FF 00 00 00",
			"<apiTStrBuffer 3.1>"
		);
		
		apiDebugAssert(
			_f(_buffer, undefined, 1) == "<Buffer start of 1 | FF 00 00 00 00 00 20>",
			"<apiTStrBuffer 4>"
		);
		
		apiDebugAssert(
			_f(_buffer, undefined, 1, false) == "FF 00 00 00 00 00 20",
			"<apiTStrBuffer 4.1>"
		);
		
		buffer_delete(_buffer);
		show_debug_message("<COMPLETE>");
	}
}
#endregion

