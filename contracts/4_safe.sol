pragma solidity ^0.4.19;
contract Private_Bank
{
    uint public counter;
    mapping (address => uint) public balances;
    uint public MinDeposit = 1 ether;
    Log TransferLog;
    function Private_Bank(address _log) public payable {
        counter = 0;
        TransferLog = Log(_log);
    }
    function Deposit() public  payable  {
        if(msg.value >= MinDeposit) {
            balances[msg.sender]+=msg.value;
            TransferLog.AddMessage(msg.sender,msg.value,"Deposit");
        }
    }
    function CashOut(uint _am)  {
        counter = counter + 1;
        if(_am<=balances[msg.sender]) {
            balances[msg.sender]-=_am;
            if(msg.sender.call.value(_am)()) {
                TransferLog.AddMessage(msg.sender,_am,"CashOut");
            }  
        }
    }
    function() public payable{}
}
contract Log
{
    struct Message
    {
        address Sender;
        string  Data;
        uint Val;
        uint  Time;
    }
    Message[] public History;
    Message LastMsg;
    function AddMessage(address _adr,uint _val,string _data)  public {
    LastMsg.Sender = _adr;
    LastMsg.Time = now;
    LastMsg.Val = _val;
    LastMsg.Data = _data;
    History.push(LastMsg);
    }
}