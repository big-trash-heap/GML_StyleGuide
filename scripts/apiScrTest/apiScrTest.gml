
#macro API_TEST_ENABLE true
#macro API_TEST_ALL    false

#macro API_TEST_LOCAL  var _enable =
#macro API_TEST        (API_TEST_ALL || _enable)

#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL false
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrTest"
		);
		
		show_debug_message("\t<template>");
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion