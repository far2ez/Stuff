package {
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import flash.net.*;
    import flash.media.*;
    import com.hurlant.crypto.symmetric.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.system.*;
	import flash.external.ExternalInterface;
	
    public class GraalLoader extends MovieClip {
        public var loadingBackground:Class;
        public var loadingBar0:Class;
        public var loadingBar1:Class;
        public var loadingBar2:Class;
        public var loadingBar3:Class;
        public var loadingBar4:Class;
        public var loadingBar5:Class;
        public var loadingImage0:Class;
        public var loadingImage1:Class;
        private var gameLoader:Loader = null;
        private var _is504:Sprite = null;
        private var backgroundImage:Bitmap = null;
        private var currentLoadingImage:Bitmap = null;
        private var loadingBar:Bitmap = null;
        private var onlyOne:int = 0;
        private var preloader:URLLoader;
        private var _nj369:Sound = null;
        private var _bp87:SoundChannel = null;
        private var passkey:String;
        private var cryptoString:encryptedString = null;
        private var iterating:int = 0;
        private var timeout:Timer = null;
        private var screenText:TextField = null;

		// Constructor that starts the whole thing!
        public function GraalLoader():void {
            this.loadingBackground = GraalLoader_loadingBackground;
            this.loadingBar0 = GraalLoader_loadingBar0;
            this.loadingBar1 = GraalLoader_loadingBar1;
            this.loadingBar2 = GraalLoader_loadingBar2;
            this.loadingBar3 = GraalLoader_loadingBar3;
            this.loadingBar4 = GraalLoader_loadingBar4;
            this.loadingBar5 = GraalLoader_loadingBar5;
            this.loadingImage0 = GraalLoader_loadingImage0;
            this.loadingImage1 = GraalLoader_loadingImage1;
            this.passkey = "49y7do0HtcwAgBwQ"; // irrcrpt("72b0gr3KwfzDjEzT", 3); //"72y0do3HtcwAgBwQ"; 49y7do0HtcwAgBwQ
			super();
			
            this.gameLoader = new Loader();
            addChild(this.gameLoader);
			
            this.backgroundImage = new this.loadingBackground();
            this.backgroundImage.x = 0;
            this.backgroundImage.y = 0;
            this.backgroundImage.width = 760;
            this.backgroundImage.height = 592;
            addChild(this.backgroundImage);
			
            this.showLoadBar(1);
            if (stage){
                this.init();
            } else {
                addEventListener(Event.ADDED_TO_STAGE, this.init);
            };
        }
		
		// Prints loading/unpacking-related messages to screen, though I'm not sure where lol
        public function printToScreen(msg:String):void{
            if (!this.screenText){
                return;
            };
            this.screenText.appendText("\n" + msg);
            this.screenText.scrollV = 99999;
        }
		
		// Handles the display of the loading bar as well as the loading image
        private function showLoadBar(loadingBarID:int):void{
            if (this.loadingBar != null){
                removeChild(this.loadingBar);
            };
			
            switch (loadingBarID) {
                case 1:
                    this.loadingBar = new this.loadingBar0();
                    break;
                case 2:
                    this.loadingBar = new this.loadingBar1();
                    break;
                case 3:
                    this.loadingBar = new this.loadingBar2();
                    break;
                case 4:
                    this.loadingBar = new this.loadingBar3();
                    break;
                case 5:
                    this.loadingBar = new this.loadingBar4();
                    break;
                case 6:
                    this.loadingBar = new this.loadingBar5();
                    break;
            };
			
            this.loadingBar.x = 395;
            this.loadingBar.y = (592 - 90);
            this.loadingBar.width = 240;
            this.loadingBar.height = 48;
			
            addChild(this.loadingBar);
			
            if (this.currentLoadingImage != null) {
                removeChild(this.currentLoadingImage);
            };
			
			// Display the background image
            if (loadingBarID >= 3){
                switch (loadingBarID){
					// Image one: people on gray building
                    case 3:
                    case 4:
                        this.currentLoadingImage = new this.loadingImage0();
                        break;
					
					// Image two: people inside of red building
                    case 5:
                    case 6:
                        this.currentLoadingImage = new this.loadingImage1();
                        break;
                };
				
                this.currentLoadingImage.x = 337;
                this.currentLoadingImage.y = 205;
                this.currentLoadingImage.width = 380;
                this.currentLoadingImage.height = 260;
				
                addChild(this.currentLoadingImage);
            };
        }

// Before this line seems to be about drawing sprites and shit
// After this line is where it inits
        private function init(_arg1:Event=null):void{
            removeEventListener(Event.ADDED_TO_STAGE, this.init);

// This seems to be what I want #1
            stage.addEventListener(Event.ENTER_FRAME, this.retrieveBinary);

// This is for the context menu
            this.createContextMenu();
        }
		
// Custom function
		private function debug(msg:String) : void {
			try {
				ExternalInterface.call("console.log", msg);
			} catch (e:Error) {
				
			}
		}

// Next two functions are for the context menu
        private function createContextMenu():void{
            var _local1:ContextMenu = new ContextMenu();
            _local1.hideBuiltInItems();
            var _local2:ContextMenuItem = new ContextMenuItem("Show Player Profile");
            _local2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this._ya345);
            _local1.customItems.push(_local2);
            var _local3:ContextMenuItem = new ContextMenuItem("Classic Facebook Page");
            _local3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this._ko507);
            _local1.customItems.push(_local3);
            contextMenu = _local1;
        }
        public function _ko507(_arg1:ContextMenuEvent):void{
            navigateToURL(new URLRequest("http://www.facebook.com/graalonlineclassic"), "_blank");
        }
        public function _ya345(_arg1:ContextMenuEvent):void{
            var _local2:Sprite = (this.gameLoader.content as Sprite);
            if (_local2){
                _local2.dispatchEvent(new Event("onPlayerProfileClick2", true));
            };
        }

// This seems to be what I want #2
        private function retrieveBinary(_arg1:Event):void {
            this.onlyOne++;
            if (this.onlyOne < 2){
                return;
            };
            stage.removeEventListener(Event.ENTER_FRAME, this.retrieveBinary);
            stage.frameRate = 20;
            this.printToScreen("Start loading...");
            this.preloader = new URLLoader();
			
			debug("test1");
			//var _local2:URLRequest = new URLRequest("http://192.168.0.105:8000/game");
			var _local2:URLRequest = new URLRequest("https://classiciframecloud.quattroplay.com/qplay_classic_20140610.png");
            this.preloader.addEventListener(ProgressEvent.PROGRESS, this.updateLoadingBar);
            this.preloader.addEventListener(Event.COMPLETE, this.gameLoaded);
            this.preloader.dataFormat = URLLoaderDataFormat.BINARY;
            this.preloader.load(_local2);
			debug("test2");
        }

// Loading function
        private function updateLoadingBar(percentage:ProgressEvent):void{
            this.printToScreen(("Loading: " + ((100 * percentage.bytesLoaded) / percentage.bytesTotal)));
            var barImageID:int = ((percentage.bytesLoaded / percentage.bytesTotal) * 4);
            this.showLoadBar((2 + barImageID));
        }

// Here is #3. The game data is finished loading and generates a passkey that is later used to de-obfuscate the game data
        private function gameLoaded(_arg1:Event):void{
			this.printToScreen("Loading done.");
            this.showLoadBar(6);

            var _local2:ByteArray = new ByteArray();
            _local2.writeUTF(this.passkey);

            this.cryptoString = new encryptedString(_local2);
            this.iterating = 0;
            this.timeout = new Timer(10, 0);
            this.timeout.addEventListener(TimerEvent.TIMER, this.unpackGame);
            this.timeout.start();
            this.printToScreen("Start unpacking...");
			debug("test1");
        }

// This is #4. The game is de-obfuscated here.
        private function unpackGame(_arg1:TimerEvent):void{
            // this.preloader.data.length = 2,297,547
            var localMax = (this.preloader.data.length & ~(15));
            var i:int;
            while ((((i < 10000)) && ((this.iterating < localMax)))) {
                this.cryptoString.unpack(this.preloader.data, this.iterating);
                i++;
                this.iterating = (this.iterating + 16);
            };
            this.printToScreen(("Unpacked: " + ((100 * this.iterating) / localMax)));
            if (this.iterating < localMax){
                return;
            };
			// this.iterating = 2,297,536 = the size of the file!
			
			//var file:FileReference = new FileReference();
			//file.save(this.preloader.data, "output.txt");
			//debug("Done");
			
            this.printToScreen("Unpacking done.");
            this.timeout.stop();
            this.runGame();
		}
        private function runGame():void{
			debug("test2.5");
            this.printToScreen("Running game...");
			
			// TODO: Figure out WTF an applicationdomain is. I think this is why I can't actually LOAD the game.
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
	        
			this.gameLoader.contentLoaderInfo.parameters.qplaycookie = "542532233655477b99aae4942f6914e7";//root.loaderInfo.parameters.qplaycookie;
            this.gameLoader.contentLoaderInfo.parameters.parent = this;
            this.gameLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.startGame);
            this.gameLoader.contentLoaderInfo.addEventListener("securityError", this.onSecurityError);

			debug("testlol");

			//Security.allowDomain("~~");
			//Security.allowInsecureDomain("~~");
			
			this.gameLoader.loadBytes(this.preloader.data, context);
        }
        private function onSecurityError(_arg1:Event):void{
            this.printToScreen("Security error when loading game.");
			debug("test4");
        }
        private function startGame(_arg1:Event):void{
			debug("test12");
            this.printToScreen("Game started.");
            var _local2:LoaderInfo = (_arg1.target as LoaderInfo);
            var _local3:Sprite = (_local2.loader.content as Sprite);
			debug("test13");
            _local3.addEventListener("hideLoadingScreen", this.hideLoading);
			debug("test5");
        }
        public function hideLoading(_arg1:Event):void{
			debug("test5.5");
            this.printToScreen("Scripts loaded.");
            if (this.screenText){
                removeChild(this.screenText);
            };
            removeChild(this.backgroundImage);
            removeChild(this.loadingBar);
            removeChild(this.currentLoadingImage);
            if (this._bp87 != null){
                this._bp87.stop();
                this._bp87 = null;
            };
            this._nj369 = null;
			debug("test6");
        }
	}
}