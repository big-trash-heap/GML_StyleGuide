
/*

*/

#macro API_COMP_LT -1
#macro API_COMP_EQ 0
#macro API_COMP_GT 1

#region basic

/// @function		apiCompOrdNum(what, with);
function apiCompOrdNum(_what, _with) {
	
	/*
		apiCompOrdNum(2.0000242, 2.0000242) -> API_COMP_EQ
		apiCompOrdNum(5, 5)                 -> API_COMP_EQ
		
		apiCompOrdNum(2.0000242, 2.0000243) -> API_COMP_LT
		apiCompOrdNum(2, 5)                 -> API_COMP_LT
		
		apiCompOrdNum(2.0000243, 2.0000242) -> API_COMP_GT
		apiCompOrdNum(5, 2)                 -> API_COMP_GT
	*/
	
	return sign(_what - _with);
}

/// @function		apiCompOrdStr(what, with);
/// @description	Лексикографическое сравнение строк
function apiCompOrdStr(_what, _with) {

	/*
		apiCompOrdStr("aa", "aa") -> API_COMP_EQ
		apiCompOrdStr("", "")     -> API_COMP_EQ
		
		apiCompOrdStr("aa", "ab") -> API_COMP_LT
		apiCompOrdStr("a", "ab")  -> API_COMP_LT
		apiCompOrdStr("", "ab")   -> API_COMP_LT
		apiCompOrdStr("ab", "b")  -> API_COMP_LT
		
		apiCompOrdStr("2", "1")   -> API_COMP_GT
		apiCompOrdStr("2", "11")  -> API_COMP_GT
		apiCompOrdStr("2", "")    -> API_COMP_GT
		apiCompOrdStr("b", "ab")  -> API_COMP_GT
	*/
	
	var _sizeWhat = string_length(_what);
	var _sizeWith = string_length(_with);
	
	var _sign, _j = min(_sizeWhat, _sizeWith);
	for (var _i = 1; _i <= _j; ++_i) {
		
		_sign = sign(string_ord_at(_what, _i) - string_ord_at(_with, _i));
		if (_sign != 0) return _sign;
	}
	
	return sign(_sizeWhat - _sizeWith);
}

#endregion

#region tests - basic
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrComparatorOrd"
		);
		
		#region apiCompOrdNum
		
		apiDebugAssert(
			apiCompOrdNum(2.0000242, 2.0000242) == API_COMP_EQ,
			"<apiCompOrdNum eq 1>"
		);
		
		apiDebugAssert(
			apiCompOrdNum(2.0000242, 2.0000243) == API_COMP_LT,
			"<apiCompOrdNum lt 1>"
		);
		
		apiDebugAssert(
			apiCompOrdNum(2.0000243, 2.0000242) == API_COMP_GT,
			"<apiCompOrdNum gt 1>"
		);
		
		apiDebugAssert(
			apiCompOrdNum(5, 5) == API_COMP_EQ,
			"<apiCompOrdNum eq 2>"
		);
		
		apiDebugAssert(
			apiCompOrdNum(2, 5) == API_COMP_LT,
			"<apiCompOrdNum lt 2>"
		);
		
		apiDebugAssert(
			apiCompOrdNum(5, 2) == API_COMP_GT,
			"<apiCompOrdNum gt 2>"
		);
		
		show_debug_message("\t apiCompOrdNum \t\t\tis work");
		
		#endregion
		
		#region apiCompOrdStr
		
		apiDebugAssert(
			apiCompOrdStr("aa", "aa") == API_COMP_EQ,
			"<apiCompOrdStr eq 1>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("", "") == API_COMP_EQ,
			"<apiCompOrdStr eq 2>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("hello", "hello") == API_COMP_EQ,
			"<apiCompOrdStr eq 3>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("aa", "ab") == API_COMP_LT,
			"<apiCompOrdStr lt 1>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("a", "ab") == API_COMP_LT,
			"<apiCompOrdStr lt 2>"
		);
		
		
		apiDebugAssert(
			apiCompOrdStr("aac", "abc") == API_COMP_LT,
			"<apiCompOrdStr lt 3>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("ab", "b") == API_COMP_LT,
			"<apiCompOrdStr lt 4>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("ab", "aa") == API_COMP_GT,
			"<apiCompOrdStr gt 1>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("ab", "a") == API_COMP_GT,
			"<apiCompOrdStr gt 2>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("abc", "aac") == API_COMP_GT,
			"<apiCompOrdStr gt 3>"
		);
		
		apiDebugAssert(
			apiCompOrdStr("b", "ab") == API_COMP_GT,
			"<apiCompOrdStr gt 4>"
		);
		
		show_debug_message("\t apiCompOrdStr \tis work");
		
		#endregion
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion
