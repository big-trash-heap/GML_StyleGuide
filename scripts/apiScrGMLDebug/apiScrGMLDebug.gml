/* не используется в api */

#macro ____API_DEBUG	true
#macro debug			if (____API_DEBUG && apiFunctorId(true, apiDebugPrint("\n!! debug: ", debug_get_callstack())))
#macro log				apiDebugPrint
