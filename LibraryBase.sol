// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract LibraryBase {

//初始化
address public owner;

    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

//結構變數
string title;
uint callNumber;
bool bookState;
uint i;

   
    
   
    struct Book {
        uint callNumber;
        string title;
        bool bookState;
    }
    mapping (string => uint256) public titleToCallNumber;
    mapping (string => bool) public titleToBookState;
    Book[] public book;

    function addNewBook (string memory _title, uint256 _callNumber, bool _bookState) public {
        book.push(Book(_callNumber, _title, _bookState)); // (Book(_callNumber, _title)); ???
        titleToCallNumber[_title] = _callNumber;
        _bookState = false;
    }
    /*function borrowBookByTitle (uint256 _callNumber, bool _bookState) public {
        for (i= 0; i < book.length; i++){
        if (book.callNumber  ) {}
        }*/

    function borrowBookByTitle (string memory _title, bool _bookState) public returns (bool isborrowed){
        titleToBookState[_title] = _bookState;
        for (i= 0; i < book.length; i++){
        if(keccak256(abi.encodePacked(book[i].title))==keccak256(abi.encodePacked(_title))) {
        book[i].bookState = _bookState;
        return book[i].bookState;
        }   
    }
    }
    /* function getBookState (string memory _title) public view returns (bool) {
        return book[i].bookState;
    }*/

}
