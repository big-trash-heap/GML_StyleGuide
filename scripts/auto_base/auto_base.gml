
//
if (variable_global_exists("Base")) exit;

//
enum BaseLoader {init, exec, noth};

//
globalvar Base;
Base = {};

//
var loadElement = {};
loadElement.registor   = undefined;
loadElement.loadModule = [];

Base.loaderStage       = BaseLoader.init;
Base.loaderCurrent     = loadElement;
Base.loaderStack       = [];

//
#macro pickup          if(____pickup(
#macro regist          if(____regist(
#macro complete        ))exit

//
function ____pickup(scriptLoad) {
	
	auto_base();
	scriptLoad = ____loaderGetScript(scriptLoad);
	
	if (Base.loaderStage == BaseLoader.init) array_push(Base.loaderCurrent.loadModule, scriptLoad);
	return Base.loaderStage == BaseLoader.noth;
}

function ____regist(scriptRegist) {
	
	auto_base();
	scriptRegist = ____loaderGetScript(scriptRegist);
	
	if (Base.loaderStage == BaseLoader.init) {
		
		Base.loaderCurrent.registor = scriptRegist;
		array_push(Base.loaderStack, Base.loaderCurrent);
		
		var loadElement = {};
		loadElement.registor   = undefined;
		loadElement.loadModule = [];
		Base.loaderCurrent = loadElement;
		return true;
	}
	return false;
}

function ____loaderGetScript(script_name)
{ 
	var script_id = script_name;
	if (is_string(script_id))
	{
		script_id = asset_get_index(script_id);
	}
	if (!script_exists(script_id))
	{
		show_error("[loader]<обнаружен не существующий скрипт, переданный аргументом '" + string(script_name) + "'>", true);
	}
	return script_id;
}

//
Base.loaderRunner = function() {
	
	var stack = Base.loaderStack;
	variable_struct_remove(Base, "loaderStack");
	variable_struct_remove(Base, "loaderCurrent");
	variable_struct_remove(Base, "loaderRunner");
	
	Base.loaderStage = BaseLoader.exec;
	
	var i, j, cell;
	var modules, modulesSize, modul;
	var sizeStack = array_length(stack);
	var loadMap = {};
	var flag;
	while (true) {
		
		flag = true;
		i = 0;
		while (i < sizeStack) {
			
			cell = stack[i];
			modules = cell.loadModule;
			modulesSize = array_length(modules);
			if (modulesSize == 0) {
				
				flag = false;
				cell.registor();
				stack[@ i] = stack[--sizeStack];
				array_resize(stack, sizeStack);
				
				loadMap[$ string(cell.registor)] = undefined;
			} else {
				
				i += 1;
				j = 0;
				while (j < modulesSize) {
					
					modul = modules[j];
					if (variable_struct_exists(loadMap, string(modul))) {
						
						flag = false;
						modules[@ j] = modules[--modulesSize];
						array_resize(modules, modulesSize);
					} else {
						
						j += 1;
					}
				}
			}
		}
		if (i == 0) {
			break;
		}
		if (flag) {
			show_error("[loader]<обнаружена рекурсивная зависимость в загрущике>", true);
		}
	}
	
	Base.loaderStage = BaseLoader.noth;
}

