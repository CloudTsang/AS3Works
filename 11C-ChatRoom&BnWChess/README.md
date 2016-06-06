#FMS聊天室
内含黑白棋对战

* [聊天室](#chat)

 * [flex](#flex)
 * [fms](#fms1)
 
* [黑白棋](#chess)
 * [flash](#flash)
 * [fms](#fms2)
 
##<p id="chat">聊天室</p>

###flex

学习FMS时做的**视频聊天室**，第一次做联网应用，花了一些时间学习服务器端的语法。~~然而成品和网上的范例没太大区别...~~
``` as3
public function btnConfirm_clickHandler(event:MouseEvent):void
			{			
				responder=new Responder(callServerSuccess , callServerError);
				nc=new NetConnection;
				nc.addEventListener(NetStatusEvent.NET_STATUS,onTalkNetStatusHandler);				
				nc.connect(addr , {type:"client" , name:nameInputText.text});
                //被服务器call的client函数				
				nc.client={		
					logRenew:renewLog,//更新聊天记录
					getUserlist:getUserlist,//获取用户列表
					renewUserlist:renewUserlist,//更新用户列表
					renewThumb:CreateBnWThumb//更新黑白棋缩略图
				};			
				userArray=new ArrayCollection();
			}
```

更新聊天记录的函数，这样将新的聊天记录直接```+=```到htmlText上，在记录变多了之后性能会变得很差吧，但这时候还没有想到这些。
```as3
private function renewLog(str:String=""):String{
				trace(str);			
				txtLog.htmlText+=str;
				txtLog.validateNow();
				txtLog.verticalScrollPosition=txtLog.maxVerticalScrollPosition;	
				return (nc.client.userName+"更新了聊天记录");
			}
```
做了黑白棋之后顺便在聊天室里也加入了看棋盘缩略图的功能。

###<p id="fms1">fms</p>
其实加了聊天室直接下棋的功能,客户端发送``` cmd:4&4 ```这样的信息就可以。

*但实际上没人会看着聊天室的缩略图直接脑补下棋坐标来玩的吧(•ω<)*
``` javascript
	if(str.substr(0,4) == "cmd:" || str.substr(0,4) =="cmd："){		
		var tmp=str.substr(4).split("&");	
		tmp={x:tmp[0] , y:tmp[1]};
        ...		
		serverArr[h].call("onPlaceChess" , new handlerObject , chatClientArr[g].cid  , tmp);
        ...					
		}

```
<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/chat2.png"/>

##<p id="chess">黑白棋</p>

此外还做了一个联网对战的**黑白棋**。

因为黑白棋不能想下哪里下哪里，所以这里的做法是将下棋点坐标上传到服务器，服务器判断过之后将下一手能下的坐标数组传给客户端，和一般棋类游戏的“下棋-判断”相反，就是选择做黑白棋的原因。

之后将聊天室和黑白棋组合在一起变成游戏大厅（笑），但只是简单地加载了swf，不能从用户列表上选择对战对手，而是按照开启黑白棋界面的顺序两两配对。

###flash
重要的下棋逻辑判断是在服务区端进行，所以客户端要做的事情不多，主要就是接收服务器发来的下一步选择、更新盘面而已。

用的最多的下棋和更新棋盘的函数

``` as3
	public function clickHandler(e:MouseEvent):void{
			var p:Object=chessBoard.getPoint();
			if(OreNoTurn==true && p!=null) {			
				OreNoTurn=false;
				NC.call("onPlaceChess" , res , GameData.id , p);
			}			
		}
	private function nextStep(torenew:Array , score:Array , color:int):String{
			trace(NC.client.number);
			chessBoard.renewBoard(color , torenew);
			tPanel.renewScore(score[GameData.white] , score[GameData.black]);
			return "对局更新成功";
		}
```
棋盘就是1张bitmap，用flashprocs6画了3个不同状态的图，更新的时候只draw要改变的坐标，copypixel的参数是比较复杂我通常不怎么用。
``` as3
/**翻转棋子函数
		 * @param col：棋子颜色 ，  -1：黑棋 ， 1：白棋
		 * @param vec：要翻转棋子的位置
		 * **/
	public function renewBoard(col:int , toRenew:Array):String{
       ...
			for(var k:int=0 ; k<toRenew.length ; k++){				
				bmpd.draw( tmp , new Matrix( 1 , 0 , 0 , 1 , toRenew[k].x*80 , toRenew[k].y*80));	
			}
       ...
       }
```

###<p id="fms2">fms</p>
服务器主要负责扫描棋盘，处理下棋逻辑，
scanHandler按8个方向循环调用cellScan，当有吃子时cellScan返回被吃的棋子的坐标数组，放入所有吃子的坐标数组open中。
``` javascript
scanHandler = function(no){
 ...
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
 ...
}

cellScan = function(p , dx , dy , n){
   ...
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
   ...
}
```

做这个东西时已经学了一段时间的AS3，fms用的javascript（?）语法虽然很不一样但用得不深入也没有花太多时间学习，看得懂就是写的时候要经常查格式，所以有一些考虑程序效率的地方*（大概从做06T-BmpShuffle时就开始注意这个）*，比如棋盘图案更新，换作之前就不想太多直接整张图重画了，吃子判断的时候也有注意在扫描到空格和自己颜色的时候直接break等等。

<img src="https://raw.githubusercontent.com/CloudTsang/AS3Works/master/picture/chat.png"/>

