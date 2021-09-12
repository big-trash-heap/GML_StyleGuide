
#macro __debug	true
#macro debug	if (__debug) if (apiFunctorId(true, apiDebugPrint("\n!! debug: ", debug_get_callstack())))
