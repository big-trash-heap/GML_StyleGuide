
window_set_size(1366, 768);

timers = new ApiTimerHandler();

timer = timers.append(new ApiTimerAsyncTimeout(500, 
	function() {
		show_debug_message("end");
	}, _,
	function() {
		show_debug_message(" << end");
	})
);

timers.append(new ApiTimerLoop(
	function() {
		show_debug_message("hello");
	}, _,
	function() {
		show_debug_message(" << hello");
	})
);

//timer.rem();
//show_message("work");
