

function generator_compare_eq(left) {
	static compareRight = function(right) {
		return (self.__left == right);
	}
	return method({__left: left}, compareRight);
}

