
#macro API_INT_TBASE_DEFTABLE   "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#macro API_INT_TBASE_HEX        16
#macro API_INT_TBASE_OCT        8
#macro API_INT_TBASE_BIN        2

/// @function		apiTStrIntTBase(integer, base, [table])
/// @param integer
/// @param base
/// @param [table]
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

/// @function		apiTStrBaseTInt(integer, base, [table])
/// @param integer
/// @param base
/// @param [table]
function apiTStrBaseTInt(_integerCrypt, _base, _table) {
    
    static _defaultTable = apiTStrBaseTIntBulTable(API_INT_TBASE_DEFTABLE);
    
    if (is_undefined(_table)) {
    	
    	_table = _defaultTable;
    }
    else {
    	
    	_table = (is_string(_table) ? apiTStrBaseTIntBulTable(_table) : _table);
    }
    
    var _integer = 0;
    var _pointerFirst = 0;
	var _pointerLast = string_length(_integerCrypt);
	var _pointerSize = _pointerLast;
	var _iterator = 1;
	var _sign, _number;
	if (string_char_at(_integerCrypt, 1) == "-") {
		
		_sign = -1;
		_iterator += 1;
	}
	else {
		
		_sign = 1;
	}
	for (; _iterator <= _pointerSize; ++_iterator) {
		
		_number = _table[$ string_char_at(_integerCrypt, _pointerLast--)];
		_integer += power(_base, _pointerFirst++) * _number;
	}
	return (_integer * _sign);
}

/// @function		apiTStrBaseTIntBulTable(table)
/// @param table
function apiTStrBaseTIntBulTable(_table) {
	
	var _size = string_length(_table);
    var _build = {};
    for (var _i = 1; _i <= _size; ++_i) _build[$ string_char_at(_table, _i)] = _i - 1;
    return _build;
}

/// @function		apiTStrInt(integer_or_integerCrypt, [base=16], [padding])
/// @param integer_or_integerCrypt
/// @param [base=16]
/// @param [padding]
function apiTStrInt(_integerOrIntegerCrypt, _base=16, _padding=false) {
	
	if (is_string(_integerOrIntegerCrypt))
		return apiTStrBaseTInt(_integerOrIntegerCrypt, _base);
	
	var _hex = apiTStrIntTBase(_integerOrIntegerCrypt, _base);
	if (!_padding) return _hex;
	
	var _sign;
	if (string_char_at(_hex, 1) == "-") {
		
		_sign = -1;
		_hex = string_delete(_hex, 1, 1);
	}
	else {
		
		_sign = 1;
	}
	
	var _size = string_length(_hex);
	if (_padding > _size) _hex = string_repeat("0", _padding - _size) + _hex;
	
	return (_sign == -1 ? "-" + _hex : _hex);
}
