
function GeneratorCompareEq(left) {
	static compareRight = function(right) {
		return (self.left == right);
	}
	return method({left: left}, compareRight);
}
