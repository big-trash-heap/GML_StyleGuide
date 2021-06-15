
enum ComparatorEnum
	{ lt = -1
	, eq = 0
	, gt = 1
	};

function ComparatorNumber(left, right) {
	 var comp = sign(left - right);
	 if (comp == 0) {
		 return ComparatorEnum.eq;
	 }
	 else
	 if (comp == 1) {
		 return ComparatorEnum.gt;
	 }
	 return ComparatorEnum.lt;
}

function ComparatorStringLexical(left, right) { // лексикографическое
	var size_left = string_length(left);
	var size_right = string_length(right);
	
	if (size_left != size_right) return ComparatorNumber(size_left, size_right);
	
	var char_left, char_right;
	for (var i = 1; i <= size_left; i++) {
		
		char_left = string_char_at(left, i);
		char_right = string_char_at(right, i);
		
		if (char_left != char_right) return ComparatorNumber(ord(char_left), ord(char_right));
	}
	return ComparatorEnum.eq;
}

function ComparatorStringLength(left, right) { // по длинам строк
	return ComparatorNumber(string_length(left), string_length(right));
}
