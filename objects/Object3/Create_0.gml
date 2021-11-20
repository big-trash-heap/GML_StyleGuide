
window_set_size(1366, 768);




//timer = apiTHand_async(5000, function(_timer) {
//	show_debug_message(["hello", _timer.getLeftCf()]);
//}, _, function(_timer) {
//	show_debug_message("<< hello");
//	_timer.resetTime(true);
//	apiTHand_timer(_timer);
//});
//timer.pause();

//apiTHand_end_async(2500, function() {
//	show_message("hello");
//	timer.resume();
//});



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
