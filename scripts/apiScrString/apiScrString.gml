
/// @function apiStringStartsWith(substring, string, ?pos);
/// @param substring
/// @param string
/// @param ?pos
function apiStringStartsWith(_substring, _string, _position) {
    if (is_undefined(_position)) _position = 1;
    return (string_pos(_substring, string_delete(_string, 1, _position - 1)) == 1);
}

/// @function apiStringEndsWith(substring, string, ?length);
/// @param substring
/// @param string
/// @param ?length
function apiStringEndsWith(_substring, _string, _length) {
    if (is_undefined(_length)) _length = string_length(_string);
    return (string_last_pos(_substring, string_copy(_string, 1, _length)) == _length - string_length(_substring) + 1);
}

/// @function apiStringRange(string, index_begin, index_end);
/// @param substring
/// @param index_begin
/// @param index_end
function apiStringRange(_string, _indexBegin, _indexEnd) {
	return string_copy(_string, _indexBegin, _indexEnd - _indexBegin + 1);
}

//

//
// function stringExt_replace_count(_substring, _string, _index, _count) {
// 	if (_count <= 0) return string_insert(_substring, _string, _index);
// 	if (_index < 1) or (_index-- > string_length(_string)) throw "";
// 	return stringExt_concat(string_copy(_string, 1, _index), _substring, string_delete(_string, 1, _index + _count));
// }

// //
// function stringExt_replace_pos(_substring, _string, _index_begin, _index_end) {
// 	return stringExt_replace_count(_substring, _string, _index_begin, _index_end - _index_begin + 1);
// }