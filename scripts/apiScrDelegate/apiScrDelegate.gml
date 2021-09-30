
function ApiDelegate() constructor {
	
	#region __private
	
	self.__lolist = new ApiLListO();
	self.__last = undefined;
	
	#endregion
	
	static append = function(_f) {
		
		if (self.__last == undefined) {
			self.__last = self.__lolist.insBegin(_f);	
		}
		else {
			self.__last = self.__lolist.insAfter(_f);
		}
	}
	
}

