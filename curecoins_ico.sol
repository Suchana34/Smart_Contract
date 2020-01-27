// lets make our own contract
// lets name my crypto coins as curecoins
// the place has a currency names curecurrency
pragma solidity ^0.6.1;

contract curecoins_ico {
    // a public variable that records the total number of coins available for sale
    uint256 public max_curecoins = 100000;

    //introducing a conversion rate for my coins to any currency(curecurrency in my world)
    uint256 public curecurrency_to_curecoins = 1000;

    //introducing the max number of coins bought by the investor
    uint256 public total_curecoins_bought = 0; //initalised to zero

    //Mapping from the investor address(his/her public key) to its equity in curecoins and curecurrency
    // a mapping from an address input to int output
    mapping(address => uint256) equity_curecoins;
    mapping(address => uint256) equity_curecurrency;

    //making a modifier which will check whether the investor can make transactions or not(buy)
    modifier can_buy_curecoins(uint256 curecurrency_invested) {
        require(
            curecurrency_invested *
                curecurrency_to_curecoins +
                total_curecoins_bought <=
                max_curecoins
        );
        _; //this symbol says the function will only run if the condition is verified
    }

    //getting the equity in curecoins of an investor
    //lets create a function that takes public key as argument and returns uint

    function equity_in_curecoins(address investor)
        external
        view
        returns (uint256)
    {
        //returns the mapping we declared previously
        return equity_curecoins[investor];
    }

    //getting the equity in curecurrency of an investor
    function equity_in_curecurrency(address investor)
        external
        view
        returns (uint256)
    {
        //returns the mapping we declared previously
        return equity_curecurrency[investor];
    }

    //buying curecoins

    function buy_curecoins(address investor, uint256 curecurrency_invested)
        external
        can_buy_curecoins(curecurrency_invested)
    {
        uint256 curecoins_bought = curecurrency_invested *
            curecurrency_to_curecoins; //conversion
        equity_curecoins[investor] += curecoins_bought;
        equity_curecurrency[investor] = equity_curecoins[investor] / 1000;
        total_curecoins_bought += curecoins_bought;
    }

    //selling curecoins
    function sell_curecoins(address investor, uint256 curecoins_sold) external {
        equity_curecoins[investor] -= curecoins_sold;
        equity_curecurrency[investor] = equity_curecoins[investor] / 1000;
        total_curecoins_bought -= curecoins_sold;
    }

}
