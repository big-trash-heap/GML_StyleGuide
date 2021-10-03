
API_GML_WARN_ARGS ApiTimer;
API_GML_WARN_ARGS [__init, __tick, __kill];

#region abstract-class

function ApiTimer() constructor {
	
	#region __private
	
	static __init = apiFunctorEm /* TimerHandler, llist-cell */;
	static __tick = apiFunctorEm /* arg, self                */;
	static __kill = apiFunctorEm /* TimerHandler             */;
	
	#endregion
	
}

#endregion

