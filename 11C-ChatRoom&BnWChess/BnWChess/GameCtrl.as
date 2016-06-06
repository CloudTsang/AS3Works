gameHandler=function (no){
	gameArr[no].currentPlayer = 1-gameArr[no].currentPlayer;
	scanHandler(no);		
	if(	gameArr[no].allWalkable.length==0)
	{
		//gameset		
		if((gameArr[no].scoreArr[white]+	gameArr[no].scoreArr[black])==64 ){
			if(gameArr[no].scoreArr[gameArr[no].currentPlayer]>32){
				currentPlayer(no).call("win" , new handlerObject);
				anotherPlayer(no).call("lose" , new handlerObject);
					GameCtrlChatSide(no , "你赢了" , "你输了");
			}else{
				anotherPlayer(no).call("win" , new handlerObject);
				currentPlayer(no).call("lose" , new handlerObject);
					GameCtrlChatSide(no , "你输了" , "你赢了");
			}
			return;
		}
		//pass
		gameArr[no].currentPlayer = 1-gameArr[no].currentPlayer;
		scanHandler(no);
		currentPlayer(no).call("special" , new handlerObject , "passing");
		anotherPlayer(no).call("special" , new handlerObject , "passed");		
		GameCtrlChatSide(no , "你能再下一步" , "你被pass了");
		return;
	}
	trace("已更新下一手的信息");
	currentPlayer(no).call("turn" , new handlerObject ,true);
	anotherPlayer(no).call("turn" , new handlerObject ,false);
	GameCtrlChatSide(no , "轮到你下棋了。","下棋成功。");
}

currentPlayer=function(no){
	return gameArr[no].playerArr[gameArr[no].currentPlayer];
}
anotherPlayer=function(no){
	return gameArr[no].playerArr[1-gameArr[no].currentPlayer];
}

GameCtrlChatSide=function(no , str1 , str2){
	var tmpObj={
		type:"BnWServer",
		name:"BnWChess",
		gameid:no,
		chess:gameArr[no].chessArr , 			
			player1:currentPlayer(no).cid,
//			player1:currentPlayer(no).ip,
			msg1:str1,
			player2:anotherPlayer(no).cid,
//			player2:anotherPlayer(no).ip,
			msg2:str2
	}		
	NC.connect("rtmp://localhost/ChatRich1NC" , tmpObj);
}

renewBoard = function (arr , no)
{	
	for(var i=0 ; i<arr.length ; i++) gameArr[no].chessArr[arr[i].x][arr[i].y]=gameArr[no].currentPlayer;
}
