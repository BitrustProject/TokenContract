import "./token.sol";

contract ttest
{
    event LogUint(uint value);
    BiTrustToken token;
    function () payable public
    {
        
    }
    function ttest() public
    {
        token = new BiTrustToken(1000000, "DDD", "DD");
    }
    function testBuy()  public payable
    {
        uint tamount = token.buy.value(1 ether)();
        assert(tamount == 100 ether);
    }
    
    function testSell() public 
    {
        uint oldb = address(this).balance;
        uint oldtb = token.balanceOf(this);
        token.sell(1 ether);
        uint newb =  address(this).balance;
        uint newtb = token.balanceOf(this);
        assert((oldtb - newtb) == 1 ether);
        assert((newb - oldb) == 0.01 ether);
    }
    function testMint() public
    {
        uint oldb = token.balanceOf(this);
        token.mintToken(this, 100 ether, 0);
        uint newb = token.balanceOf(this);
        
        emit LogUint(oldb);
        emit LogUint(newb);
        assert((newb - oldb) == 100 ether);
    }
    
    function testMintLockup() public
    {
        uint oldb = token.balanceOf(this);
        token.mintToken(this, 100 ether, 1);
        token.mintToken(this, 100 ether, 2);
        token.mintToken(this, 100 ether, 3);
        uint newb = token.balanceOf(this);
        
 
        assert((newb - oldb) == 300 ether);
        assert(token.getFrozenBalance(this) == 300 ether);
    }
}
