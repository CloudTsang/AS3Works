application.onConnect = function(client , type){
	application.acceptConnection(client);
	if(type=="ChatServer"){
		trace("接受FMS服务器的连接。");
//		client.type="Server";
	//	SO = SharedObject.get ("SeverSO", false);
		return;
	}
	
	if(gameArr[totalGame]==null)	{		
		trace("首位用户进行了连接，设定为黑色玩家");
		gameArr.push( GameInit( gidArr.splice(0,1) ) );
		client.color=black;		
		client.call("initPlayer" , new handlerObject , gameArr[totalGame].gid , black , gameArr[totalGame].chessArr ,  "正在等待加入..." , "你是黑色先行" , "你是黑色");	
	}else{
		trace("第二位用户进行了连接，设定为白色玩家");		
		client.color=white;
		client.call("initPlayer" , new handlerObject , gameArr[totalGame].gid , white , gameArr[totalGame].chessArr ,  "你是白色后行" , "游戏正在开始" , "你是白色");
	}
	
	client.type="player";
	client.gid=gameArr[totalGame].gid;
//	BnWClientArr.push(client);
	gameArr[totalGame].playerArr.unshift(client);	
	if(gameArr[totalGame].playerArr.length==2){
		gameArr[totalGame].isGaming=true;
		gameHandler(totalGame);
		totalGame+=1;
	}
}

ConnectionHandler=function(info){
//	trace(info.code);
	switch(info.code){		
		case "NetConnection.Connect.Rejected":
			if(info.application.msg=="setPlayer"){
				gameArr[info.application.id].playerArr[0].cid=Number(info.application.player1);
				gameArr[info.application.id].playerArr[1].cid=Number(info.application.player2);
			}
			break;		
	}
}

application.onDisconnect=function(client)
{
	if(client.type=="Server"){
		return;
	}
	var no=GetGameByGid(client.gid);
	if(gameArr[no].isGaming==false){
		gidArr.push(gameArr[no].gid);
		gameArr.splice(no,1);
		totalGame=gameArr.length;
		return;		
	}
	//	if(client.color==white)	
	anotherPlayer(no).call("special",new handlerObject,"escwin");
	//	else	if(client.color==black)	gameArr[no].playerArr[white].call("special",new handlerObject,"escwin");
	gameArr[no].isGaming=false;
}
	