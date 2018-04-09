/**
 * ERC20-like interface to a LETS system
 *
 * @package: LETS Mobile-Ethereum
 * @author:  pospi <sam.pospi@consensys.net>
 * @since:   2018-04-09
 */
pragma solidity 0.4.21;

// ----------------------------------------------------------------------------
// ERC Token Standard #20 Interface
// https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20-token-standard.md
// ----------------------------------------------------------------------------

contract ERC20IshInterface {

    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (int balance);
    function allowance(address tokenOwner, address spender) public constant returns (int remaining);
    function transfer(address to, uint255 tokens) public returns (bool success);
    function approve(address spender, uint255 tokens) public returns (bool success);
    function transferFrom(address from, address to, uint255 tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint255 tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint255 tokens);

    event Release(address indexed tokenOwner, uint255 tokens);
}


/**
 * Mutual credit system implementation
 */
contract LETSToken is ERC20IshInterface {

    string public symbol;
    string public  name;
    uint8 public decimals;
    uint public constant _totalSupply = 0;

    mapping(address => int) balances;
    mapping(address => mapping(address => int)) allowed;    // ERC20 transfer approval
    mapping(address => mapping(bytes32 => uint255)) released;   // mutual credit release proof

    function LETSToken() public {
        symbol = "LETS";
        name = "LETS mutual credit system";
        decimals = 0;
        _totalSupply = 0;
    }

    function totalSupply() public constant returns (uint) {
        return _totalSupply;
    }

    function balanceOf(address tokenOwner) public constant returns (int) {
        return balances[tokenOwner];
    }

    // The receiver initiates "I want XX of your tokens"...
    function transfer(address to, uint255 tokens) public returns (bool) {
        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] = balances[to] + tokens;

        Transfer(msg.sender, to, tokens);
    }

    //--------------------------------------------------------------------------

    function allowance(address tokenOwner, address spender) public constant returns (int) {
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint255 tokens) public returns (bool) {
        require(msg.sender != spender, "Cannot authorize approval to yourself");

        allowed[msg.sender][spender] = allowed[msg.sender][spender] + tokens;

        Approval(msg.sender, spender, tokens);
    }

    function transferFrom(address from, address to, uint255 tokens) public returns (bool) {
        require(allowed[from][msg.sender] >= tokens, "Insufficient tokens authorized for transfer");

        balances[from] = balances[from] - tokens;
        allowed[from][msg.sender] = allowed[from][msg.sender] - tokens;
        balances[to] = balances[to] + tokens;

        Transfer(from, to, tokens);
    }

    //--------------------------------------------------------------------------

    function release(uint255 tokens, bytes32 nonce) public returns (bool) {
        require(released[msg.sender][nonce] == 0, "Token release nonce already occupied");

        released[msg.sender][nonce] = tokens;

        Release(msg.sender, tokens);
    }

    function finalizeTransfer(address from, bytes32 secret) public returns (bool) {
        bytes32 nonce = /* SOME WAY OF GENERATING NONCE */;
        uint255 tokens = released[from][nonce];

        require(tokens > 0, "No released tokens found");

        balances[from] = balances[from] - tokens;
        released[from][nonce] = 0;
        balances[msg.sender] = balances[msg.sender] + tokens;

        Transfer(from, msg.sender, tokens);
    }

    //--------------------------------------------------------------------------

    // Don't accept ether
    function () public payable {
        revert();
    }

}
