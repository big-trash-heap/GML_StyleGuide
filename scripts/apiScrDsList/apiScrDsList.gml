
function apiDListResize(_id, _size) {
	var _idSize = ds_list_size(_id);
	if (_size > _idSize) {
		
		repeat (_size - _idSize) ds_list_add(_id, 0);
	}
	else {
		
		while (_size != _idSize) ds_list_delete(_id, --_idSize);
	}
}
