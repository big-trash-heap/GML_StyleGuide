

/*
	Сравнение объектов, с возможностью отсортировать их в порядке (Ord)
	Можно использовать например для функции array_sort
*/

#macro API_COMP_LT	-1	// what < with
#macro API_COMP_EQ	0  	// what = with
#macro API_COMP_GT	1	// what > with

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

/// @function		apiCompOrdNS(what, with);
/// @description	Комбинация apiCompOrdNum и apiCompOrdStr
//					Числа по отношению к строкам, расцениваются
//					как меньшее значение
function apiCompOrdNS(_what, _with) {
	if (is_string(_what)) {
		if (is_string(_with)) {
			return apiCompOrdStr(_what, _with);
		}
		return API_COMP_GT;
	}
	if (is_string(_with)) return API_COMP_LT;
	return sign(_what - _with);
}

#endregion


#region tests - basic
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrComparatorOrd"
		);
		
		show_debug_message("\t apiCompOrdNum \tskip check");
		
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
		
		show_debug_message("\t apiCompOrdStr \t\tis work");
		
		var _array = ["Message", "World", "Map", "Dota", "Haskell is good language"];
		array_sort(_array, method(_, apiCompOrdStr));
		
		apiDebugAssert(
			array_equals(
				["Dota", "Haskell is good language", "Map", "Message", "World"], _array
			),
			"<apiCompOrdStr array_sort>"
		);
		
		var _array = [4, "Message", "World", 100, "Map", "Dota", 234, "Haskell is good language", -1];
		array_sort(_array, method(_, apiCompOrdNS));
		
		apiDebugAssert(
			array_equals(
				[-1, 4, 100, 234, "Dota", "Haskell is good language", "Map", "Message", "World"], _array
			),
			"<apiCompOrdStr array_sort NS>"
		);
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

