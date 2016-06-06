Client.prototype.UserTalk=function(name , str){	
	//检测是否违规
	if(str.substr(0,4) == "cmd:" || str.substr(0,4) =="cmd："){		
		var tmp=str.substr(4).split("&");	
		tmp={x:tmp[0] , y:tmp[1]};		
		if(tmp.x<=7 && tmp.y<=7 && tmp.x>=0 && tmp.y>=0)
		{
			for(var g=0 ; g<chatClientArr.length ; g++){
				if(chatClientArr[g].userName==name) {			
					chatClientArr[g].call("logRenew" , new handlerObject , str);
						for(var h=0 ; h<serverArr.length ; h++) serverArr[h].call("onPlaceChess" , new handlerObject , chatClientArr[g].cid  , tmp);
					return {info:"下棋操作指令已发送！" , type:"trace"};
				}
			}
		}
		return {info:"下棋操作指令错误！" , type:"alert"};
	}
	
	var tmpstr=SO.getProperty("Log")+"<font color='#0000ff'>"+name+"</font>"+" : "+str+"<br>";
	SO.lock();
	SO.setProperty("Log" ,tmpstr);
	SO.unlock();
	for(var i=0 ; i<chatClientArr.length ; i++){
		chatClientArr[i].call("logRenew" , new handlerObject , "<font color='#0000ff'>"+name+"</font>"+" : "+str+"<br>");
	}
	return {info:"已更新聊天记录" , type:"trace"};
}

NewUserJoin=function(client){
	client.call("getUserlist",new handlerObject , chatClientArr);
	client.call("logRenew", new handlerObject , SO.getProperty("Log"))
	for(var i=0 ; i<chatClientArr.length ; i++) chatClientArr[i].call("renewUserlist" , new handlerObject , client.userName , client.id ,true);
}	
	