
/// @function apiBufferCopy(dest, src, dest_offset, ?src_offset, ?size);
/// @param dest
/// @param src
/// @param dest_offset
/// @param ?src_offset
/// @param ?size
function apiBufferCopy(_dest, _src, _destOffset, _srcOffest, _size) {
    var _destLength = buffer_get_size(_dest);
    var _srcLength = buffer_get_size(_src);
    if (is_undefined(_srcOffest)) _srcOffest = 0;
    if (is_undefined(_size)) _size = _srcLength - _srcOffest;
    if (_size > 0) {
		
		var _newSize = _destOffset + _size;
		if (_newSize > _destLength) {
		    
		    do {
		        _destLength *= 2;
		    } until (_newSize < _destLength);
		    
		    buffer_resize(_dest, _destLength);
		}
		
        if (_dest == _src) {
			
            if (_destOffset == _srcOffest) exit;
            if (_destOffset > _srcOffest) {
            	
            	do {
            		_size -= 1;
            		buffer_poke(_dest, _size + _destOffset, buffer_u8, buffer_peek(_src, _size + _srcOffest, buffer_u8));
            	} until (_size <= 0);
                exit;
            }
        }
        var _i = 0;
        do {
            buffer_poke(_dest, _i + _destOffset, buffer_u8, buffer_peek(_src, _i + _srcOffest, buffer_u8));
        } until (++_i == _size);
    }
}
