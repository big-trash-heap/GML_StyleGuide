
/*
	Данные функции являются обёрткой над обычными буфферами
	
	Их цель предоставить интерфейс, сигнатура которого,
	подчёркивает их задачу
	
	Задачей данного интерфейса является накопление текста
	и возврат его в виде строки
	
	Данный интерфейс может служить образцом решение
	такой задачи, если возникнет необходимость
	избежать накладных расходов на вызов функций
	данного интерфейса
*/

/// @param			[size]
function apiBufferTextCreate(_size=128) {
	
	return buffer_create(_size, buffer_grow, 1);
}

/// @function		apiBufferTextAppend(buffer, string);
function apiBufferTextAppend(_buffer, _string) {
	
	buffer_write(_buffer, buffer_text, _string);
}

/// @function		apiBufferTextPush(buffer, ...strings);
function apiBufferTextPush(_buffer) {
	
	var _argSize = argument_count;
	for (var _i = 1; _i < _argSize; ++_i) 
		buffer_write(_buffer, buffer_text, argument[_i]);
}

/// @description	Возвращает строку записанную в буффере
//
/// @param			buffer
function apiBufferTextRead(_buffer) {
	
	var _anchor = buffer_tell(_buffer);
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_seek(_buffer, buffer_seek_start, _anchor);
	return _string;
}

/// @function		apiBufferTextClear(buffer, [newsize]);
/// @description	Производит отчистку буфферу
//					и изменяет его размер если он был указан
//					Размер может быть изменён, 
//					только в меньшую сторону
function apiBufferTextClear(_buffer, _size) {
	
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	if (!is_undefined(_size) and buffer_get_size(_buffer) > _size)
		buffer_resize(_buffer, _size);
}

/// @description	Удаляет буффер, а так же возвращает
//					строку записанную в нём
//
/// @param			buffer
function apiBufferTextFree(_buffer) {
	
	var _string = apiBufferTextRead(_buffer);
	buffer_delete(_buffer);
	return _string;
}

#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrBufferText"
		);
		
		var _textbuf = apiBufferTextCreate(32);
		
		apiDebugAssert(
			buffer_exists(_textbuf),
			"<apiBufferTextCreate create>"
		);
		
		apiDebugAssert(
			buffer_get_size(_textbuf) == 32,
			"<apiBufferTextCreate size>"
		);
		
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "",
			"<apiBufferTextRead empty 0>"
		);
		
		apiBufferTextPush(_textbuf);
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "",
			"<apiBufferTextPush empty push>"
		);
		
		apiBufferTextAppend(_textbuf, "Hello World!");
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "Hello World!",
			"<apiBufferTextAppend append 1>"
		);
		
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "Hello World!",
			"<apiBufferTextRead repeated get 1>"
		);
		
		apiBufferTextAppend(_textbuf, "GML");
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "Hello World!GML",
			"<apiBufferTextAppend append 2>"
		);
		
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "Hello World!GML",
			"<apiBufferTextRead repeated get 2>"
		);
		
		apiBufferTextPush(_textbuf, "!", " It is work!");
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "Hello World!GML! It is work!",
			"<apiBufferTextPush push 1>"
		);
		
		apiBufferTextPush(_textbuf, "1", "2", "3");
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "Hello World!GML! It is work!123",
			"<apiBufferTextPush push 2>"
		);
		
		apiBufferTextClear(_textbuf, 20);
		apiDebugAssert(
			buffer_get_size(_textbuf) == 20,
			"<apiBufferTextClear clear size>"
		);
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "",
			"<apiBufferTextClear clear read>"
		);
		
		apiBufferTextAppend(_textbuf, "Text Buffer");
		apiDebugAssert(
			apiBufferTextRead(_textbuf) == "Text Buffer",
			"<apiBufferTextAppend append 10>"
		);
		
		apiDebugAssert(
			apiBufferTextFree(_textbuf) == "Text Buffer",
			"<apiBufferTextFree free read>"
		);
		
		apiDebugAssert(
			!buffer_exists(_textbuf),
			"<apiBufferTextFree free data>"
		);
		
		if (buffer_exists(_textbuf)) buffer_delete(_textbuf);
		show_debug_message("<COMPLETE>");
	}
}
#endregion
