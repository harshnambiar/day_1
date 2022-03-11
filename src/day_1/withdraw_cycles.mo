import Cycles "mo:base/ExperimentalCycles";


shared(msg) actor class DepositWithdraw (
    withdraw : shared () -> async (),
    capacity: Nat
  )  {


let owner = msg.caller;

var savings = 0;

public shared(msg) func getSavings() : async Nat {
   assert (msg.caller == owner);
   return savings;
  };
//challenge 6 on day 5 
    public shared({caller}) func deposit_cycles() : async Nat{
    let acceptable =
      if (Cycles.available() <= (capacity - savings)) Cycles.available()
      else (capacity - savings);
    let amt = Cycles.accept(acceptable);
    savings += amt;
    return amt;
        
    };
//challenge 7 on day 5
    public shared(msg) func withdraw_cycles(n : Nat) : async () {
    assert (msg.caller == owner);
    assert (n <= savings);
    Cycles.add(n);
    await withdraw();
    let refund = Cycles.refunded();
    savings := savings - n - refund;
    
  };

};