const white=0;
const black=1;
const empty=2;
var gidArr;//从这个数组中slice一个元素做id，用户退出之后还回去？
//var BnWClientArr;
var totalGame;//game总数
var SO;
var NC;//用于连接到聊天室？的nc
var handlerObject = function() {};

var gameArr; //全部对局的数组其中每一个元素是一个Object
//gameObj
//id  游戏id号
//playerArr 双方玩家数组 [ white , black ]
//chessArr 棋盘数组
//currentPlayer=white 现在轮到的玩家颜色，初始值为white，在gamehandler函数中会反转
//scoreArr 得分数组
// allWalkable 全部可以行走的步数的数组
//allScore 对应allWalkable中每一个元素相应吃子的数组
//isGaming=false   是否在进行游戏，初始值为false


application.onAppStart = function ()
{
	this.allowDebug = true;
	gidArr=new Array(0,1,2,3,4,5);
	gameArr=new Array;
//	BnWClientArr=new Array;
	NC=new NetConnection;	
	NC.onStatus=ConnectionHandler;
	totalGame=0;
	trace("黑白棋application开始运行");
//	SO = SharedObject.get ("SeverSO", false );//, NC);
//	SO.setProperty("Log" , "show");
//	trace(SO.getProperty("Log"));
	
}

GameInit=function(_gid){	
	var gameObj={
		gid:_gid,
		chessArr:new Array(
			[2 , 2 , 2 , 2 , 2 , 2 , 2 , 2],
			[2 , 2 , 2 , 2 , 2 , 2 , 2 , 2],
			[2 , 2 , 2 , 2 , 2 , 2 , 2 , 2],
			[2 , 2 , 2 , 0 , 1 , 2 , 2 , 2],
			[2 , 2 , 2 , 1 , 0 , 2 , 2 , 2],
			[2 , 2 , 2 , 2 , 2 , 2 , 2 , 2],
			[2 , 2 , 2 , 2 , 2 , 2 , 2 , 2],
			[2 , 2 , 2 , 2 , 2 , 2 , 2 , 2]),
		scoreArr:new Array(2,2),
		playerArr:new Array(), 
		currentPlayer:white,
		isGaming:false,
		allWalkable:new Array,
		allScore:new Array
	};
	return gameObj;		
}

getPlayerId=function(no){
	return gameArr[no].playerArr[gameArr[no].currentPlayer].id;
}
	
syncHandler = function()	{}	

//获取_id为参数值的对局在gameArr中的索引
GetGameByGid=function(_id){
	for(var i=0 ; i<gameArr.length ; i++){
		if(gameArr[i].gid==_id 
			|| gameArr[i].playerArr[white].gid==_id 
			|| gameArr[i].playerArr[black].gid==_id
			|| gameArr[i].playerArr[white].cid==_id 
			|| gameArr[i].playerArr[black].cid==_id)   return i; //return gameArr[i];
	}
	return null;
}

handlerObject.prototype.onResult = function( result )
{
	if(result==undefined)trace( "call client success" );
	else trace(result);
}

handlerObject.prototype.onStatus = function( info )
{
	trace( "error: " + info.description );
	trace( "error: " + info.code );
}
	