/*
#region compare

/// @function apiMethodGenCompareEq(left)
/// @param left
function apiMethodGenCompareEq(_left) {
	static _compareRight = function(_right) {
		return (self.__left == _right);
	}
	return method({__left: _left}, _compareRight);
}

#endregion

#region return

/// @function apiMethodGenReturnId(id)
/// @param id
function apiMethodGenReturnId(_id) {
	static _returnId = function() {
		return self.__id;
	}
	return method({__id: _id}, _returnId);
}

#endregion
