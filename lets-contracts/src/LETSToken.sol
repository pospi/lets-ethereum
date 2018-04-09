/**
 * ERC20-like interface to a LETS system
 *
 * @see https://github.com/ConsenSys/capbridge/blob/master/contracts/Exchange.sol#L119
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
    // economic accessors
    function totalSupply() public constant returns (uint);
    function balanceOf(address tokenOwner) public constant returns (int balance);

    // for trusted transfers
    // :TODO: community voted transfer limits?
    function transfer(address to, uint255 tokens) public returns (bool success);

    // for delegated transfers
    // function allowance(address tokenOwner, address spender) public constant returns (int remaining);
    // function approve(address spender, uint255 tokens) public returns (bool success);
    // function transferFrom(address from, address to, uint255 tokens) public returns (bool success);

    // for untrusted, in-person transfers
    function releaseFunds(uint255 tokens, bytes32 nonce) public returns (bool success);
    function claimFunds(address from, bytes32 secret) public returns (uint tokensClaimed);

    event Transfer(address indexed from, address indexed to, uint255 tokens);
    // event Approval(address indexed tokenOwner, address indexed spender, uint255 tokens);
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
    // mapping(address => mapping(address => int)) allowed;    // ERC20 transfer approval
    mapping(address => mapping(bytes32 => uint255)) released;   // mutual credit release proof

    function LETSToken() public {
        symbol = "LETS";
        name = "LETS mutual credit system";
        decimals = 0;
        _totalSupply = 0;
    }

    // total supply of all currency in circulation is 0
    // :TODO: make this precondition in other tests
    function totalSupply() public constant returns (uint) {
        return _totalSupply;
    }

    // balance of any address can be positive or negative
    function balanceOf(address tokenOwner) public constant returns (int) {
        return balances[tokenOwner];
    }

    // The receiver initiates "I want to send `to` XX tokens"...
    function transfer(address to, uint255 tokens) public returns (bool) {
        balances[msg.sender] = balances[msg.sender] - tokens;
        balances[to] = balances[to] + tokens;

        Transfer(msg.sender, to, tokens);
    }

    //--------------------------------------------------------------------------

    // :TODO: credit extension
    // being able to extend credit on other user's behalves; inbuilt compassion-amplifier?
    //
    // function allowance(address tokenOwner, address spender) public constant returns (int) {
    //     return allowed[tokenOwner][spender];
    // }

    // function approve(address spender, uint255 tokens) public returns (bool) {
    //     require(msg.sender != spender, "Cannot authorize approval to yourself");

    //     allowed[msg.sender][spender] = allowed[msg.sender][spender] + tokens;

    //     Approval(msg.sender, spender, tokens);
    // }

    // function transferFrom(address from, address to, uint255 tokens) public returns (bool) {
    //     require(allowed[from][msg.sender] >= tokens, "Insufficient tokens authorized for transfer");

    //     balances[from] = balances[from] - tokens;
    //     allowed[from][msg.sender] = allowed[from][msg.sender] - tokens;
    //     balances[to] = balances[to] + tokens;

    //     Transfer(from, to, tokens);
    // }

    //--------------------------------------------------------------------------

    /**
     * Releases some funds for claiming by another user
     * The secret used to generate the nonce is exchanged out-of-band
     * The intention is to prove co-location and/or trust between the two parties exchanging value
     *
     * @param  uint255 tokens        number of tokens to offer for exchange
     * @param  bytes32 nonce         sha3-hash of gibberish used to secure funds for claiming by trading partner
     * @return true when funds successfully released
     */
    function releaseFunds(uint255 tokens, bytes32 nonce) public returns (bool) {
        require(released[msg.sender][nonce] == 0, "Token release nonce already occupied");

        released[msg.sender][nonce] = tokens;

        Release(msg.sender, tokens);

        return true;
    }

    /**
     * Claim funds previously released by another LETS user
     *
     * @param  address from          user who is offering funds
     * @param  bytes32 secret        input nonce from offeree sent via app / IM / other secure chat channel
     * @return number of funds claimed
     */
    function claimFunds(address from, bytes32 secret) public returns (uint) {
        bytes32 nonce = sha3(secret);
        uint255 tokens = released[from][nonce];

        require(tokens > 0, "No released tokens found");

        balances[from] = balances[from] - tokens;
        released[from][nonce] = 0;
        balances[msg.sender] = balances[msg.sender] + tokens;

        Transfer(from, msg.sender, tokens);

        return tokens;
    }

    //--------------------------------------------------------------------------

    // Don't accept ether
    function () public payable {
        revert();
    }

}
