
////#region apiArrayPlaceExt
////var _array, _artst;

////_array = [1,   2, 3, 4];
////_artst = [-1, -2, 3, undefined, 0];
////apiArrayPlaceExt(_array, 0, [-1, -2], 3, undefined, [0]);
////apiDebugAssert(array_equals(_array, _artst), "apiArrayPlaceExt - 0");

////_array = [1, 2, 3];
////_artst = [1, 2, 3, "hello", -1, -2];
////apiArrayPlaceExt(_array, undefined, "hello", [-1, -2]);
////apiDebugAssert(array_equals(_array, _artst), "apiArrayPlaceExt - 1");


////_array = [1, 4,  2,    8, 1, 5, 13];
////_artst = [1, 4, -1, "hi", 1, 5, 13];
////apiArrayPlaceExt(_array, 2, [-1], "hi");
////apiDebugAssert(array_equals(_array, _artst), "apiArrayPlaceExt - 2");

////_array = [1, 4, 2, 1];
////_artst = _array;
////apiArrayPlaceExt(_array, 4);
////apiDebugAssert(array_equals(_array, _artst), "apiArrayPlaceExt - 3");

////#endregion
	   
//#region apiArrayInsertEmpty
//var _array, _artst;

//_array = [1, 2, 3, 4];
//_artst = [1, 2, 3, 4, 0, 3, 4];
//apiArrayInsertEmpty(_array, 2, 3);
//apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 0");

//_array = [1, 2, 3, 4];
//_artst = [1, 2, 3, 4, 1, 2, 3, 4];
//apiArrayInsertEmpty(_array, 0, 4);
//apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 1");

//_array = [1, 2, 3, 4];
//_artst = [7, 7, 7, 7, 1, 2, 3, 4];
//apiArrayInsertEmpty(_array, 0, 4, 7);
//apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 2");

//_array = [1, 2, 3, 4];
//_artst = [1, 2, 3, 4, 0, 0];
//apiArrayInsertEmpty(_array, 4, 2);
//apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 3");

//_array = [1, 2, 3, 4];
//_artst = [1, 2, 3, 4, "z", "z"];
//apiArrayInsertEmpty(_array, 4, 2, "z");
//apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 4");

//_array = [1, 2, 3, 4];
//_artst = [1, 2, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 10, 11, 12, 13
//apiArrayInsertEmpty(_array, 10, 4);
//apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 5");

//_array = [1, 2, 3, 4];
//_artst = ["hi", "hi", 1, 2, 3, 4, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7];
//apiArrayInsertEmpty(_array, 10, 6, 7);
//apiArrayInsertEmpty(_array, 0, 2, "hi");
//apiDebugAssert(array_equals(_array, _artst), "apiArrayInsertEmpty - 6");

//#endregion

//#region apiArrayUnshift
//var _array, _artst, _count;

//_array = [1, 2, 3, 4];
//_artst = [-1, -2, 1, 2, 3, 4];
//_count = apiArrayUnshift(_array, -1, -2);
//apiDebugAssert(array_equals(_array, _artst), "apiArrayUnshift - 0");
//apiDebugAssert(_count == 2, "apiArrayUnshift - 0._count");

//_array = [1, 4, 2, 1];
//_artst = _array;
//_count = apiArrayUnshift(_array);
//apiDebugAssert(array_equals(_array, _artst), "apiArrayUnshift - 1");
//apiDebugAssert(_count == 0, "apiArrayUnshift - 1._count");

//_array = [1, 2, 3, 4];
//_artst = [-1, -2, "sdf", undefined, 1, 2, 3, 4];
//_count = apiArrayUnshift(_array, -1, -2, "sdf", undefined);
//apiDebugAssert(array_equals(_array, _artst), "apiArrayUnshift - 2");
//apiDebugAssert(_count == 4, "apiArrayUnshift - 2._count");

//#endregion

//#region apiArrayShift
//var _array = [1, 2, 3, 4];

//apiDebugAssert(1 == apiArrayShift(_array), "apiArrayShift - 0");
//apiDebugAssert(2 == apiArrayShift(_array), "apiArrayShift - 1");
//apiDebugAssert(3 == apiArrayShift(_array), "apiArrayShift - 2");
//apiDebugAssert(4 == apiArrayShift(_array), "apiArrayShift - 3");
//apiDebugAssert(_ == apiArrayShift(_array), "apiArrayShift - 4");
//apiDebugAssert(array_length(_array) == 0, "apiArrayShift - 5");

//#endregion

//#region apiArrayShuffle
//var _array = [[], [], [], []];
//var _tester = function(_array_test, _msg) {
//    var _size = array_length(_array_test);
//    var _copy = array_create(_size);
//    array_copy(_copy, 0, _array_test, 0, _size);
//    var _seed = random_get_seed();
//    randomize();
//    apiArrayShuffle(_copy);
//    var _counter = _size;
//    for (var _i = 0; _i < _size; ++_i) {
        
//        for (var _j = 0; _j < _size; ++_j) {
            
//            if (_array_test[_i] == _copy[_j]) {
                
//                _counter -= 1;
//                break;
//            }
//        }
//    }
//    random_set_seed(_seed);
//    apiDebugAssert(_counter == 0, _msg);
//}

//var _percent = 0;
//repeat 100 {
//    var _size = array_length(_array);
//    var _copy = array_create(_size);
//    array_copy(_copy, 0, _array, 0, _size);
//    apiArrayShuffle(_copy);
//    for (var _i = 0; _i < _size; ++_i) {
        
//        if (_array[_i] != _copy[_i]) {
            
//            _percent += 1;
//            break;
//        }
//    }
//}

//apiDebugAssert(_percent > 0, "apiArrayShuffle - main");

//repeat 100 _tester(_array, "apiArrayShuffle - 0");
//_tester([[], [], [], [], {}, [], 1, "hello"], "apiArrayShuffle - 1");
//_tester([1, 2, 3], "apiArrayShuffle - 2");

//#endregion

//#endregion

//apiPragma(function() {
    
//    show_message("good job");
//    game_end();
//});

