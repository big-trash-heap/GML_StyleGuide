
/*
	Перевод в разные системы счисления
*/

#macro API_INT_TBASE_DEFTABLE   "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#macro API_INT_TBASE_HEX        16
#macro API_INT_TBASE_OCT        8
#macro API_INT_TBASE_BIN        2

// СС - система счисления

/// @function		apiTStrIntTBase(integer, base, [table=API_INT_TBASE_DEFTABLE]);
/// @description	Переводит число из 10-СС в base-СС (в виде строки)
function apiTStrIntTBase(_integer, _base, _table=API_INT_TBASE_DEFTABLE) {
    
    var _sign = sign(_integer);
    if (_sign == 0) return string_char_at(_table, 0);
    
    var _result = "", _mod;
    _integer = abs(_integer);
    while (_integer > 0) {
        
        _mod     = _integer mod _base;
        _integer = _integer div _base;
        _result  = string_char_at(_table, 1 + _mod) + _result;
    }
    return (_sign == -1 ? "-" + _result : _result);
}

/// @function		apiTStrBaseTInt(string, base, [table=API_INT_TBASE_DEFTABLE]);
/// @description	Переводит число (строку) из base-СС в 10-СС (в виде числа)
function apiTStrBaseTInt(_string, _base, _table) {
    
    static _defaultTable = apiTStrBaseTIntBulTable(API_INT_TBASE_DEFTABLE);
    
    if (is_undefined(_table))
    	_table = _defaultTable;
    else
    	_table = (is_string(_table) ? apiTStrBaseTIntBulTable(_table) : _table);
    
    var _integer      = 0;
    var _pointerFirst = 0;
	var _pointerLast  = string_length(_string);
	var _iterator     = 1;
	var _sign, _number;
	if (string_char_at(_string, 1) == "-") {
		
		_sign = -1;
		_iterator += 1;
	}
	else {
		
		_sign = 1;
	}
	while (_iterator <= _pointerLast) {
		
		_number = _table[$ string_char_at(_string, _pointerLast--)];
		_integer += power(_base, _pointerFirst++) * _number;
	}
	return (_integer * _sign);
}

/// @description	Строит таблицу из символов
//
/// @param			table
function apiTStrBaseTIntBulTable(_table) {
	
	var _size = string_length(_table);
    var _build = {};
    for (var _i = 1; _i <= _size; ++_i) 
		_build[$ string_char_at(_table, _i)] = _i - 1;
    
	return _build;
}

/// @description	Комбинирует apiTStrIntTBase и apiTStrBaseTInt в одну функцию
//
/// @param			value
/// @param			[base=16]
/// @param			[padding=0] - минимальная длина строки, где отсутствующие
//						значения будут заполнены нулями
function apiTStrInt(_value, _base=16, _padding=0) {
	
	if (is_string(_value))
		return apiTStrBaseTInt(_value, _base);
	
	var _str = apiTStrIntTBase(_value, _base);
	if (!_padding) return _str;
	
	var _sign;
	if (string_char_at(_str, 1) == "-") {
		
		_sign = -1;
		_str = string_delete(_str, 1, 1);
	}
	else {
		
		_sign = 1;
	}
	
	var _size = string_length(_str);
	if (_padding > _size)
		_str = string_repeat("0", _padding - _size) + _str;
	
	return (_sign == -1 ? "-" + _str : _str);
}


#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrToString"
		);
		
		#region apiTStrIntTBase
		
		apiDebugAssert(
			apiTStrIntTBase(236, 8) == "354",
			"<apiTStrIntTBase 0>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(236, 2) == "11101100",
			"<apiTStrIntTBase 1>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(236, 16) == "EC",
			"<apiTStrIntTBase 2>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(236, 30) == "7Q",
			"<apiTStrIntTBase 3>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(23522342, 30) == "T15S2",
			"<apiTStrIntTBase 4>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(23522342, 2) == "1011001101110110000100110",
			"<apiTStrIntTBase 5>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(23522342, 16) == "166EC26",
			"<apiTStrIntTBase 6>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(-1891241, 16) == "-1CDBA9",
			"<apiTStrIntTBase 7>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(-1891241, 7) == "-22034552",
			"<apiTStrIntTBase 8>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(-1891241, 2) == "-111001101101110101001",
			"<apiTStrIntTBase 9>"
		);
		
		apiDebugAssert(
			apiTStrIntTBase(0, 2) == "0",
			"<apiTStrIntTBase 10>"
		);
		
		show_debug_message("\t apiTStrIntTBase \tis work");
		
		#endregion
		
		#region apiTStrBaseTInt
		
		apiDebugAssert(
			apiTStrBaseTInt("1000111000110010000111", 2) == 2329735,
			"<apiTStrBaseTInt 0>"
		);
		
		apiDebugAssert(
			apiTStrBaseTInt("-4340714", 9) == -2329735,
			"<apiTStrBaseTInt 1>"
		);
		
		apiDebugAssert(
			apiTStrBaseTInt("238C87", 16) == 2329735,
			"<apiTStrBaseTInt 2>"
		);
		
		apiDebugAssert(
			apiTStrBaseTInt("40D31DE92", 16) == 17401241234,
			"<apiTStrBaseTInt 3>"
		);
		
		apiDebugAssert(
			apiTStrBaseTInt("-10000001101001100011101111010010010", 2) == -17401241234,
			"<apiTStrBaseTInt 4>"
		);
		
		apiDebugAssert(
			apiTStrBaseTInt("0", 16) == 0,
			"<apiTStrBaseTInt 5>"
		);
		
		show_debug_message("\t apiTStrBaseTInt \tis work");
		
		#endregion
		
		#region apiTStrInt
		
		apiDebugAssert(
			apiTStrInt(apiTStrInt(111, 2, 10), 2) == 111,
			"<apiTStrInt 0>"
		);
		
		apiDebugAssert(
			apiTStrInt(apiTStrInt(-1453, 16, 10), 16) == -1453,
			"<apiTStrInt 1>"
		);
		
		show_debug_message("\t apiTStrInt \t\t\t\tis work");
		
		#endregion
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion

