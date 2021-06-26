
//
if (variable_global_exists("__apiLoader")) exit;

//
global.__apiLoader =
	{ api: ds_priority_create()
	, project: ds_priority_create()
	};

//
function apiLoader(intPriority, loader) {
	
	apiScrLoader();
	ds_priority_add(global.__apiLoader.project, loader, intPriority);
}

function __apiLoader(intPriority, loader) {
	
	apiScrLoader();
	ds_priority_add(global.__apiLoader.api, loader, intPriority);
}

function __apiLoaderLoad() {
	var heap;
	
	heap = global.__apiLoader.api;
	while (!ds_priority_empty(heap)) {
		ds_priority_delete_min(heap)();
	}
	ds_priority_destroy(heap);
	
	heap = global.__apiLoader.project;
	while (!ds_priority_empty(heap)) {
		ds_priority_delete_min(heap)();
	}
	ds_priority_destroy(heap);
}
