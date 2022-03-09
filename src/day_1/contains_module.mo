import Array "mo:base/Array";
actor {
    let f = func (n : Nat) : Nat {
        return(n + 1);
    };

    func contains<A>(array : [A], a : A, f : (A,A) -> Bool) :  Bool{
        var i = 0;
        while (i < array.size()){
            if (f(array[i],a)){
                return true;
            };
            i += 1;
        };
        return false;
        
    };
    let equality = func(a : Nat, b : Nat) : Bool {
        return (a == b);
    };
    public func test_contains(array : [Nat],n : Nat) : async Bool {
        return contains<Nat>(array, n, equality);
    };
};