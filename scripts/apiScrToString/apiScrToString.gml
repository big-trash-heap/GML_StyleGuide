
#macro API_DEC_TO_BASE_DEFAULT_TABLE "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

function apiDecToBase(_integer, _base, _table) {
    
    if (is_undefined(_table)) _table = API_DEC_TO_BASE_DEFAULT_TABLE;
    var _result = "", _sign = sign(_integer), _mod;
    _integer = abs(_integer);
    while (_integer > 0) {
        
        _mod = _integer mod _base;
        _integer = _integer div _base;
        
        _result = string_char_at(_table, 1 + _mod) + _result;
    }
    return (_sign == -1 ? "-" + _result : _result);
}

function apiBaseToDec(_integerCrypt, _base, _table) {
    
    static _buildTable = function(_table) {
        
        var _size = string_length(_table);
        var _build = {};
        for (var _i = 1; _i <= _size; ++_i) _build[$ string_char_at(_table, _i)] = _i - 1;
        return _build;
    }
    
    static _defaultTable = _buildTable(API_DEC_TO_BASE_DEFAULT_TABLE);
    _table = (is_undefined(_table) ? _defaultTable : _buildTable(_table));
    
    var _integer = 0;
    
}

