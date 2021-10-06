
window_set_size(1366, 768);

timers = new ApiTimerHandler();

timer = timers.append(new ApiTimerSyncTimeout(100, 
	function() {
		show_debug_message("end");
	},
	function() {
		show_debug_message(" << end");
	})
);

timers.append(new ApiTimerSyncTimeout(50, 
	function() {
		show_debug_message("hello");
	},
	function() {
		show_debug_message(" << hello");
	})
);

timer.rem();
