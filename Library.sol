// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./LibraryBase.sol"; //導入contract


contract Library is LibraryBase {
 
    //定義使用者資料結構
struct UserStruct {
    address userAddress;
    string username;
    string identity;
    uint time;
    uint index;
}

//定義使用者列表資料結構
struct UserListStruct {
    address userAddress;
    uint index;
}

address[] public userAddresses; //所有地址集合
string[] private usernames; //所有帳號名稱集合

mapping(address => UserStruct) private userStruct; //帳號地址對應個人資料
mapping(string => UserListStruct) private userListStruct; //帳戶名稱對應地址

//將Storage功能帶入Array使用

LibraryBase[] public libraryBaseArray;

    function createLibraryStorageContract () public {

        LibraryBase libraryBase = new LibraryBase(); //LibraryBase 為type libraryBase為變數名稱，new為deploy其他合約的指令
        libraryBaseArray.push(libraryBase); //取得contract address
    }

    /*function userRegister (string memory _userName, uint256 _password) public {
        
    }*/

//判斷使用者地址是否存在 (建立帳號時需用到)
function existUserAddress(address _userAddress) public view returns(bool isIndeed) {
    if (userAddresses.length == 0) return false;
    return (userAddresses[userStruct[_userAddress].index] == _userAddress);
}

//建立新使用者資料
function createUser(address _userAddress, string memory _username, string memory _identity) public returns (uint index) {
    require(!existUserAddress(_userAddress)); //若使用者地址已存在，不受理重複創建

    userAddresses.push(_userAddress); //地址陣列新增使用者地址
    userStruct[_userAddress] = UserStruct(_userAddress, _username, _identity, block.timestamp, userAddresses.length - 1);

    usernames.push(_username); //使用者陣列新增帳號名稱
    userListStruct[_username] = UserListStruct(_userAddress, usernames.length - 1); //帳號對應的地址集合

    return userAddresses.length - 1;
}
    


//獲取使用者個人資料
function findUser(address _userAddress) public view returns (address userAddress, string memory username, string memory identity, uint time, uint index) {
    require(existUserAddress(_userAddress));
    return (
        userStruct[_userAddress].userAddress,
        userStruct[_userAddress].username,
        userStruct[_userAddress].identity,
        userStruct[_userAddress].time,
        userStruct[_userAddress].index); 
}
    function penalitySystem () public payable onlyOwner {
    

    }

    /*function liStore (uint256 _libraryStorageIndex, uint256 _libraryStorageNumber) public {
        // address 
        // ABI - Application Binary Interface
        libraryStorageArray[_libraryStorageIndex].borrowBook(_libraryStorageNumber);  
    }

    function liGet (uint256 _libraryStorageIndex) public view returns (uint256) {
        return libraryStorageArray[_libraryStorageIndex].getBookState(); //libraryStorageArray 為物件
    }*/

    
}