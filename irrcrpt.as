package {

    public function irrcrpt(_arg1:String, _arg2:int):String{
        var _local5:int;
        var _local3:String = new String();
        var _local4:int;
        while (_local4 < _arg1.length) {
            _local5 = _arg1.charCodeAt(_local4);
            if ((((_local5 >= 48)) && ((_local5 <= 57)))){
                _local5 = ((_local5 - _arg2) - 48);
                if (_local5 < 0){
                    _local5 = (_local5 + ((57 - 48) + 1));
                };
                _local5 = ((_local5 % ((57 - 48) + 1)) + 48);
            } else {
                if ((((_local5 >= 65)) && ((_local5 <= 90)))){
                    _local5 = ((_local5 - _arg2) - 65);
                    if (_local5 < 0){
                        _local5 = (_local5 + ((90 - 65) + 1));
                    };
                    _local5 = ((_local5 % ((90 - 65) + 1)) + 65);
                } else {
                    if ((((_local5 >= 97)) && ((_local5 <= 122)))){
                        _local5 = ((_local5 - _arg2) - 97);
                        if (_local5 < 0){
                            _local5 = (_local5 + ((122 - 97) + 1));
                        };
                        _local5 = ((_local5 % ((122 - 97) + 1)) + 97);
                    };
                };
            };
            _local3 = (_local3 + String.fromCharCode(_local5));
            _local4++;
        };
        return (_local3);
    }
}