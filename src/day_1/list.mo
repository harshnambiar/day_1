import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
//import List "mo:base/List";


actor {
    public type List<T> = ?(T, List<T>);
	var counter : Nat = 0;
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

//challenge 7 on day 4
    func is_null<T>(l : List<T>) : Bool {
        switch(l){
            case(null) {
                return true;
            };
            case(?list){
                return false;
            };
         };
    };

    Debug.print(debug_show is_null(null));

//challenge 8 on day 4
    func last<T>(l : List<T>) : ?T {
        switch l {
            case null { 
                return null;
            };
            case (?(x, null)) { 
                return ?x;
            };
            case (?(_, l2)) {
                return last<T>(l2); 
            };
        };
    };

//challenge 9 on day 4
    func size<T>(l : List<T>) : Nat {
        switch l {
            case null {
                return 0;
            };
            case (?(x,null)) {
                return 1;
            };
            case (?(_,l2)) {
                return 1 + size<T>(l2);
            };
        };
    };

//challenge 10 on day 4
    func get<T>(l : List<T>, n : Nat) : ?T {
        switch (l,n){
            case (null,_){
                return null;
            };
            case (?(x,l2),0){
                return ?x;
            };
            case (?(_,l2),_){
                return get<T>(l2,n-1);
            };
        };
    };

//challenge 11 on day 4
    func reverse<T>(l : List<T>) : List<T> {
        func rec(l : List<T>, r : List<T>) : List<T> {
            switch l {
                case null {
                    return r;
                 };
                case (?(h, l2)) { 
                    return rec(l2, ?(h, r)); 
                };
            };
        };
        return rec(l, null);
    };

};