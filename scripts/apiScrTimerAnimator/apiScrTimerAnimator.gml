
enum API_TIMER_ANIMATOR { STOP, AWAIT, NEXT };

function ApiTimerAnimator() : ApiTimer() constructor {

	#region __private
	
	enum __API_TIMER_ANIMATOR_STACK { FRAME,  BREAK };
	enum __API_TIMER_ANIMATOR_FRAME { ACTION, AWAIT };
	
	static __init = function(_timer) {
		
		_timer.__stack = ds_queue_create();
		_timer.add_frame();
	}
	
	static __kill = function(_timer) {
		
		while (!ds_queue_empty(_timer.__stack))
			ds_list_destroy(ds_queue_dequeue(_timer.__stack)[__API_TIMER_ANIMATOR_STACK.FRAME]);
		
		ds_queue_destroy(_timer.__stack);
		_timer.__stack = -1;
	}
	
	static __tick = function(_timer) {
		
		if (ds_queue_empty(_timer.__stack)) return true;
		
		var _head = ds_queue_head(_timer.__stack);
		var _list = _head[__API_TIMER_ANIMATOR_STACK.FRAME];
		
		var _await = 0;
		var _cast;
		for (var _i = 0; _i < ds_list_size(_list); ++_i) {
			
			_cast = ds_list_find_value(_list, _i);
			if (_cast[0] == __API_TIMER_ANIMATOR_FRAME.AWAIT) {
				++_await;
				_cast[1](_timer, _cast[2]);
			}
			else {
				switch (_cast[1](_timer, _cast[2])) {
				
				case API_TIMER_ANIMATOR.STOP:
					return true;
					break;
				
				case API_TIMER_ANIMATOR.NEXT:
					ds_list_delete(_list, _i);
					--_i;
					break;
				}
			}
		}
		
		if (_await == ds_list_size(_list)) {
			var _break = _head[__API_TIMER_ANIMATOR_STACK.BREAK];
			var _size = array_length(_break);
			for (_i = 0; _i < _size; ++_i) {
				_cast = _break[_i];
				_cast[0](_timer, _cast[1]);
			}
			
			ds_list_destroy(_list);
			ds_queue_dequeue(_timer.__stack);
			
			if (ds_queue_empty(_timer.__stack)) return true;
		}
	}
	
	#endregion
	
	static add_action = function(_f, _data) {
		
		ds_list_add(ds_queue_tail(self.__stack)[__API_TIMER_ANIMATOR_STACK.FRAME], [
			__API_TIMER_ANIMATOR_FRAME.ACTION,
			_f,
			_data
		]);
		return self;
	}
	
	static add_await = function(_f, _data) {
		
		ds_list_add(ds_queue_tail(self.__stack)[__API_TIMER_ANIMATOR_STACK.FRAME], [
			__API_TIMER_ANIMATOR_FRAME.AWAIT,
			_f,
			_data
		]);
		return self;
	}
	
	static add_break = function(_f, _data) {
		
		array_push(ds_queue_tail(self.__stack)[__API_TIMER_ANIMATOR_STACK.BREAK], [
			_f,
			_data
		]);
		return self;
	}
	
	static add_frame = function() {
		ds_queue_enqueue(self.__stack, [
			ds_list_create(),
			[]
		]);
		return self;
	}
	
}

