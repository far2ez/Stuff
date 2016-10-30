package com.hurlant.util {
    import flash.net.*;
    import flash.system.*;

    public class _cr359 {

        public static function gc():void{
            try {
                new LocalConnection().connect(irrcrpt("jss", 4));
                new LocalConnection().connect(irrcrpt("gpp", 1));
            } catch(_bb784) {
            };
        }
        public static function get _qk605():uint{
            return (System.totalMemory);
        }

    }
}