
function ApiStringBuilder() constructor
{
	
	self.__buffer = buffer_create(32, buffer_grow, 1);
	
	static push = function() {
	    
	    var _argSize = argument_count;
		for (var _i = 0; _i < _argSize; ++_i) {
		    
			buffer_write(self.__buffer, buffer_text, argument[_i]);
		}
		return self;
	}
	
	static bufferAdd = function(_buffer) {
	    
		buffer_copy(_buffer, 0, buffer_tell(_buffer), self.__buffer, buffer_tell(self.__buffer));
		return self;
	}
	
	static clear = function() {
	    
		buffer_seek(self.__buffer, buffer_seek_start, 0);
	}
	
	static render = function() {
	    
		var _seek = buffer_tell(self.__buffer);
		buffer_write(self.__buffer, buffer_u8, 0);
		buffer_seek(self.__buffer, buffer_seek_start, 0);
		var _string = buffer_read(self.__buffer, buffer_string);
		buffer_seek(self.__buffer, buffer_seek_start, _seek);
		return _string;
	}
	
	static free = function() {
	    
		buffer_delete(self.__buffer);
	}
	
	static close = function() {
	    
		var _string = self.render();
		self.free();
		return _string;
	}
	
	static bufferTake = function() {
	    
	    var _take = self.buffer;
	    delete self.__buffer;
		return _take;
	}
	
	static toString = function() {
	    
	    var _result = "[";
	}
	
}
