

function apiSelfSet(_key, _value) {
	if (_value != undefined) self[$ _key] = _value;
}


function __apiSelfSet(_key, _value) {
	self[$ _key] = _value;
	return self;
}

function __apiSelfImpl(_struct) {
	return apiStructMerge(self, _struct, true);
}

