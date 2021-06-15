
#region array_presset
var array, arset;

arset = [1, 5, 2, 2];
array = array_presset([], arset);
debug_assert(array_equals(array, arset), "array_presset - 0");

arset = [];
array = array_presset(array, arset);
debug_assert(array_equals(array, arset), "array_presset - 1");

arset = [1, 23, 1];
array = array_presset(array, arset);
debug_assert(array_equals(array, arset), "array_presset - 2");

#endregion

#region array_place
var array, artst;

array = [1, 4,  2,    8, 1, 5, 13];
artst = [1, 4, -1, "hi", 1, 5, 13];
array_place(array, 2, -1, "hi");
debug_assert(array_equals(array, artst), "array_place - 0");


array = [1, 4, 2, 1];
artst = array;
array_place(array, 2);
debug_assert(array_equals(array, artst), "array_place - 1");

array = ["mes", [], 0];
artst = ["mes", [], 0, 0, 0, 0, "hi", 1];
array_place(array, 6, "hi", 1);
debug_assert(array_equals(array, artst), "array_place - 2");

#endregion

#region array_concat
var array, artst;

array = [1,   2, 3, 4];
artst = [-1, -2, 3, undefined, 0];
array_place_ext(array, 0, [-1, -2], 3, undefined, [0]);
debug_assert(array_equals(array, artst), "array_concat - 0");

array = [1, 2, 3];
artst = [1, 2, 3, "hello", -1, -2];
array_place_ext(array, undefined, "hello", [-1, -2]);
debug_assert(array_equals(array, artst), "array_concat - 1");


array = [1, 4,  2,    8, 1, 5, 13];
artst = [1, 4, -1, "hi", 1, 5, 13];
array_place_ext(array, 2, [-1], "hi");
debug_assert(array_equals(array, artst), "array_concat - 2");

array = [1, 4, 2, 1];
artst = array;
array_place_ext(array, 4);
debug_assert(array_equals(array, artst), "array_concat - 3");

#endregion

#region array_insert_row
var array, artst;

array = [1, 2, 3, 4];
artst = [1, 2, 3, 4, 0, 3, 4];
array_insert_row(array, 2, 3);
debug_assert(array_equals(array, artst), "array_insert_row - 0");

array = [1, 2, 3, 4];
artst = [1, 2, 3, 4, 1, 2, 3, 4];
array_insert_row(array, 0, 4);
debug_assert(array_equals(array, artst), "array_insert_row - 1");

array = [1, 2, 3, 4];
artst = [7, 7, 7, 7, 1, 2, 3, 4];
array_insert_row(array, 0, 4, 7);
debug_assert(array_equals(array, artst), "array_insert_row - 2");

array = [1, 2, 3, 4];
artst = [1, 2, 3, 4, 0, 0];
array_insert_row(array, 4, 2);
debug_assert(array_equals(array, artst), "array_insert_row - 3");

array = [1, 2, 3, 4];
artst = [1, 2, 3, 4, "z", "z"];
array_insert_row(array, 4, 2, "z");
debug_assert(array_equals(array, artst), "array_insert_row - 4");

array = [1, 2, 3, 4];
artst = [1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 10, 11, 12, 13
array_insert_row(array, 10, 4);
debug_assert(array_equals(array, artst), "array_insert_row - 5");

array = [1, 2, 3, 4];
artst = ["hi", "hi", 1, 2, 3, 4, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7];
array_insert_row(array, 10, 6, 7);
array_insert_row(array, 0, 2, "hi");
debug_assert(array_equals(array, artst), "array_insert_row - 6");

#endregion

#region array_unshift
var array, artst, count;

array = [1, 2, 3, 4];
artst = [-1, -2, 1, 2, 3, 4];
count = array_unshift(array, -1, -2);
debug_assert(array_equals(array, artst), "array_unshift - 0");
debug_assert(count == 2, "array_unshift - 0.count");

array = [1, 4, 2, 1];
artst = array;
count = array_unshift(array);
debug_assert(array_equals(array, artst), "array_unshift - 1");
debug_assert(count == 0, "array_unshift - 1.count");

array = [1, 2, 3, 4];
artst = [-1, -2, "sdf", undefined, 1, 2, 3, 4];
count = array_unshift(array, -1, -2, "sdf", undefined);
debug_assert(array_equals(array, artst), "array_unshift - 2");
debug_assert(count == 4, "array_unshift - 2.count");

#endregion

#region array_shift



#endregion
