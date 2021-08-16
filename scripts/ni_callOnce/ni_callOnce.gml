/*
#macro API_CALL_ONCE if(__apiCallOnce())exit;

function __apiCallOnce() {
	static _fcall = apiScrPragma();
	
	var _call = debug_get_callstack()[1];
	show_debug_message(_call)
	if (!variable_struct_exists(global.__apiCallOnceMap, _call)) {
		global.__apiCallOnceMap[$ _call] = undefined;
		return false;
	}
	return true;
}

#region private

if (variable_global_exists("__apiCallOnceMap")) exit;

global.__apiCallOnceMap = {};

#endregion
