

#macro _ undefined


#macro API_MACRO_ARGUMENT_PACK_READ var __argSize = argument_count;           \
									var __argArrs = array_create(__argSize);  \
									for (var __i = 0; __i < __argSize; ++__i) \
										__argArrs[__i] = argument[__i];                                          

#macro API_MACRO_ARGUMENT_PACK_GET  __argArrs
