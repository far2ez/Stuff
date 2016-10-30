package com.hurlant.crypto.prng {
    import flash.utils.*;
    import com.hurlant.crypto.symmetric.*;
    import com.hurlant.util.*;

    public class _rw793 implements _ju759, _bj676 {

        private const _mg749:uint = 0x0100;

        private var _gb575:int = 0;
        private var _ih73:int = 0;
        private var S:ByteArray;

        public function _rw793(_arg1:ByteArray=null){
            this.S = new ByteArray();
            if (_arg1){
                this.init(_arg1);
            };
        }
        public function _lj606():uint{
            return (this._mg749);
        }
        public function init(_arg1:ByteArray):void{
            var _local2:int;
            var _local3:int;
            var _local4:int;
            _local2 = 0;
            while (_local2 < 0x0100) {
                this.S[_local2] = _local2;
                _local2++;
            };
            _local3 = 0;
            _local2 = 0;
            while (_local2 < 0x0100) {
                _local3 = (((_local3 + this.S[_local2]) + _arg1[(_local2 % _arg1.length)]) & 0xFF);
                _local4 = this.S[_local2];
                this.S[_local2] = this.S[_local3];
                this.S[_local3] = _local4;
                _local2++;
            };
            this._gb575 = 0;
            this._ih73 = 0;
        }
        public function next():uint{
            var _local1:int;
            this._gb575 = ((this._gb575 + 1) & 0xFF);
            this._ih73 = ((this._ih73 + this.S[this._gb575]) & 0xFF);
            _local1 = this.S[this._gb575];
            this.S[this._gb575] = this.S[this._ih73];
            this.S[this._ih73] = _local1;
            return (this.S[((_local1 + this.S[this._gb575]) & 0xFF)]);
        }
        public function _pl701():uint{
            return (1);
        }
        public function _op40(_arg1:ByteArray):void{
            var _local2:uint;
            while (_local2 < _arg1.length) {
                var _temp1 = _local2;
                _local2 = (_local2 + 1);
                var _local3 = _temp1;
                _arg1[_local3] = (_arg1[_local3] ^ this.next());
            };
        }
        public function unpack(_arg1:ByteArray):void{
            this._op40(_arg1);
        }
        public function dispose():void{
            var _local1:uint;
            if (this.S != null){
                _local1 = 0;
                while (_local1 < this.S.length) {
                    this.S[_local1] = (Math.random() * 0x0100);
                    _local1++;
                };
                this.S.length = 0;
                this.S = null;
            };
            this._gb575 = 0;
            this._ih73 = 0;
            _cr359.gc();
        }
        public function toString():String{
            return (irrcrpt("vg8", 4));
        }

    }
}