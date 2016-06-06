Client.prototype.onPlaceChess = function(clientGid , point) 
{	
	var no=GetGameByGid(clientGid);
	if(no==null) return;
	if(gameArr[no].chessArr[point.x][point.y]!=empty){		
		//没有下在空格上
		currentPlayer(no).call("special" , new handlerObject , "empty");
		GameCtrlChatSide(no , "请下在空格上! " , null);
		return "请下在空格上";
	}
	for(var i=0  ;  i<gameArr[no].allWalkable.length ; i++ ){		
		if(point.x ==gameArr[no].allWalkable[i].x && point.y == gameArr[no].allWalkable[i].y){
			//正常
			gameArr[no].allScore[i].push(point);
			renewBoard(gameArr[no].allScore[i] , no);
			gameArr[no].scoreArr[ gameArr[no].currentPlayer ]+= gameArr[no].allScore[i].length;
			gameArr[no].scoreArr[ 1-gameArr[no].currentPlayer ]-=( gameArr[no].allScore[i].length-1 );
			gameArr[no].playerArr[white].call("placeRight", new handlerObject , gameArr[no].allScore[i] , gameArr[no].scoreArr ,gameArr[no].currentPlayer);
			gameArr[no].playerArr[black].call("placeRight", new handlerObject , gameArr[no].allScore[i] , gameArr[no].scoreArr ,gameArr[no].currentPlayer);
			gameHandler(no);		
			return "下棋成功";
		}
	}
	//没有吃子
	currentPlayer(no).call("special" , new handlerObject , "eat");
		GameCtrlChatSide(no , "每一步都要能吃子!" , null);
	return  "每一步都要能吃子";
}

scanHandler = function(no)
{
//	var no=GetGameByGid(id);
	gameArr[no].allWalkable=new Array;
	gameArr[no].allScore=new Array;
	var open; //仅用于吃子检测部分
	var p=new Object;
	var s=0;
	for(var i=0 ; i<=7 ; i++)
	{
		for(var j=0 ; j<=7 ; j++){
			if(gameArr[no].chessArr[i][j]!=empty)continue;
			open=new Array;
			p={x:i,y:j};
			for(var k=-1 ; k<=1 ; k++){
				for(var l=-1 ; l<=1 ; l++){
					var tmp=cellScan(p , k , l , no);
					if(tmp!=false) {
						for(var m=0 ; m<tmp.length ; m++){
							open.push(tmp[m]);
						}
					}
				}
			}	
			if(open.length>0){
				gameArr[no].allWalkable.push(p);
				gameArr[no].allScore.push(open);
			}
		}
	}
}

cellScan = function(p , dx , dy , n){
	var xx=p.x+dx;
	var yy=p.y+dy;
	var tmpArr=new Array;
	while(xx>=0 && xx<=7 && yy>=0 && yy<=7){
		switch(gameArr[n].chessArr[xx][yy]){
			case empty:
				return false;
			case 1-gameArr[n].currentPlayer:	
				tmpArr.push( {x:xx , y:yy} );
				break;
			case gameArr[n].currentPlayer:
				if(tmpArr.length>0){					
					return tmpArr;						
				}else{
					return false;
				}
		}
		xx+=dx;
		yy+=dy;
	}
	return false;
}
