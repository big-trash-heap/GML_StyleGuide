
/*
	Данный инструмент используется, для добавления кода в очередь исполнения
	Pragma код, который будет выполнен при старте игры (комнаты apiRoomPragma)
	Final код, который будет выполнен при завершении игры
*/

/// @function		apiPragma(loader, [priority=0]);
function apiPragma(_loader, _priority=0) {
	__apiAppendHeap("__apiPragmaHeap", "project", _loader, _priority);
}

/// @function		apiFinal(final, [priority=0]);
function apiFinal(_final, _priority=0) {
	__apiAppendHeap("__apiFinalHeap", "project", _final, _priority);
}

/// @function		__apiPragma(loader, [priority=0]);
/// @description	Имеет более высокий приоритет, чем apiPragma
function __apiPragma(_loader, _priority=0) {
	__apiAppendHeap("__apiPragmaHeap", "api", _loader, _priority);
}

/// @function		__apiFinal(final, [priority=0]);
/// @description	Имеет более низкий приоритет, чем apiFinal
function __apiFinal(_final, _priority=0) {
	__apiAppendHeap("__apiFinalHeap", "api", _final, _priority);
}


#region private

function __apiEmmitPragma() {
	
	__apiEmmitHeap("__apiPragmaHeap", "api");
	__apiEmmitHeap("__apiPragmaHeap", "project");
	
}

function __apiEmmitFinal() {
	
	__apiEmmitHeap("__apiFinalHeap", "project");
	__apiEmmitHeap("__apiFinalHeap", "api");
}

function __apiEmmitHeap(_gname, _key) {
	var _pack = variable_global_get(_gname);
	var _heap = _pack[$ _key];
	while (!ds_priority_empty(_heap)) ds_priority_delete_max(_heap)();
	ds_priority_destroy(_heap);
	_pack[$ _key] = -1;
}

function __apiAppendHeap(_gname, _key, _f, _priority) {
	if (!variable_global_exists("__apiPragmaHeap")) apiScrPragma();
	ds_priority_add(variable_global_get(_gname)[$ _key], _f, _priority);
}

function __apiFreePragma() {
	
	var _keys = ["api", "project"];
	__apiFreeHeap("__apiPragmaHeap", _keys);
	__apiFreeHeap("__apiFinalHeap", _keys);
}

function __apiFreeHeap(_gname, _keys) {
	if (variable_global_exists(_gname)) {
		
		var _pack = variable_global_get(_gname);
		if (!is_struct(_pack)) exit;
		
		var _size = array_length(_keys), _heap;
		for (var _i = 0; _i < _size; ++_i) {
			if (variable_struct_exists(_pack, _keys[_i])) {
				_heap = _pack[$ _keys[_i]];
				_pack[$ _keys[_i]] = -1;
				if (ds_exists(_heap, ds_type_priority))
					ds_priority_destroy(_heap);
			}
		}
	}
}

#region global struct

if (variable_global_exists("__apiPragmaHeap")) exit;

global.__apiPragmaHeap = apiStructBul(
	["api",     ds_priority_create()],
	["project", ds_priority_create()],
);

global.__apiFinalHeap = apiStructBul(
	["api",     ds_priority_create()],
	["project", ds_priority_create()],
);

#endregion

#endregion

