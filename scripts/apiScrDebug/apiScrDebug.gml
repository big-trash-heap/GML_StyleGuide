
function apiDebugAssert(_assert, _mess) {
	if (!_assert) {
		throw ("\n\t" + _mess);
	}
}
