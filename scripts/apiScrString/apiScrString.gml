

/// @function		apiStrReplace(substring, string, index, count);
function apiStrReplace(_substring, _string, _index, _count) {
	return (
		string_copy(_string, 1, _index - 1) +
		_substring +
		string_delete(_string, 1, _index + _count - 1)
	);
}

/// @function		apiStrFindBalance(string, left_ord, right_ord, [index=1]);
/// @description	Находит балансирующий символ в строке от указанного
function apiStrFindBalance(_string, _leftOrd, _rightOrd, _index=1) {
	
	var _type = string_ord_at(_string, _index), _limit;
	if (_type == _leftOrd) {
		
		_type = 1;
		_limit = string_length(_string) + 1;
	}
	else
	if (_type == _rightOrd) {
		
		_type     = _leftOrd;
		_leftOrd  = _rightOrd;
		_rightOrd = _type;
		
		_type = -1;
		_limit = 0;
	}
	else {
		return 0;
	}
	
	_index += _type;
	var _ord, _count = 1;
	while (_index != _limit) {
			
		_ord = string_ord_at(_string, _index);
		if (_ord == _leftOrd)
			_count += 1;
		else
		if (_ord == _rightOrd) {
				
			if (_count == 1) return _index;
			_count -= 1;
		}
			
		_index += _type;
	}
	return 0;
}

/// @function		apiStrFormat(buffer, [ord='%'], [handler=string], string, ...values);
/// @description	Записывает в буфер строку, заменяя ord на некоторое значение 
function apiStrFormat(_textbuf, _ord=37/* % */, _handler=string, _string) {
	
	var _size = string_length(_string);
	var _i = 1, _j = 1, _a = 4, _k;
	for (; _i <= _size; ++_i) {
		
		if (string_ord_at(_string, _i) == _ord) {
			
			_k = _i - _j;
			if (_k > 0)
				apiBufTxtAppend(_textbuf, string_copy(_string, _j, _k));
			
			apiBufTxtAppend(_textbuf, _handler(argument[_a++]));
			_j = _i + 1;
		}
	}
	
	_k = _i - _j;
	if (_k > 0)
		apiBufTxtAppend(_textbuf, string_copy(_string, _j, _k));
}


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrString"
		);
		
		#region apiStrReplace
		
		apiDebugAssert(
			apiStrReplace("HELL", "World", 2, 2) == "WHELLld",
			"<apiStrReplace 0>"
		);
		
		apiDebugAssert(
			apiStrReplace("HELL", "World", 2, 0) == "WHELLorld", // insert
			"<apiStrReplace 1>"
		);
		
		apiDebugAssert(
			apiStrReplace("HELL", "World", 2, 4) == "WHELL",
			"<apiStrReplace 2>"
		);
		
		show_debug_message("\t apiStrReplace  \t\t\t\tis work");
		
		#endregion
		
		#region apiStrFindBalance
		
		var _f   = apiStrFindBalance;
		var _str = "expr(var hello = world(2 + i * (j - i)));";
		
		apiDebugAssert(
			string_last_pos(")", _str) ==
			_f(_str, ord("("), ord(")"), string_pos("(", _str))
			,
			"<apiStrFindBalance 0>"
		);
		
		apiDebugAssert(
			string_pos("(", _str) ==
			_f(_str, ord("("), ord(")"), string_last_pos(")", _str))
			,
			"<apiStrFindBalance 1>"
		);
		
		apiDebugAssert(
			string_last_pos_ext(")", _str, string_last_pos(")", _str) - 1) ==
			_f(_str, ord("("), ord(")"), string_pos_ext("(", _str, string_pos("(", _str) + 1))
			,
			"<apiStrFindBalance 2>"
		);
		
		apiDebugAssert(
			string_pos_ext("(", _str, string_pos("(", _str) + 1) ==
			_f(_str, ord("("), ord(")"), string_last_pos_ext(")", _str, string_last_pos(")", _str) - 1))
			,
			"<apiStrFindBalance 3>"
		);
		
		apiDebugAssert(
			0 ==
			_f(" ( ()", ord("("), ord(")"), 2)
			,
			"<apiStrFindBalance 4>"
		);
		
		apiDebugAssert(
			4 ==
			_f(" ( ()", ord("("), ord(")"), 5)
			,
			"<apiStrFindBalance 5>"
		);
		
		apiDebugAssert(
			0 ==
			_f(" ( ))", ord("("), ord(")"), 5)
			,
			"<apiStrFindBalance 6>"
		);
		
		show_debug_message("\t apiStrFindBalance \t\tis work");
		
		#endregion
		
		#region apiStrFormat
		
		var _buffer = apiBufTxtCreate();
		
		apiStrFormat(_buffer, _, _, "hello %! How you%", "Kirill", "?");
		apiDebugAssert(
			apiBufTxtRead(_buffer) == "hello Kirill! How you?",
			"<apiStrFormat 0>"
		);
		
		apiBufTxtClear(_buffer);
		apiStrFormat(_buffer, _, _, "% + % = %; // %",
			4, 8, 12, "Sum"
		);
		
		apiDebugAssert(
			apiBufTxtRead(_buffer) == "4 + 8 = 12; // Sum",
			"<apiStrFormat 1>"
		);
		
		apiBufTxtClear(_buffer);
		apiStrFormat(_buffer, _, _, "% % % %",
			"Putin", "Haskell", "Russia", "Code"
		);
		
		apiDebugAssert(
			apiBufTxtRead(_buffer) == "Putin Haskell Russia Code",
			"<apiStrFormat 2>"
		);
		
		show_debug_message("\t apiStrFormat  \t\t\t\tis work");
		
		if (buffer_exists(_buffer)) buffer_delete(_buffer);
		#endregion
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

