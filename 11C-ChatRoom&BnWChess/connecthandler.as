
application.onConnect = function (client , Obj )
{	
	trace(Obj.type);
	if(Obj.type=="BnWServer"){
		var ret=new Object;
		if(BnWPlayerArr.length>0 && Obj.player1==undefined){
			ret={
				msg:"setPlayer",
				id:Obj.gameid,
					player1:chatClientArr[BnWPlayerArr.shift(0,1)].cid,
					player2:chatClientArr[BnWPlayerArr.shift(0,1)].cid
			}				
			application.rejectConnection(client , ret);
			NC=new NetConnection;
			NC.connect("rtmp://localhost/BnWChessVerServer" , "ChatServer");		
			serverArr.push(NC);
			return ;
		}
		if(Obj.chess!=undefined){
			ret.msg="setChess";
			var p1=getClientById(Obj.player1);
			var p2=getClientById(Obj.player2);
			chatClientArr[p1].call("renewThumb" , new handlerObject , Obj.chess);
			chatClientArr[p2].call("renewThumb" , new handlerObject , Obj.chess);
			if(Obj.msg1 != null)chatClientArr[p1].call("logRenew"  , new handlerObject  , "<font color='#00ff00'>"+Obj.msg1+"</font><br>");
			if(Obj.msg2 != null) chatClientArr[p2].call("logRenew"  , new handlerObject  , "<font color='#00ff00'>"+Obj.msg2+"</font><br>");
			application.rejectConnection(client , ret);
			return;
		}
		return;		
	}
	
	if(cidArr.length==0){
		var  errObj=new Object;
		errObj.message="聊天室用户数已到达上限!";
		application.rejectConnection(client , errObj);
		return false;
	}
	
	for(var i=0 ; i< chatClientArr.length ; i++){
		if(Obj.name==chatClientArr[i].userName){
			var  errObj=new Object;
			errObj.message="用户名已被占用!";
			application.rejectConnection(client , errObj);
			return false;
		}
	}
	
	application.acceptConnection(client);
	client.userName = Obj.name;	
	client.cid=cidArr.splice(0,1);
	NewUserJoin(client);	
	chatClientArr.push(client);
//	trace(client.userName + "  " + client.id + "  " + client.ip);	
	return true;
}

Client.prototype.joinBnW=function(client){
	if(BnWPlayerArr==null)BnWPlayerArr=new Array;
	BnWPlayerArr.unshift(getClientByName(client.userName));
}

application.onDisconnect = function(client)
{ 
	for(var i=0 ; i<chatClientArr.length ; i++){
		if(client.id == chatClientArr[i].id){
			trace(chatClientArr[i].userName+" 退出了聊天室。");
			cidArr.push(chatClientArr[i].cid);
			chatClientArr.splice(i,1);
			break;
		}
	}
	//	application.broadcastMsg("renewUserlist"  , client.userName , client.id ,false);
}
