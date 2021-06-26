
// f = function(index, data)
function iterator_range(indexBegin, indexEnd, step, f, _data, _fbegin) {
	if (sign(indexEnd - indexBegin) == sign(step)) {
		
		
	}
	
	
	var build = [];
	if (sign(indexEnd - indexBegin) == sign(step)) {
		while (indexBegin <= indexEnd) {
			f(indexBegin, _data);
			indexBegin += step;
		}
	}
	return build;
}
 