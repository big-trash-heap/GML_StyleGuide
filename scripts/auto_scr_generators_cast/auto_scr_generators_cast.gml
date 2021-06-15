

/// @function generator_bung(value);
function generator_bung() {
	static bung = function() {
		return self.__bung;
	};
	return method({__bung : argument[0]}, bung);
}

