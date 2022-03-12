import Result "mo:base/Result";
import Main "main";

actor {

  	public type Result = Result.Result<(),Text>;

    //challenge 8 on day 6
    public shared({caller}) func mint_from_here() : async Result{
        let res = Main.mint();
        return res;
    };


};