import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Cycles "mo:base/ExperimentalCycles";
//import WithdrawCycles "withdraw_cycles";


actor {
    //challenge 2 on day 5
    var favorite_number  = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
    //end of challenge 2 on day 5

    //challenge 8 on day 5
	stable var counter : Nat = 0;
    stable var version_number : Nat  = 0;
    system func postupgrade(){
        version_number += 1;
    };
    
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!!";
    };

//challenge 1 on day 5
    public shared({caller}) func is_anonymous() : async Bool {
        let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");
        if (caller == anonymous_principal){
            return true;
        }
        else {
            return false;
        };
    };

//challenge 3 on day 5 (commented out so challenge 4 function with same name does not cause duplication error)

  //  public shared({caller}) func  add_favorite_number(n : Nat) : async () {
    //    favorite_number.put(caller,n);
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

//challenge 4 on day 5
    public shared({caller}) func  add_favorite_number(n : Nat) : async Text {
        let fav_num : ?Nat = favorite_number.get(caller);
        switch (fav_num) {
            case null {
                favorite_number.put(caller,n);
            };
            case (?nat) {
                return "You've already registered your number";
            };
        };
        return "You've successfully registered your number";        
    };

//challenge 5 on day 5
    public shared({caller}) func  update_favorite_number(n : Nat) : async () {
        let fav_num : ?Nat = favorite_number.get(caller);
        switch (fav_num) {
            case null {
                favorite_number.put(caller,n);
            };
            case (?nat) {
                let new_val : ?Nat = favorite_number.replace(caller,n);
            };
        };

    };

    public shared({caller}) func delete_favorite_number() : async () {
        let removal : ?Nat = favorite_number.remove(caller);
    };


//challenge 8 on day 5 (contd)
    public func increment_counter(n : Nat) : async () {
		counter += n;	
	};
	public func clear_counter() : async () {
		counter := 0;
	};
	public query func get_counter() : async Nat {
		return counter;
	};

    public query func get_version() : async Nat {
        return version_number;
    };
};