

function __ApiWrap() constructor {
	
	static _set = function(_key, _value) {
		self[$ _key] = _value;
		return self;	
	}
	
}

function __apiIsWrap(_wrap) {
	return (instanceof(_wrap) == "__ApiWrap");
}

