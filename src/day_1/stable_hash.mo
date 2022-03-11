import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Buffer "mo:base/Buffer";


actor{

 //challenge 2 repeat on day 5 for challenge 9

    var favorite_number  = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    stable var pArray : [Principal] = [];
    stable var keyArray : [Nat] = [];

    system func postupgrade(){
        var j = 0;
        while (j < pArray.size()){
            favorite_number.put(pArray[j],keyArray[j]);
            j += 1;
        };
    };

//challenge 3 repeat on day 5 for challenge 9 
//(commented out so challenge 4 function with same name does not cause duplication error)

    func remove_index_from_nat_array(array: [Nat], index : Nat) :  [Nat] {
		let ys : Buffer.Buffer<Nat> = Buffer.Buffer(array.size());
        var j = 0;
        for (x in array.vals()) {
            if (j != index) {
                ys.add(x);
            };
            j += 1;
        };
        return ys.toArray();
        
	};

    func remove_principal_from_array(array: [Principal], p : Principal) : [Principal] {
		return Array.filter(array, func(val: Principal) : Bool {p != val});
	};



  //  public shared({caller}) func  add_favorite_number(n : Nat) : async () {
    //    favorite_number.put(caller,n);
            //pArray := Array.append(pArray,Array.make(caller));
              //  keyArray := Array.append(keyArray,Array.make(n));
   // };

    public shared({caller}) func  show_favorite_number() : async ?Nat {
        let fav_num : ?Nat = favorite_number.get(caller);
        switch fav_num {
            case null {
                return null;
            };
            case (?nat) {
                return ?nat;
            };
        }; 
    };

//challenge 4 repeat on day 5 for challenge 9
    public shared({caller}) func  add_favorite_number(n : Nat) : async Text {
        let fav_num : ?Nat = favorite_number.get(caller);
        switch (fav_num) {
            case null {
                favorite_number.put(caller,n);
                pArray := Array.append(pArray,Array.make(caller));
                keyArray := Array.append(keyArray,Array.make(n));
            };
            case (?nat) {
                return "You've already registered your number";
            };
        };
        return "You've successfully registered your number";        
    };

//challenge 5 repeat on day 5 for challenge 9
    public shared({caller}) func  update_favorite_number(n : Nat) : async () {
        let fav_num : ?Nat = favorite_number.get(caller);
        switch (fav_num) {
            case null {
                favorite_number.put(caller,n);
                pArray := Array.append(pArray,Array.make(caller));
                keyArray := Array.append(keyArray,Array.make(n));
            };
            case (?nat) {
                let new_val : ?Nat = favorite_number.replace(caller,n);
                var j = 0;
                while (pArray[j] != caller){
                    j += 1;
                };
                pArray := remove_principal_from_array(pArray,caller);
                keyArray := remove_index_from_nat_array(keyArray,j);
                pArray := Array.append(pArray,Array.make(caller));
                keyArray := Array.append(keyArray,Array.make(n));
            };
        };

    };

    public shared({caller}) func delete_favorite_number() : async () {
        let removal : ?Nat = favorite_number.remove(caller);
        var j = 0;
        while (pArray[j] != caller){
            j += 1;
        };
        pArray := remove_principal_from_array(pArray,caller);
        keyArray := remove_index_from_nat_array(keyArray,j);
    };


};