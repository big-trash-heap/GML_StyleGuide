
function debug_assert(assert, mess) {
	if (!assert) {
		throw ("\n\t" + mess);
	}
}
