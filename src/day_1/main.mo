import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Custom "custom";
import Animal "animal";
import List "mo:base/List";

actor {

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
	
};
