
window_set_size(1366, 768);

apiTHand_loop(
	function(_timer) {
		
		if (_timer.timer != undefined) {
			_timer.timer.rem();
		}
		
		show_message(1);
		
		_timer.timer = apiTHand_loop(
			function(_timer) {
				show_message(_timer.num);
			}, _,
			function(_timer) {
				_timer.timer.rem();
				apiTHand_loop(
					function(_timer) {
						var _text = "&" + string(_timer.num);
						show_message(_text);
						if (_text == "&8") {
							
							var _t1 = apiTHand_loop();
							var _t2 = apiTHand_loop(_, _, function() { show_message(222); });
							var _t3 = apiTHand_loop();
							var _t4 = apiTHand_loop(_, _, function() { show_message(444); });
							
							_t2.rem();
							_t4.rem();
							
							apiTHand_timer(_t4);
							apiTHand_timer(_t2);
							
							var _save = self._fff;
							self._fff = undefined;
							
							global.__apiTimerHandler.clearAll();
							
							show_message("clearAll");
							show_message(_timer.isBind());
							
							apiTHand_timer(_timer);
							
							self._fff = _save;
							
							return true;
						}
					}, _,
					function(_timer) {
						var _text = "&" + string(_timer.num);
						if (_text == "&8") {
							show_message("fff()");
							if (self._fff != undefined) {
								self._fff();
								self._fff = undefined;
							}
						}
					}).set("num", _timer.num);
			}).set("num", ++_timer.num);
		
		var _t = apiTHand_loop(
			function(_timer) {
				show_message(_timer.num);
			}).set("num", ++_timer.num);
		
		_timer.timer.set("timer", _t);
		
		if (_timer.num > 8) {
			global.__apiTimerHandler.clear();
			return;
		}
		
	}, _,
	function() {
		show_message("clear");
	}).set("num", 1).set("timer", _);

_fff = function() {
	show_message(global.__apiTimerHandler.isEmpty());
	timer = apiTHand_async(5000, function(_timer) {
		show_debug_message(["hello", _timer.getLeftCf()]);
	}, _, function(_timer) {
		show_debug_message("<< hello");
		_timer.resetTime(true);
		apiTHand_timer(_timer);
	});
	timer.pause();

	apiTHand_end_async(2500, function() {
		show_message("hello");
		timer.resume();
	});
}


/*
timers = new ApiTimerHandler();

timer = timers.append(new ApiTimerAsyncTimeout(5000, 
	function() {
		show_debug_message("end");
	}, 
	function(_timer) {
	},
	function(_timer) {
		show_debug_message(" << end");
	})
);

//timers.append(new ApiTimerLoop(
//	function() {
//		show_debug_message(API_TIME_ASYNC_STEP);
//		show_debug_message("hello");
//	}, _,
//	function() {
//		show_debug_message(" << hello");
//	})
//);

//timer.rem();
//show_message(apiTimerHandlerIsBind(timer));
//timers.append(timer);
//show_message(apiTimerHandlerIsBind(timer));
//timer.setTime(500);

//timer.rem();
//show_message("work");
