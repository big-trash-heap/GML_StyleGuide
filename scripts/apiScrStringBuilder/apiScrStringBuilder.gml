
/// @function ApiStringBuilder(?buffer_grow);
/// @param ?buffer_grow
function ApiStringBuilder(_bufferGrow) constructor {
	
	self.buffer = (is_undefined(_bufferGrow) ? buffer_create(32, buffer_grow, 1) : _bufferGrow);
	
	static push = function() {
	    
	    var _argSize = argument_count;
		for (var _i = 0; _i < _argSize; ++_i) 
			buffer_write(self.buffer, buffer_text, argument[_i]);
		
		return self;
	}
	
	static merge = function(_buffer, _offset, _size) {
	    
	    if (is_undefined(_offset)) _offset = 0;
	    if (is_undefined(_size)) _size = buffer_tell(_buffer) - _offset;
	    
	    apiBufferCopy(self.buffer, _buffer, buffer_tell(self.buffer), _offset, _size);
		buffer_seek(self.buffer, buffer_seek_relative, _size);
		
		return self;
	}
	
	static clear = function() {
	    
		buffer_seek(self.buffer, buffer_seek_start, 0);
	}
	
	static render = function() {
	    
		var _seek = buffer_tell(self.buffer);
		buffer_write(self.buffer, buffer_u8, 0);
		buffer_seek(self.buffer, buffer_seek_start, 0);
		var _string = buffer_read(self.buffer, buffer_string);
		buffer_seek(self.buffer, buffer_seek_start, _seek);
		return _string;
	}
	
	static free = function() {
	    
		buffer_delete(self.buffer);
		self.buffer = -1;
	}
	
	static close = function() {
	    
		var _string = self.render();
		self.free();
		return _string;
	}
	
	static toString = function() {
	    
	    return (self.buffer == -1 ? "<no buffer>" : apiToStringBuffer(self.buffer));
	}
	
}
