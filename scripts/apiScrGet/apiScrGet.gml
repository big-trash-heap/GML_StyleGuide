

function apiGetBoolT() { return true;  };
function apiGetBoolF() { return false; };

function apiGetAny(_value) {
	static _any = apiFunctorFunc(function() {
		return self.value;
	});
	return method({ value: _value }, _any);
}

