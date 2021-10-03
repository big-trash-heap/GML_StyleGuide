
API_GML_WARN_ARGS ApiTimer;

#region abstract-class

function ApiTimer() constructor {
	
	#region __private
	
	API_GML_WARN_ARGS [__init, __tick, __kill];
	
	static __init = apiFunctorEm /* TimerHandler, llist-cell */;
	static __tick = apiFunctorEm /* arg, self                */;
	static __kill = apiFunctorEm /* TimerHandler             */;
	
	#endregion
	
}

#endregion

