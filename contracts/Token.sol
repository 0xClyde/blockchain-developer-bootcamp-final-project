// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

// Part: IUniswapV2Pair
// Factory Initialization
// Récupérer des données sur la paire

interface IUniswapV2Pair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
        external
        returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

// Part: IUniswapV2Router02
// Attention a Id Router

/*is IUniswapV2Router01*/
interface IUniswapV2Router02 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB, //Community governance plays a vital role in turning on/off of this fee. A protocol fee of 0.05% of the total 0.3% trading fee will be reserved for the devel
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA, //Community governance plays a vital role in turning on/off of this fee. A protocol fee of 0.05% of the total 0.3% trading fee will be reserved for the devel
        address tokenB,
        uint256 liquidity, ///Community governance plays a vital role in turning on/off of this fee. A protocol fee of 0.05% of the total 0.3% trading fee will be reserved for the devel
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

// Part: ILP

interface ILP {
    function sync() external;
}


contract MyToken is ERC20, ERC20Burnable, Ownable {

    // Used for authentication
    address public master;
    // Managment Wallet1 for Lock (Axie)
    address public constant walletManagement1 = 0x9758f4571d3C825Bb958BfC4EE5B08F48E8eb5f0;
    //Managment Wallet for Lock (DeFi France)
    address public constant walletManagement2 = 0x437742dfE88709271ebfa55958146f106194e2c4;
    // Liquidity Wallet for lock (Bankless)
    address public constant walletLiquidity = 0x3710262826e4b6e7c83d9AeFFd1239014F03032B;
    //address public constant wallet4;
    //address public constant wallet5;

    // LP atomic sync
    address public lp;
    ILP public lpContract;

    uint256 private constant DECIMALS = 18; // to test
    uint256 private constant MAX_UINT256 = ~uint256(0);

    //Tokenomics 
    //Total Supply
    uint256 private constant INITIAL_SUPPLY = (1000000000000000000) * (10 ** DECIMALS);
    //Convert to entier naturel for the token amount
    uint256 private constant TOTAL_SUPPLY = MAX_UINT256 - (MAX_UINT256 % INITIAL_SUPPLY);
    uint256 private _totalSupply; // overloading var
    bool public initialDistributionFinished;
    uint256 public transactionTax = 981; // Tax fee for Marketing a transformer en %
    mapping(address => uint256) public _msqBalances;
    mapping(address => bool) private _isExcluded;
    mapping(address => bool) allowTransfer;
    
    // Only Marketing Right Now to change!
    address payable public marketingAddress;
    address public deadAddress = 0x000000000000000000000000000000000000dEaD; // burn address (put etherscan link) + Maybe will not work with local environement devlopement

    //Fees et Tax pour repartion après
    ////@Var: Fees&Tax
    

    //@Var: Uniswap related Interface
    //Router02 address : 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D

    IUniswapV2Router02 public uniswapV2Router;
    IUniswapV2Pair public uniswapV2Pair;
    address public uniswapV2PairAddress;

   

    // modifiers section 

    modifier initialDistributionLock() {
        require(
            initialDistributionFinished ||
                owner() == msg.sender ||
                allowTransfer[msg.sender]
        ); // owner() == msg.sender A tester
        _;
    }

    modifier onlyMaster() {
        require(msg.sender == master);
        _;
    }

    modifier validRecipient(address to) {
        require(to != address(0x0));
        require(to != address(this));
        _;
    }


    constructor(address payable _marketingAddress)  payable ERC20("METASQUID", "METASQUID"){
        // Still need to add all other Fees Address
        //_mint(msg.sender, (10 ** 2) * (10 ** 2));
        mintWalletOwner(msg.sender, 10000000);
        mintWalletManagement1(walletManagement1, 100000);
        mintWalletManagement2(walletManagement2, 100000);
        mintWalletLiquidity3(walletLiquidity, 100000);
        
        
        marketingAddress = _marketingAddress; // Fees Address

        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);

        uniswapV2PairAddress = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), _uniswapV2Router.WETH()); // Creating Pair contract

        uniswapV2Router = _uniswapV2Router; // Routing to Uni

        setLP(uniswapV2PairAddress); // Open Liquidity Providing to pair -je sais pâs si on a besoin ou pas!

        IUniswapV2Pair _uniswapV2Pair = IUniswapV2Pair(uniswapV2PairAddress);

        uniswapV2Pair = _uniswapV2Pair;

        _totalSupply = INITIAL_SUPPLY;
        _msqBalances[msg.sender] = TOTAL_SUPPLY;
        initialDistributionFinished = false; // Let Initial Distribution occur

        //exclude owner of this contract from fee
        _isExcluded[owner()] = true;
        _isExcluded[address(this)] = true;

        emit Transfer(address(0x0), msg.sender, _totalSupply);
    }


    /**
     * @notice Sets a new master
     */
    function setMaster(address _master) external onlyOwner {
        master = _master;
    }

    /**
     * @notice Sets contract LP address
     */
    function setLP(address _lp) public onlyOwner{
        lp = _lp;
        lpContract = ILP(_lp);
    }

    /**
     * @notice Overriding functions from ERC20 and creating specific tokennomics
     * functions.
     */
    
    // decimals needed for _totalSupply

    function decimals() public view virtual override returns (uint8) {
        return 1;
    }

    // TotalSupply of tokens
    function totalSupply()
        public
        view
        virtual
        override
        returns (uint256){
            return _totalSupply;
        }


 // internal virtual?



 /**
  * @dev Approve the passed address to spend the specified amount of tokens on behalf of
  * msg.sender. This method is included for ERC20 compatibility.
  * increaseAllowance and decreaseAllowance should be used instead.
  * Changing an allowance with this method brings the risk that someone may transfer both
  * the old and the new allowance - if they are both greater than zero - if a transfer
  * transaction is mined before the later approve() call is mined.
  *
  * @param spender The address which will spend the funds.
  * @param value The amount of tokens to be spent.
  */


 function approve(address spender, uint256 value)
     public
     virtual
     override
     initialDistributionLock
     returns (bool)
 {
     _approve(msg.sender, spender, value);
     return true;
 }
 
function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }




    /**
     * @dev Moves `amount` of tokens from `sender` to `recipient`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual override initialDistributionLock {
        uint256 senderBalance = _msqBalances[sender];
        uint256 tFee = _getTValues(amount);
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        
     
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _msqBalances[sender] = senderBalance - amount;
        }
        _msqBalances[recipient] += amount;
        _takeFee(tFee);

        emit Transfer(sender, recipient, amount);

        _afterTokenTransfer(sender, recipient, amount);
    }


function _getTValues(uint256 tAmount)
    private
    view
        returns (uint256)
    {
        uint256 tFee = calculateFee(tAmount);
        return tFee;
    }

function calculateFee(uint256 _amount) private view returns (uint256) {
        return _amount*transactionTax; // Trouver lme bon pourcentrage
    }

function _takeFee(uint256 tFee) private {
        
        _msqBalances[address(this)] = _msqBalances[address(this)] + tFee;
    }

    // A revoir!
    function transferToAddressETH(address payable recipient, uint256 amount)
        private
    {
        recipient.transfer(amount);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();

        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // make the swap
        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of ETH
            path,
            address(this),
            block.timestamp
        );
    }

    function swapETHForTokens(uint256 amount) private {
        // generate the uniswap pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = uniswapV2Router.WETH();
        path[1] = address(this);

        // make the swap
        uniswapV2Router.swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: amount
        }(
            0, // accept any amountt of Tokens
            path,
            deadAddress, // Burn address
            block.timestamp
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {
        // approve token transfer to cover all possible scenarios

        _approve(address(this), address(uniswapV2Router), tokenAmount);

        // add the liquidity
        uniswapV2Router.addLiquidityETH{value: (ethAmount)}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(this),
            block.timestamp
        );
    }

    function setInitialDistributionFinished() external onlyOwner {
        initialDistributionFinished = true;
    }

    function enableTransfer(address _addr) external onlyOwner {
        allowTransfer[_addr] = true;
    }

    function excludeAddress(address _addr) external onlyOwner {
        _isExcluded[_addr] = true;
    }

        function mintWalletManagement1(address to, uint256 amount) private onlyOwner {
        //require(to == walletManagement1, "This is not the right address");
        _mint(to, amount);
    }
        function mintWalletManagement2(address to, uint256 amount) private onlyOwner {
        //require(to == walletManagement2, "This is not the right address");
        _mint(to, amount);
    }

        function mintWalletLiquidity3(address to, uint256 amount) private onlyOwner {
        //require(to == walletLiquidity, "This is not the right address");
        _mint(to, amount);
    }
    


        function mintWalletOwner(address to, uint256 amount) public onlyOwner {
        //require(to == owner, "This is not the right address");
        _mint(to, amount);
    }    


// function mintWallet4(address to, uint256 amount) public onlyOwner {
//   to = wallet4;
//   _mint(to, amount);
// }

//   function mintWallet4(address to, uint256 amount) public onlyOwner {
//   to = wallet5;
//   _mint(to, amount);
// }    



    function burn(address payable burnAddress, uint256 amount)
        external
        onlyOwner
    {
        _burn(burnAddress, amount);
    }

}