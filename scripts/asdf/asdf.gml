/*


function ApiBufferWrap(_buffer) constructor {
    
    self.buffer = (is_undefined(_buffer) ? -1 : _buffer);
    
    static read = function(_type, _offset) {
        
        if (!is_undefined(_offset))
            return buffer_peek(self.buffer, _offset, _type);
        else
            return buffer_read(self.buffer, _type);
    }
    
    static write = function(_type, _value, _offset) {
        
        var _pokeMode = !is_undefined(_offset);
        
        var _size = buffer_get_size(self.buffer);
        var _seek = (_pokeMode ? _offset : buffer_tell(self.buffer));
        
        var _sizeBytes = buffer_sizeof(_type);
        if (_sizeBytes == 0) _sizeBytes = string_byte_length(_value);
        
        _seek += _sizeBytes;
        if (_seek > _size) {
            
            do {
                _size = ceil(_size * 1.618); 
            } until (_seek < _size);
            
            buffer_resize(self.buffer, _size);
        }
        
        if (_pokeMode)
            buffer_poke(self.buffer, _offset, _type, _value);
        else
            buffer_write(self.buffer, _type, _value);
        
        return _size;
    }
    
    static tell = function() {
        
        return buffer_tell(self.buffer);
    }
    
    static seek = function(_offset, _base) {
        
        if (is_undefined(_base)) _base = buffer_seek_start;
        buffer_seek(self.buffer, _base, _offset);
    }
    
    static size = function() {
        
        return buffer_get_size(self.buffer);
    }
    
    static free = function() {
        
        buffer_delete(self.buffer);
        self.buffer = -1;
    }
    
}

function ApiBuffer(_size, _alignment) : ApiBufferWrap(_) constructor {
    
    
    
    self.buffer = buffer_create(_size, buffer_fixed, _alignment);
    
}


// f = function(value, index, data)
/// @function		apiArrayForStep(array, f, ?data, ?step, ?index);
/// @param array
/// @param f
/// @param ?data
/// @param ?step
/// @param ?index
function apiArrayFindExt(_array, _f, _data, _step, _index) {
	var _size = array_length(_array);
    if (_size--) {
        
		if (is_undefined(_step)) _step = 1;
		var _reverse = (sign(_step) == -1);
		
        if (is_undefined(_index)) _index = (_reverse ? _size : 0);
        if (_reverse) {
            do {
				
				if (_f(_array[_index], _index, _data)) return _index;
				
                _index += _step;
            } until (_index < 0);
        } 
        else {
            do {
				
                if (_f(_array[_index], _index, _data)) return _index;
				
                _index += _step;
            } until (_index > _size);
        }
    }
    return -1;
}


/*
buffer = new ApiBufferGrow(0, 1);
buffer.write(buffer_u8, 1);
buffer.write(buffer_u8, 2);
buffer.write(buffer_u8, 3);
buffer.write(buffer_u8, 4);
buffer.write(buffer_u8, 5);
buffer.write(buffer_u8, 6);
buffer.write(buffer_u8, 7);
buffer.write(buffer_u8, 8);
buffer.write(buffer_u8, 9);
buffer.write(buffer_u8, -1);
buffer.write(buffer_u8, -2);
buffer.write(buffer_u8, -3);
buffer.write(buffer_u8, -4);
buffer.write(buffer_text, "hello world it is more big text, for you car is very bad");
buffer.write(buffer_text, "hi")

show_debug_message(buffer.size())

buffer.seek(0);
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));
show_debug_message(buffer.read(buffer_u8));

show_debug_message(buffer.read(buffer_text));


// show_debug_message("test")
// buffer = buffer_create(8, buffer_grow, 4);
// show_debug_message(buffer_tell(buffer));

// buffer_write(buffer, buffer_u8, 1);
// show_debug_message(buffer_tell(buffer));

// buffer_write(buffer, buffer_u8, 1);
// show_debug_message(buffer_tell(buffer));


// buffer_write(buffer, buffer_u8, 1);
// show_debug_message(buffer_tell(buffer));

// buffer_write(buffer, buffer_u8, 1);
// show_debug_message(buffer_tell(buffer));

// buffer_write(buffer, buffer_u8, 1);
// show_debug_message(buffer_tell(buffer));

// buffer_write(buffer, buffer_u8, 1);
// show_debug_message(buffer_tell(buffer));

// buffer_write(buffer, buffer_u8, 1);
// show_debug_message(buffer_tell(buffer));

// show_debug_message("")
// show_debug_message(buffer_get_size(buffer))