import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
actor {

	var counter : Nat = 0;
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

//challenge 1 on day 1
	public func add(a: Nat, b: Nat) : async Nat {
		return (a + b);
	};

//challenge 2 on day 1
	public func square(n : Nat) : async Nat {
		return (n*n);
	};

//challenge 3 on day 1
	public func days_to_second(n : Nat) : async Nat {
		return (n * 24 * 60 * 60);
	};

//challenge 4 on day 1
	public func increment_counter(n : Nat) : async () {
		counter += n;	
	};
	public func clear_counter() : async () {
		counter := 0;
	};
	public query func get_counter() : async Nat {
		return counter;
	};

//challenge 5 on day 1
	public func divide(n : Nat, m : Nat) : async Bool {
		if (m % n == 0) {
			return true;
		}
		else {
			return false;
		};
	};

//challenge 6 on day 1
	public func is_even(n : Nat) : async Bool {
		if (n % 2 == 0) {
			return true;
		}
		else {
			return false;
		};
	};

//challenge 7 on day 1
	public func sum_of_array(array : [Nat]) : async Nat {
		var sum = 0;
		var i = 0;
		while (i < array.size()){
			sum += array[i];
			i += 1;
		};
		return sum;	
	};

//challenge 8 on day 1
	public func maximum(array : [Nat]) : async Nat {
		var mxm = array[0];
		var i = 0;
		while (i < array.size()){
			if (array[i] > mxm) {
				mxm := array[i];
			};
			i += 1;	
		};
		return mxm;
	};

//challenge 9 on day 1
	public func remove_from_array(array: [Nat], n : Nat) : async [Nat] {
		return Array.filter(array, func(val: Nat) : Bool {n != val});
	};

//challenge 10 on day 1
	public func selection_sort(_array : [Nat]) : async [Nat] {
		var minidx = 0;
		var temp = 0;
		var i : Nat = 0;
		var j : Nat = 0;
		var array : [var Nat] = Array.thaw(_array);
		while (i < array.size() - 1){
			minidx := i;
			j := i + 1;
			while (j < array.size()){
				if (array[j] < array[minidx]){
					minidx := j;
				};
				j += 1;
			};
			temp := array[minidx];
			array[minidx] := array[i];
			array[i] := temp;
			i += 1;  
		};
		//Debug.print(Nat.toText(array[0]));
		return Array.freeze(array);
	};
};
