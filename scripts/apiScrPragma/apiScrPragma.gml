
//
#macro API_PRAGMA_NAME  apiScrPragma

//
if (variable_global_exists("__apiPragmaHeap")) exit;

//
global.__apiPragmaHeap = apiStructBuild(
	["api",     ds_priority_create()],
	["project", ds_priority_create()],
);

/// @function apiPragma(loader, [int_priority=0]);
/// @param loader
/// @param [int_priority=0]
function apiPragma(_loader, _intPriority=0) {
	
	if (!variable_global_exists("__apiPragmaHeap")) API_PRAGMA_NAME();
	ds_priority_add(global.__apiPragmaHeap[$ "project"], _loader, _intPriority);
}

/// @function __apiPragma(loader, [int_priority=0]);
/// @param loader
/// @param [int_priority=0]
function __apiPragma(_loader, _intPriority=0) {
	
	if (!variable_global_exists("__apiPragmaHeap")) API_PRAGMA_NAME();
	ds_priority_add(global.__apiPragmaHeap[$ "api"], _loader, _intPriority);
}

function __apiPragmaEmmit() {
	var _heap;
	
	_heap = global.__apiPragmaHeap[$ "api"];
	while (!ds_priority_empty(_heap)) ds_priority_delete_max(_heap)();
	ds_priority_destroy(_heap);
	
	_heap = global.__apiPragmaHeap[$ "project"];
	while (!ds_priority_empty(_heap)) ds_priority_delete_max(_heap)();
	ds_priority_destroy(_heap);
	
}

