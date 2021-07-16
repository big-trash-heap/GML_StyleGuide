
enum API_TREE_RB_TYPE {RED, BLACK};

//
function ApiTreeRB(_compare) constructor {
    
    #region private
    
    static __vertex = function(_key, _value, _color, _left, _right, _parent) constructor {
        
        self.value  = _value;
        self.key    = _key;
        self.color  = _color;
        self.left   = _left;
        self.right  = _right;
        self.parent = _parent;
        
    }
    
    static __nil = function() {
        
        var _nil = new self.__vertex(0, 0, API_TREE_RB_TYPE.BLACK, _, _, _);
        _nil.left  = _nil;
        _nil.right = _nil;
        
        return _nil;
    }();
    
    static __rotate = function(_x, _left, _right) {
        
        var _y = _x[$ _right];
        
        _x[$ _right] = _y[$ _left];
        if (_y[$ _left] != self.__nil)
            _y[$ _left].parent = _x;
        
        if (_y != self.__nil)
            _y.parent = _x.parent;
        
        if (_x.parent != undefined) {
            
            if (_x == _x.parent[$ _left])
                _x.parent[$ _left] = _y;
            else
                _x.parent[$ _right] = _y;
        }
        else {
            
            self.__root = _y;
        }
        
        _y[$ _left] = _x;
        if (_x != self.__nil)
            _x.parent = _y;
    }
    
    static __insertFixupPart = function(_x, _left, _right) {
        
        
    }
    
    static __rotateLeft = function(_x) {
        
        self.__rotate(_x, "left", "right");
    }
    
    static __rotateRight = function(_x) {
        
        self.__rotate(_x, "right", "left");
    }
    
    static __insertFixup = function(_x) {
        
        var _y;
        while (_x != self.__root and _x.parent.color == API_TREE_RB_TYPE.RED) {
            
            if (_x.parent == _x.parent.parent.left) {
                
                _y = _x.parent.parent.right;
                if (_y.color == API_TREE_RB_TYPE.RED) {
                    
                    _x.parent.color = API_TREE_RB_TYPE.BLACK;
                    _y.color = API_TREE_RB_TYPE.BLACK;
                    _x.parent.parent.color = API_TREE_RB_TYPE.RED;
                    _x = _x.parent.parent;
                }
                else {
                    
                    if (_x == _x.parent.right) {
                        
                        _x = _x.parent;
                        self.__rotateLeft(_x);
                    }
                    
                    _x.parent.color = API_TREE_RB_TYPE.BLACK;
                    _x.parent.parent.color = API_TREE_RB_TYPE.RED;
                    self.__rotateRight(_x.parent.parent);
                }
            }
            else {
                
                _y = _x.parent.parent.left;
                if (_y.color == API_TREE_RB_TYPE.RED) {
                    
                    _x.parent.color = API_TREE_RB_TYPE.BLACK;
                    _y.color = API_TREE_RB_TYPE.BLACK;
                    _x.parent.parent.color = API_TREE_RB_TYPE.RED;
                    _x = _x.parent.parent;
                }
                else {
                    
                    if (_x == _x.parent.left) {
                        
                        _x = _x.parent;
                        self.__rotateRight(_x);
                    }
                    
                    _x.parent.color = API_TREE_RB_TYPE.BLACK;
                    _x.parent.parent.color = API_TREE_RB_TYPE.RED;
                    self.__rotateLeft(_x.parent.parent);
                }
            }
        }
        self.__root.color = API_TREE_RB_TYPE.BLACK;
    }
    
    static __deleteFixup = function(_x) {
        
        var _w;
        while (_x != self.__root and _x.color != API_TREE_RB_TYPE.BLACK) {
            
            if (_x == _x.parent.left) {
                
                _w = _x.parent.right;
                if (_w.color == API_TREE_RB_TYPE.RED) {
                    
                    _w.color = API_TREE_RB_TYPE.BLACK;
                    _x.parent.color = API_TREE_RB_TYPE.RED;
                    self.__rotateLeft(_x.parent);
                    _w = _x.parent.right;
                }
                if (_w.left.color == API_TREE_RB_TYPE.BLACK 
                    and _w.right.color == API_TREE_RB_TYPE.BLACK) {
                        
                    _w.color = API_TREE_RB_TYPE.RED;
                    _x = _x.parent;
                }
                else {
                    
                    if (_w.right.color == API_TREE_RB_TYPE.BLACK) {
                        
                        _w.left.color = API_TREE_RB_TYPE.BLACK;
                        _w.color = API_TREE_RB_TYPE.RED;
                        self.__rotateRight(_w);
                        _w = _x.parent.right;
                    }
                    _w.color = _x.parent.color;
                    _x.parent.color = API_TREE_RB_TYPE.BLACK;
                    _w.right.color = API_TREE_RB_TYPE.BLACK;
                    self.__rotateLeft(_x.parent);
                    _x = self.__root;
                }
            }
            else {
                
                _w = _x.parent.left;
                if (_w.color == API_TREE_RB_TYPE.RED) {
                    
                    _w.color = API_TREE_RB_TYPE.BLACK;
                    _x.parent.color = API_TREE_RB_TYPE.RED;
                    self.__rotateRight(_x.parent);
                    _w = _x.parent.left;
                }
                if (_w.right.color == API_TREE_RB_TYPE.BLACK
                    and _w.left.color == API_TREE_RB_TYPE.BLACK) {
                        
                    _w.color = API_TREE_RB_TYPE.RED;
                    _x = _x.parent;
                }
                else {
                    
                    if (_w.left.color == API_TREE_RB_TYPE.BLACK) {
                        
                        _w.right.color = API_TREE_RB_TYPE.BLACK;
                        _w.color = API_TREE_RB_TYPE.RED;
                        self.__rotateLeft(_w);
                        _w = _x.parent.left;
                    }
                    
                    _w.color = _x.parent.color;
                    _x.parent.color = API_TREE_RB_TYPE.BLACK;
                    _w.left.color = API_TREE_RB_TYPE.BLACK;
                    self.__rotateRight(_x.parent);
                    _x = self.__root;
                }
            }
        }
        _x.color = API_TREE_RB_TYPE.BLACK;
    }
    
    self.__root = self.__nil;
    self.__cmp  = (is_undefined(_compare) ? apiComparatorNumber : _compare);
    self.__size = 0;
    
    static __insertNode = function(_key) {
        
        var _current = self.__root;
        var _parent = undefined;
        var _cmp;
        while (_current != self.__nil) {
            
            _cmp = self.__cmp(_key, _current.key);
            if (_cmp == API_COMPARATOR.EQ) return _current;
            
            _parent = _current;
            _current = (_cmp == API_COMPARATOR.LT ? _current.left : _current.right);
        }
        
        _x = new self.__vertex(_key, _, API_TREE_RB_TYPE.RED, self.__nil, self.__nil, _parent);
        
        if (_parent != undefined) {
            
            if (self.__cmp(_key, _parent.key) == API_COMPARATOR.LT)
                _parent.left = _x;
            else
                _parent.right = _x;
        }
        else {
            
            self.__root = _x;
        }
        
        self.__insertFixup(_x);
        self.__size += 1;
        return _x;
    }
    
    static __deleteNode = function(_z) {
        
        var _x, _y;
        if (_z == undefined or _z == self.__nil) exit;
        
        if (_z.left == self.__nil or _z.right == self.__nil) {
            
            _y = _z;
        }
        else {
            
            _y = _z.right;
            while (_y.left != self.__nil)
                _y = _y.left;
        }
        
        if (_y.left != self.__nil)
            _x = _y.left;
        else
            _x = _y.right;
    
        _x.parent = _y.parent;
        if (_y.parent != undefined) {
            
            if (_y == _y.parent.left)
                _y.parent.left = _x;
            else
                _y.parent.right = _x;
        }
        else {
            
            self.__root = _x;
        }
        
        if (_y != _z) _z.key = _y.key;
        
        if (_y.color == API_TREE_RB_TYPE.BLACK)
            self.__deleteFixup(_x);
        
        self.__size -= 1;
    }
    
    static __findNode = function(_key) {
        
        var _current = self.__root;
        var _cmp;
        while (_current != self.__nil) {
            
            _cmp = self.__cmp(_key, _current.key);
            if (_cmp == API_COMPARATOR.EQ)
                return _current;
            else
                _current = (_cmp == API_COMPARATOR.LT ? _current.left : _current.right);
        }
        
        return undefined;
    }
    
    #endregion
    
    static insert = function(_key, _value) {
        
        self.__insertNode(_key).value = _value;
    }
    
    static remove = function(_key) {
        
        var _node = self.__findNode(_key);
        if (_node == undefined) return false;
        
        self.__deleteNode(_node);
        return true;
    }
    
    static find = function(_key) {
        
        var _node = self.__findNode(_key);
        if (_node == undefined) return undefined;
        
        return _node.value;
    }
    
    static clear = function() {
        
        self.__root = self.__nil;
    }
    
    static size = function() {
        
        return self.__size;
    }
    
}

var tree = new ApiTreeRB();

tree.insert(2,"hello");
tree.insert(2,"x");
tree.insert(3,"tanks");
tree.insert(4,"putin");
tree.insert(6,"bcv");
tree.insert(-10,"work");

show_message(tree.find(2));
tree.remove(2);
show_message(tree.find(2));
show_message(tree.find(3));
show_message(tree.find(4));
show_message(tree.find(6));
show_message(tree.find(-10));

tree.remove(6);
tree.remove(6);
tree.remove(6);
tree.remove(6);
tree.remove(2);
tree.remove(-10);
tree.remove(4);
tree.remove(3);
show_message(tree.find(6));
show_message(tree.size()])

