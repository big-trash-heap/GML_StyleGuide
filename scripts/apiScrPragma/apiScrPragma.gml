
//
#macro API_PRAGMA_NAME apiScrPragma

//
if (variable_global_exists("__apiPragmaHeap")) exit;

//
global.__apiPragmaHeap = apiStructBul(
	["api",     ds_priority_create()],
	["project", ds_priority_create()],
);

global.__apiFinal = ds_list_create();

/// @function		apiPragma(loader, [int_priority=0]);
/// @param loader
/// @param [int_priority=0]
function apiPragma(_loader, _intPriority=0) {
	
	if (!variable_global_exists("__apiPragmaHeap")) API_PRAGMA_NAME();
	ds_priority_add(global.__apiPragmaHeap[$ "project"], _loader, _intPriority);
}

/// @function		apiFinal(final);
/// @param final
function apiFinal(_final) {
	
	if (!variable_global_exists("__apiPragmaHeap")) API_PRAGMA_NAME();
	ds_list_add(global.__apiFinal, _final);
}

/// @function		__apiPragma(loader, [int_priority=0]);
/// @param loader
/// @param [int_priority=0]
function __apiPragma(_loader, _intPriority=0) {
	
	if (!variable_global_exists("__apiPragmaHeap")) API_PRAGMA_NAME();
	ds_priority_add(global.__apiPragmaHeap[$ "api"], _loader, _intPriority);
}

function __apiEmmitPragma() {
	var _heap;
	
	_heap = global.__apiPragmaHeap[$ "api"];
	while (!ds_priority_empty(_heap)) ds_priority_delete_max(_heap)();
	ds_priority_destroy(_heap);
	global.__apiPragmaHeap[$ "api"] = -1;
	
	_heap = global.__apiPragmaHeap[$ "project"];
	while (!ds_priority_empty(_heap)) ds_priority_delete_max(_heap)();
	ds_priority_destroy(_heap);
	global.__apiPragmaHeap[$ "project"] = -1;
	
}

function __apiEmmitFinal() {
	
	var _size = ds_list_size(global.__apiFinal);
	for (var _i = 0; _i < _size; ++_i)
		ds_list_find_value(global.__apiFinal, _i)();
	
	ds_list_destroy(global.__apiFinal);
	global.__apiFinal = -1;
}

function __apiPragmaFree() {
	
	if (variable_global_exists("__apiPragmaHeap") && is_struct(global.__apiPragmaHeap)) {
		
		var _heap;
		if (variable_struct_exists(global.__apiPragmaHeap, "api")) {
			
			_heap = global.__apiPragmaHeap[$ "api"];
			if (ds_exists(_heap, ds_type_priority)) {
				
				ds_priority_destroy(_heap);
				global.__apiPragmaHeap[$ "api"] = -1;
			}
		}
		if (variable_struct_exists(global.__apiPragmaHeap, "project")) {
			
			_heap = global.__apiPragmaHeap[$ "project"];
			if (ds_exists(_heap, ds_type_priority)) {
				
				ds_priority_destroy(_heap);
				global.__apiPragmaHeap[$ "project"] = -1;
			}
		}
	}
		
	if (variable_global_exists("__apiFinal") && ds_exists(global.__apiFinal, ds_type_list)) {
		
		ds_list_destroy(global.__apiFinal);
		global.__apiFinal = -1;
	}
	
}
