import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Custom "custom";
import Animal "animal";
import List "mo:base/List";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Hash "mo:base/Hash";
import Iter "mo:base/Iter";
import Result "mo:base/Result";
import HTTP "http";

actor {
	//challenge 1 on day 6
	public type TokenIndex = Nat;
	public type Error = {
		#syntax;
		#outOfMemory;
		#mathematical;
	};
	//end of challenge 1 on day 6

	//challenge 2 on day 6
	var registry = HashMap.HashMap<TokenIndex, Principal>(0, Nat.equal, Hash.hash);
	//end of challenge 2 on day 6
	
	//challenge 3 on day 6
	stable var nextTokenIndex : Nat = 0;
	public type Result = Result.Result<(),Text>;

	var counter : Nat = 0;
	public type Custom = Custom.Custom;
	//challenge 2 on day 4
	public type Animal = Animal.Animal;
	let polar_bear : Animal = {
		species = "maritimus";
		genus = "Ursus";
		energy = 2000;
		status = "critically endangered";
	};
	let cow : Animal = {
		species = "taurus";
		genus = "Bos";
		energy = 400;
		status = "safe";
	};
	//end of challenge 2 on day 4

	//challenge 3 on day 4
	//definitions in animal.mo
	func test_sleep_animal(a : Animal) :  Animal {
		var a2 = Animal.animal_sleep(a);
		return a2;
	};
	Debug.print(debug_show test_sleep_animal(polar_bear));
	//end of challenge 3 on day 4

	//challenge 5 on day 4
	var animal_list = List.nil<Animal>();
	//end of challenge 5 on day 4

    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

//challenge 1 on day 4
	public func fun() : async Custom {
		let c : Custom = {
			name = "Charles";
			team = "Cardano";
			rank = 0;
		};
		return c;
	};
//challenge 4 on day 4
	public func create_animal_then_takes_a_break(s : Text, e : Nat) : async Animal {
		let a : Animal = {
			species = s;
			genus = "";
			status = "";
			energy = e;
		};
		return Animal.animal_sleep(a);
	};

//challenge 6 on day 4
	func push_animal(a : Animal) :  () {
		animal_list := List.push<Animal>(a, animal_list);
	};
	func get_animals() : [Animal] {
		return List.toArray(animal_list);
	};
	//push_animal(polar_bear);
	//push_animal(cow);
	//get_animals();

//challenge 3 contd on day 6
	public shared({caller}) func mint() : async Result {
		if (caller == Principal.fromText("2vxsx-fae")){
			return #err("Use is Anonymous");
		}
		else {
			registry.put(nextTokenIndex,caller);
			nextTokenIndex += 1;
			return #ok;
		};
	};
	public func reset_index() : async () {
		nextTokenIndex := 0;
	};

//challenge 4 on day 6
	public shared({caller}) func transfer(to : Principal, tokenIndex : Nat) : async Result {
		if (registry.get(tokenIndex) != ?caller){
			return #err("This isn't owned by you!!");
		}
		else {
			let ?res = registry.replace(tokenIndex,to);
			return #ok;
		};
	};

//challenge 5 on day 6
public type List<T> = ?(T, List<T>);
	public shared({caller}) func balance() : async List<TokenIndex> {
		var i = 0;
		var tokenIndexList = List.nil<TokenIndex>();
		while (i < registry.size()){
			if (registry.get(i) != ?caller){
				i += 1;
			}
			else {
				tokenIndexList := List.append(tokenIndexList, List.make(i));
				i += 1;
			};
		};
		return tokenIndexList;
	};

//challenge 6 on day 6

	public query func http_request() : async  HTTP.Response {
		let last_caller = registry.get(nextTokenIndex - 1);
		var response_as_text = "";
		switch (last_caller) {
			case null {
				response_as_text := "null null";
			};
			case (?principal) {
				response_as_text := Nat.toText(nextTokenIndex) # " " # Principal.toText(principal);

			};
		};
		let response = {
      		body = Text.encodeUtf8(response_as_text);
      		headers = [("Content-Type", "text/html; charset=UTF-8")];
      		status_code = 200 : Nat16;
      		streaming_strategy = null
      	};
      	return(response);
    };

//challenge 7 on day 6


	stable var entries : [(Nat, Principal)] = [];
	system func preupgrade() {
    	entries := Iter.toArray(registry.entries());
  };

	system func postupgrade() {
		registry := HashMap.fromIter<TokenIndex,Principal>(entries.vals(), entries.size(), Nat.equal, Hash.hash);
    	entries := [];
  };
	
	
};
