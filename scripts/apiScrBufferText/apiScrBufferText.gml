

/*
	Данные функции являются обёрткой над обычными буферами
	
	Их цель предоставить интерфейс, сигнатура которого,
	подчёркивает их задачу
	
	Задачей данного интерфейса является накопление текста
	и возврат его в виде строки
	
	Кодировка UTF8
*/

/// @param			[size]
function apiBufTxtCreate(_size=128) {
	return buffer_create(_size, buffer_grow, 1);
}

/// @function		apiBufTxtAppend(buffer, string);
function apiBufTxtAppend(_buffer, _string) {
	buffer_write(_buffer, buffer_text, _string);
}

/// @function		apiBufTxtPush(buffer, ...strings);
function apiBufTxtPush(_buffer) {
	
	var _argSize = argument_count;
	for (var _i = 1; _i < _argSize; ++_i) 
		buffer_write(_buffer, buffer_text, argument[_i]);
}

/// @description	Возвращает строку записанную в буфере
//
/// @param			buffer
function apiBufTxtRead(_buffer) {
	
	var _anchor = buffer_tell(_buffer);
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_seek(_buffer, buffer_seek_start, _anchor);
	return _string;
}

/// @description	Возвращает строку записанную в буфере
//					и очищает его
//
/// @param			buffer
function apiBufTxtCRead(_buffer) {
	
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_seek(_buffer, buffer_seek_start, 0);
	return _string;
}

/// @function		apiBufTxtClear(buffer, [newsize]);
/// @description	Производит отчистку буферу
//					и изменяет его размер если он был указан
//					Размер может быть изменён, 
//					только в меньшую сторону
function apiBufTxtClear(_buffer, _size) {
	
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	if (!is_undefined(_size) and buffer_get_size(_buffer) > _size)
		buffer_resize(_buffer, _size);
}

/// @description	Удаляет буфер, а так же возвращает
//					строку записанную в нём
//
/// @param			buffer
function apiBufTxtFree(_buffer, _read=true) {
	
	if (_read) {
		var _string = apiBufTxtRead(_buffer);
		buffer_delete(_buffer);
		return _string;
	}
	
	buffer_delete(_buffer);
}

/// @description	Возвращает количество данных в буффере (в байтах)
//
/// @param			buffer
function apiBufTxtSize(_buffer) {
	
	return (buffer_tell(_buffer) + 1);
}


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrBufferText"
		);
		
		var _textbuf = apiBufTxtCreate(32);
		
		apiDebugAssert(
			buffer_exists(_textbuf),
			"<apiBufTxtCreate create>"
		);
		
		apiDebugAssert(
			buffer_get_size(_textbuf) == 32,
			"<apiBufTxtCreate size>"
		);
		
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "",
			"<apiBufTxtRead empty 0>"
		);
		
		apiBufTxtPush(_textbuf);
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "",
			"<apiBufTxtPush empty push>"
		);
		
		apiBufTxtAppend(_textbuf, "Hello World!");
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "Hello World!",
			"<apiBufTxtAppend append 1>"
		);
		
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "Hello World!",
			"<apiBufTxtRead repeated get 1>"
		);
		
		apiBufTxtAppend(_textbuf, "GML");
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "Hello World!GML",
			"<apiBufTxtAppend append 2>"
		);
		
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "Hello World!GML",
			"<apiBufTxtRead repeated get 2>"
		);
		
		apiBufTxtPush(_textbuf, "!", " It is work!");
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "Hello World!GML! It is work!",
			"<apiBufTxtPush push 1>"
		);
		
		apiBufTxtPush(_textbuf, "1", "2", "3");
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "Hello World!GML! It is work!123",
			"<apiBufTxtPush push 2>"
		);
		
		apiBufTxtClear(_textbuf, 20);
		apiDebugAssert(
			buffer_get_size(_textbuf) == 20,
			"<apiBufTxtClear clear size>"
		);
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "",
			"<apiBufTxtClear clear read>"
		);
		
		apiBufTxtAppend(_textbuf, "Text Buffer");
		apiDebugAssert(
			apiBufTxtRead(_textbuf) == "Text Buffer",
			"<apiBufTxtAppend append 10>"
		);
		
		apiDebugAssert(
			apiBufTxtFree(_textbuf) == "Text Buffer",
			"<apiBufTxtFree free read>"
		);
		
		apiDebugAssert(
			!buffer_exists(_textbuf),
			"<apiBufTxtFree free data>"
		);
		
		if (buffer_exists(_textbuf)) buffer_delete(_textbuf);
		show_debug_message("<COMPLETE>");
	}
}
#endregion

