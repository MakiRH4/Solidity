// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts below and return the lower of the two prices
     */

    function getLowerPrice(
		address _priceOracle1,
		address _priceOracle2
		) external returns (uint256) {
		//Oracle1
        (bool okOracle1, bytes memory oracle1) = _priceOracle1.call(
			abi.encodeWithSignature("price()"));
		require(okOracle1, "call on Oracle1 failed");
		uint256 _oracle1 = abi.decode(oracle1, (uint256));

		//Oracle2
		(bool okOracle2, bytes memory oracle2) = _priceOracle2.call(abi.encodeWithSignature("price()"));
		require(okOracle2, "call on Oracle2 failed");
		uint256 _oracle2 = abi.decode(oracle2, (uint256));

		if (_oracle2 > _oracle1) {
			return _oracle1;
		}
		else {
			return _oracle2;
		}

		// your code here
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
