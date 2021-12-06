

function apiForD1(_x1, _x2, _f, _data) {
	
	var _r;
	if (_x1 < _x2) {
		do {
			_r = _f(_data, _x1);
			if (is_real(_r) && _r >= 0) return _r;
			++_x1;
		} until (_x1 > _x2);
		return _r;
	}
	else {
		do {
			_r = _f(_data, _x1);
			if (is_real(_r) && _r >= 0) return _r;
			--_x1;
		} until (_x1 < _x2);
		return _r;
	}
}

function apiForD2(_x1, _x2, _y1, _y2, _f, _data) {
	
	var _x_s = (_x1 < _x2 ? 1 : -1);
	var _y_s = (_y1 < _y2 ? 1 : -1);
	
	var _yy, _r;
	do {
		
		_yy = _y1;
		do {
			
			_r = _f(_data, _x1, _yy);
			if (is_real(_r) && _r >= 0) {
				if (_r == 0) return _r;
				break;
			}
			
			_yy += _y_s;
		} until (sign(_yy - _y2) == _y_s);
		
		_x1 += _x_s;
	} until (sign(_x1 - _x2) == _x_s);
	return _r;
}

function apiForD3(_x1, _x2, _y1, _y2, _z1, _z2, _f, _data) {
	
	var _x_s = (_x1 < _x2 ? 1 : -1);
	var _y_s = (_y1 < _y2 ? 1 : -1);
	var _z_s = (_z1 < _z2 ? 1 : -1);
	
	var _mark_y_break = false;
	var _yy, _zz, _r;
	do {
		
		_yy = _y1;
		do {
			
			_zz = _z1;
			do {
				
				_r = _f(_data, _x1, _yy, _zz);
				if (is_real(_r) && _r >= 0) {
					if (_r == 0) return _r;
					if (_r >= 2) _mark_y_break = true;
					break;
				}
				
				_zz += _z_s;
			} until (sign(_zz - _z2) == _z_s);
			
			if (_mark_y_break) {
				_mark_y_break = false;
				break;
			}
			
			_yy += _y_s;
		} until (sign(_yy - _y2) == _y_s);
		
		_x1 += _x_s;
	} until (sign(_x1 - _x2) == _x_s);
	return _r;
	
}

function apiForD4(_x1, _x2, _y1, _y2, _z1, _z2, _w1, _w2, _f, _data) {
	
	var _x_s = (_x1 < _x2 ? 1 : -1);
	var _y_s = (_y1 < _y2 ? 1 : -1);
	var _z_s = (_z1 < _z2 ? 1 : -1);
	var _w_s = (_w1 < _w2 ? 1 : -1);
	
	var _mark_y_break = false;
	var _mark_z_break = false;
	var _yy, _zz, _ww, _r;
	do {
		
		_yy = _y1;
		do {
			
			_zz = _z1;
			do {
				
				_ww = _w1;
				do {
					
					_r = _f(_data, _x1, _yy, _zz, _ww);
					if (is_real(_r) && _r >= 0) {
						if (_r == 0) return _r;
						if (_r == 2) _mark_z_break = true;
						if (_r >= 3) {
							_mark_y_break = true;
							_mark_z_break = true;	
						}
						break;
					}
					
					_ww += _w_s;
				} until (sign(_ww - _w2) == _w_s);
				
				if (_mark_z_break) {
					_mark_z_break = false;
					break;
				}
				
				_zz += _z_s;
			} until (sign(_zz - _z2) == _z_s);
			
			if (_mark_y_break) {
				_mark_y_break = false;
				break;
			}
			
			_yy += _y_s;
		} until (sign(_yy - _y2) == _y_s);
		
		_x1 += _x_s;
	} until (sign(_x1 - _x2) == _x_s);
	return _r;
	
}

