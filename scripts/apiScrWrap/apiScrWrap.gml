

function __ApiWrap() constructor {
	
	static _set = __apiSelfSet;
	static _impl = __apiSelfImpl;
	
}

function __apiIsWrap(_wrap) {
	return (instanceof(_wrap) == "__ApiWrap");
}

