import Array "mo:base/Array";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Option "mo:base/Option";


actor {

	var counter : Nat = 0;
    public func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

//challenge 1 on day 3
    private func swap(array : [Nat], i : Nat, j : Nat) : [Nat] {
        var newArr : [var Nat] = Array.thaw(array);
        newArr[j] := array[i];
        newArr[i] := array[j];
        return Array.freeze(newArr);
    };  

//challenge 2 on day 3
    public func init_count(n : Nat) : async [Nat] {
        var array : [var Nat] = Array.init(n, 0);
        var i = 1;
        while (i < n){
            array[i] := i;
            i += 1;
        };
        return Array.freeze(array);
    };

//challenge 3 on day 3
    func has_digit_seven(n : Nat) : Bool {
        var num = n;
        if (num == 0){
            return false;
        };
        while (num > 0){
            if (num % 10 == 7){
                return true;
            }
            else {
                
                num := (num - (num % 10))/10;
            };
        };
        return false;
    };
    public func seven(array : [Nat]) : async Text {
        var i = 0;
        while (i < array.size()){
            if (has_digit_seven(array[i])){
                return "Seven is found";
            }
            else {
                i += 1;
            };
            
        };
        return "Seven not found";
    };

//challenge 4 on day 3
    public func nat_opt_to_nat(n : ?Nat , m : Nat) : async Nat{
        
        let to_return : Nat = switch n{
            case null m; 
            case (?nat) nat; 
        };
        return to_return;
    };

//challenge 5 on day 3
    public func day_of_the_week(n : Nat) : async ?Text {
        let day : ?Text = switch n {
            case 1 ?"Monday";
            case 2 ?"Tuesday";
            case 3 ?"Wednesday";
            case 4 ?"Thursday";
            case 5 ?"Friday";
            case 6 ?"Saturday";
            case 7 ?"Sunday";
            case default null;
        };
        return day;
    };

//challenge 6 on day 3
    func null_to_zero(n : ?Nat) :  Nat{
        
        let to_return : Nat = switch n{
            case null 0; 
            case (?nat) nat; 
        };
        return to_return;
    };

    public func populate_array(array : [?Nat]) : async [Nat]{
        var newArr : [Nat] = Array.map<?Nat,Nat>(array, null_to_zero);
        return newArr;
    };

//challenge 7 on day 3
    func previous_compound_array(array : [Nat], j : Nat) : Nat {
        if (j == 0){
            return array[j];
        }
        else {
            return array[j] + previous_compound_array(array,(j-1));
        };
    };
    public func sum_of_array(array : [Nat]) : async Nat {
        var newArr : [Nat] = Array.mapEntries<Nat,Nat>(array, func(val: Nat,ind : Nat) : Nat {previous_compound_array(array,ind: Nat)});
        return newArr[newArr.size() - 1];
    };

//challenge 8 on day 3
    public func squared_array(array : [Nat]) : async [Nat] {
        var newArr : [Nat] = Array.map<Nat,Nat>(array,func(val: Nat) : Nat {val * val});
        return newArr;
    };

//challenge 9 on day 3
    public func increase_by_index(array : [Nat]) : async [Nat] {
        var newArr : [Nat] = Array.mapEntries<Nat,Nat>(array,func(val: Nat, ind: Nat) : Nat {val + ind});
        return newArr;
    };

//challenge 10 on day 3
    //in contains_module.mo file
    
};