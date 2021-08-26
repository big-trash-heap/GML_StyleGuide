
///// @function		apiStrFormat(buffer, [ord='%'], [handler=string], string, ...values);
///// @description	Записывает в буфер строку, заменяя ord на некоторое значение 
//function apiStrFormat(_textbuf, _ord=37/* % */, _handler=string, _string) {
	
//	var _size = string_length(_string);
//	var _i = 1, _j = 1, _a = 4, _k;
//	for (; _i <= _size; ++_i) {
		
//		if (string_ord_at(_string, _i) == _ord) {
			
//			_k = _i - _j;
//			if (_k > 0)
//				apiBufTxtAppend(_textbuf, string_copy(_string, _j, _k));
			
//			apiBufTxtAppend(_textbuf, _handler(argument[_a++]));
//			_j = _i + 1;
//		}
//	}
	
//	_k = _i - _j;
//	if (_k > 0)
//		apiBufTxtAppend(_textbuf, string_copy(_string, _j, _k));
//}

//#region apiStrFormat
		
//		var _buffer = apiBufTxtCreate();
		
//		apiStrFormat(_buffer, _, _, "hello %! How you%", "Kirill", "?");
//		apiDebugAssert(
//			apiBufTxtRead(_buffer) == "hello Kirill! How you?",
//			"<apiStrFormat 0>"
//		);
		
//		apiBufTxtClear(_buffer);
//		apiStrFormat(_buffer, _, _, "% + % = %; // %",
//			4, 8, 12, "Sum"
//		);
		
//		apiDebugAssert(
//			apiBufTxtRead(_buffer) == "4 + 8 = 12; // Sum",
//			"<apiStrFormat 1>"
//		);
		
//		apiBufTxtClear(_buffer);
//		apiStrFormat(_buffer, _, _, "% % % %",
//			"Putin", "Haskell", "Russia", "Code"
//		);
		
//		apiDebugAssert(
//			apiBufTxtRead(_buffer) == "Putin Haskell Russia Code",
//			"<apiStrFormat 2>"
//		);
		
//		show_debug_message("\t apiStrFormat  \t\t\t\tis work");
		
//		if (buffer_exists(_buffer)) buffer_delete(_buffer);
//		#endregion
		
