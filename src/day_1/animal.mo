module {
    public type Animal ={
        species : Text;
        genus : Text;
        status : Text;
        energy : Nat;
    };

    //challenge 3 on day 4
    public func animal_sleep(_a : Animal) : Animal {
        var a : Animal = {
            species = _a.species;
            genus = _a.genus;
            status = _a.status;
            energy = _a.energy + 10;
        };
        return a;
    };
};
