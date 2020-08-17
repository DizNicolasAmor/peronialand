pragma solidity ^0.6.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract Peronialand is ERC20, AccessControl {
    using SafeMath for uint256;

    bytes32 public constant POLITICIAN_ROLE = keccak256("POLITICIAN_ROLE");
    bytes32 public constant RECEIVER_ROLE = keccak256("RECEIVER_ROLE");
    uint256 private _initialSupply = 1;
    address[] private _receivers;
    address[] private _producers;
    address[] private _politicians;
    uint256 lastUpdated;

    constructor() public ERC20("Peronios", "PÉ") {
        addPolitician(msg.sender);
    }

    function updateTimestamp() private {
        lastUpdated = now;
    }

    function _isPrinterAvailable() internal view returns (bool) {
      returns (now >= lastUpdate + 1 minutes);
    }

    function moneyPrinterGoesBrrr() public {
        require(
            hasRole(RECEIVER_ROLE, msg.sender),
            "Caller should be a receiver"
        );
        require(_isPrinterAvailable(), "Printer is not available");

        // In Peronialand this money printing does not steal purchasing power from the producers towards the receivers. No. This is just solidarity.
        for (uint256 i = 0; i < _receivers.length; i++) {
            _mint(_receivers[i], _initialSupply);
        }
        // In Peronialand politicians receive more money because all citizens are equal, but some citizens are more equal than others.
        for (uint256 i = 0; i < _politicians.length; i++) {
            _mint(_politicians[i], _initialSupply.mul(10));
        }

        updateTimestamp();
    }

    function addReceiver(address _address) public {
        require(
            !hasRole(RECEIVER_ROLE, _address),
            "Submited address is already a receiver"
        );
        _setupRole(RECEIVER_ROLE, _address);
        _receivers.push(_address);
    }

    function addPolitician(address _address) public {
        require(
            hasRole(POLITICIAN_ROLE, msg.sender),
            "Caller is not a politician"
        );
        require(
            !hasRole(POLITICIAN_ROLE, _address),
            "Submited address is already a politician"
        );
        _setupRole(POLITICIAN_ROLE, _address);
        // Yes, in Peronialand politicians are also receivers.
        _setupRole(RECEIVER_ROLE, _address);
        _politicians.push(_address);
    }
}
