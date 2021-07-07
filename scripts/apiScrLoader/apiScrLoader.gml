
//
if (variable_global_exists("__apiLoaderHeap")) exit;

//
global.__apiLoaderHeap = apiStructBuild(
	["api", ds_priority_create()],
	["project", ds_priority_create()],
);

/// @function apiLoader(loader, intPriotiry=0);
/// @param loader
/// @param intPriotiry=0
function apiLoader(_loader, _intPriority) {
	
	if (is_undefined(_intPriority)) _intPriority = 0;
	
	apiScrLoader();
	ds_priority_add(global.__apiLoaderHeap[$ "project"], _loader, _intPriority);
}

/// @function __apiLoader(loader, intPriotiry=0);
/// @param loader
/// @param intPriotiry=0
function __apiLoader(_loader, _intPriority) {
	
	if (is_undefined(_intPriority)) _intPriority = 0;
	
	apiScrLoader();
	ds_priority_add(global.__apiLoaderHeap[$ "api"], _loader, _intPriority);
}

function __apiLoaderLoad() {
	var _heap;
	
	_heap = global.__apiLoaderHeap[$ "api"];
	while (!ds_priority_empty(_heap)) ds_priority_delete_min(_heap)();
	ds_priority_destroy(_heap);
	
	_heap = global.__apiLoaderHeap[$ "project"];
	while (!ds_priority_empty(_heap)) ds_priority_delete_min(_heap)();
	ds_priority_destroy(_heap);
	
}











