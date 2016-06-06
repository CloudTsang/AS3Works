var handlerObject = function() {};

var chatClientArr;
var cidArr;
var serverArr;
var BnWPlayerArr;

var SO;

var NC;

application.onAppStart = function ()
{
	this.allowDebug = true;
	chatClientArr=new Array;
	serverArr=new Array;	
	cidArr=new Array(0,1,2,3,4,5,6,7,8,9);
	SO = SharedObject.get ("SeverSO",false);
	SO.setProperty("Log","");
	
	SO.onSync=syncHandler;
	trace("聊天室开始运行");	
}

syncHandler=function(){
	trace(SO.getProperty("Log"));
}

getClientById=function(_cid){
	for(var i=0 ; i<chatClientArr.length ; i++){
		//		if(chatClientArr[i].id==_id) return i;
		if(chatClientArr[i].cid==_cid)return i;
	}
}
	
getClientByName=function(_name){
	for(var i=0 ; i<chatClientArr.length ; i++){
		if(chatClientArr[i].userName==_name) return i;
	}	
}
	
getClietnByIp=function(_ip){
	for(var i=0 ; i<chatClientArr.length ; i++){
		if(chatClientArr[i].ip==_id) return i;
	}	
}	

handlerObject.prototype.onResult = function( result )
{
	trace( result );
};

handlerObject.prototype.onStatus = function( info )
{
	trace( "error: " + info.description );
	trace( "error: " + info.code );
};