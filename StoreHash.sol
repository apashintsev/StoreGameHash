// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract StoreHash is Ownable {
    
    mapping (uint=>bytes32) private games;

    modifier gameNotExist(uint id){
         require (games[id].length==0, "Game with that id is allready added");
        _;
    }

    //получить хэш игры по номеру игры
    function getGameHash(uint _gameId) external view returns(bytes32){
        return games[_gameId];  
    }

    //СПОСОБ1. сохранить хэш игры записав сам хэш под номер игры
    function storeGameHash1(uint _gameId, bytes32 _gameHash) external onlyOwner gameNotExist(_gameId){
        games[_gameId] = _gameHash;
    } 

    //СПОСОБ2. сохранить хэш игры прохэшировав загаданное число и соль внутри контракта
    function storeGameHash2(uint _gameId, string memory _hiddenNumber, string memory _salt) external onlyOwner gameNotExist(_gameId){
        games[_gameId] = sha256(bytes.concat(bytes(_hiddenNumber), "", bytes(_salt)));
    }
    
    receive() external payable{
        revert("We are not receiving money");
    }
}

