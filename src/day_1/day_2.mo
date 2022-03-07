import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Nat "mo:base/Nat";
import Char "mo:base/Char";
import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Debug "mo:base/Debug";

actor {
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

//challenge 1 on day 2
	public func nat_to_nat8(n : Nat) : async Nat8 {
		if (n < 256) {
			return Nat8.fromNat(n);
		}
		else {
			return Nat8.fromNat(255);
		};
	};

//challenge 2 on day 2
	public func max_number_with_n_bits(n : Nat) : async Nat {
		return (2**n -1);
	};

//challenge 3 on day 2
	public func decimal_to_bits(n : Nat) : async Text {
		var i = 1;
		var num = n;
		var rev_str = 0;
		while (num >= 1) {
			rev_str += (i * (num % 2));
			if (num % 2 == 0) {
				num /= 2;
			}
			else {
				num := (num - 1)/2;
			};
			i *= 10;
		};
		return Nat.toText(rev_str);
		
	};
//challenge 4 on day 2
	public func capitalize_character(c : Char) : async Char {
		let uni_value : Nat32 = Char.toNat32(c);
		Debug.print(Nat32.toText(uni_value));
		if (uni_value > 96 and uni_value < 123) {
			return Char.fromNat32(uni_value - 32);
		}
		else {
			return c;
		};
	};

//challenge 5 on day 2
	public func capitalize_text(t : Text) : async Text {
		var uni_value : Nat32 = 0;
		var op_text : Text = "";
		var i = 0;

		for (c in t.chars()){
			uni_value := Char.toNat32(c);
			if (uni_value > 96 and uni_value < 123) {
				op_text := Text.concat(op_text,Text.fromChar(Char.fromNat32(uni_value - 32)));
			}
			else {
				op_text := Text.concat(op_text,Text.fromChar(c));	
			};
			i += 1;
		};
		Debug.print(Nat.toText(i));
		return op_text;
	};

//challenge 6 on day 2
	public func is_inside(t: Text, c: Char) : async Bool {
		return Text.contains(t,#text(Text.fromChar(c)));

	};

//challenge 7 on day 2
	public func trim_whitespace(t : Text) : async Text {
		let res: Text = Text.replace(t, #text(" "),"");
		return res;
	};

//challenge 8 on day 2
	public func duplicated_character(t : Text) : async Text {
		var res: Text = "";
		for (c in t.chars()){
			res := Text.replace(t, #text(Text.fromChar(c)),"");
			if (res.size() < t.size() - 1 ){
				return Text.fromChar(c);
			};
		};
		return t;

	};

//challenge 9 on day 2
	public func size_in_bytes(t : Text) : async Nat {
		var utf8_val = Text.encodeUtf8(t);
		return utf8_val.size();
		//return 3;
	};

//challenge 10 on day 2
	public func bubble_sort(array : [Nat]) : async [Nat] {
		var newArr : [var Nat] = Array.thaw(array);
		var i = 0;
		var j = 0;
		var temp = 0;
		while (i < newArr.size()){
			while (j < newArr.size() - i - 1){
				if (newArr[j] > newArr[j+1]){
					temp := newArr[j];
					newArr[j] := newArr[j+1];
					newArr[j+1] := temp;
				};
				j += 1;
			};
			i += 1;
			j := 0;
		};	
		return Array.freeze(newArr);
	};
};















