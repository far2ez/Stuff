package com.hurlant.crypto.prng {
    import flash.utils.*;
    import flash.text.*;
    import com.hurlant.util.*;
    import flash.system.*;

    public class _um324 {

        private var state:_ju759;
        private var ready:Boolean = false;
        private var _ek153:ByteArray;
        private var _mg749:int;
        private var _lc568:int;
        private var _ja967:Boolean = false;

        public function _um324(_arg1:Class=null){
            var _local2:uint;
            super();
            if (_arg1 == null){
                _arg1 = _rw793;
            };
            this.state = (new (_arg1) as _ju759);
            this._mg749 = this.state._lj606();
            this._ek153 = new ByteArray();
            this._lc568 = 0;
            while (this._lc568 < this._mg749) {
                _local2 = (65536 * Math.random());
                var _local3 = this._lc568++;
                this._ek153[_local3] = (_local2 >>> 8);
                var _local4 = this._lc568++;
                this._ek153[_local4] = (_local2 & 0xFF);
            };
            this._lc568 = 0;
            this._fd411();
        }
        public function _fd411(_arg1:int=0):void{
            if (_arg1 == 0){
                _arg1 = new Date().getTime();
            };
            var _local2 = this._lc568++;
            this._ek153[_local2] = (this._ek153[_local2] ^ (_arg1 & 0xFF));
            var _local3 = this._lc568++;
            this._ek153[_local3] = (this._ek153[_local3] ^ ((_arg1 >> 8) & 0xFF));
            var _local4 = this._lc568++;
            this._ek153[_local4] = (this._ek153[_local4] ^ ((_arg1 >> 16) & 0xFF));
            var _local5 = this._lc568++;
            this._ek153[_local5] = (this._ek153[_local5] ^ ((_arg1 >> 24) & 0xFF));
            this._lc568 = (this._lc568 % this._mg749);
            this._ja967 = true;
        }
        public function _bv913():void{
            var _local3:Font;
            var _local1:ByteArray = new ByteArray();
            _local1.writeUnsignedInt(System.totalMemory);
            _local1.writeUTF(Capabilities.serverString);
            _local1.writeUnsignedInt(getTimer());
            _local1.writeUnsignedInt(new Date().getTime());
            var _local2:Array = Font.enumerateFonts(true);
            for each (_local3 in _local2) {
                _local1.writeUTF(_local3.fontName);
                _local1.writeUTF(_local3.fontStyle);
                _local1.writeUTF(_local3.fontType);
            };
            _local1.position = 0;
            while (_local1.bytesAvailable >= 4) {
                this._fd411(_local1.readUnsignedInt());
            };
        }
        public function _da67(_arg1:ByteArray, _arg2:int):void{
            while (_arg2--) {
                _arg1.writeByte(this._rd906());
            };
        }
        public function _rd906():int{
            if (!this.ready){
                if (!this._ja967){
                    this._bv913();
                };
                this.state.init(this._ek153);
                this._ek153.length = 0;
                this._lc568 = 0;
                this.ready = true;
            };
            return (this.state.next());
        }
        public function dispose():void{
            var _local1:uint;
            while (_local1 < this._ek153.length) {
                this._ek153[_local1] = (Math.random() * 0x0100);
                _local1++;
            };
            this._ek153.length = 0;
            this._ek153 = null;
            this.state.dispose();
            this.state = null;
            this._mg749 = 0;
            this._lc568 = 0;
            _cr359.gc();
        }
        public function toString():String{
            return ((irrcrpt("tcpfqo-", 2) + this.state.toString()));
        }

    }
}