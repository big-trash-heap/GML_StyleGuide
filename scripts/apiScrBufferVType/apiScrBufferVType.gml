

enum API_BUF {
	NUM = 20,
	INF, NINF, NAN,
	UND,
}


function apiBufVType(_value) {
	static _map = function() {
		
		var _map = ds_map_create();
		
		_map[? "string"]    = buffer_string;
		_map[? "bool"]      = buffer_bool;
		_map[? "int32"]     = buffer_u32;
		_map[? "int64"]     = buffer_u64;
		_map[? "undefined"] = API_BUF.UND;
		
		return _map;
	}();
	
	var _value_type = typeof(_value);
	if (_value_type == "number") {
		
		if (is_nan(_value))				return API_BUF.NAN;
		if (is_infinity(_value))		return (_value > 0 ? API_BUF.INF : API_BUF.NINF);
		if (sign(frac(_value)) != 0)	return buffer_f32;
		
		if (sign(_value) == -1) {
			
			if (_value >= -128)			return buffer_s8;
			if (_value >= -32768)		return buffer_s16;
			if (_value >= -2147483648)	return buffer_s32;
		}
		else {
			if (_value <= 255)			return buffer_u8;
			if (_value <= 65535)		return buffer_u16;
			if (_value <= 4294967295)	return buffer_u32;
		}
		return buffer_u64;
	}
	return _map[? _value_type];
}

