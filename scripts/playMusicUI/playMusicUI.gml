function playMusicUI()
{
    var _asset = argument[0];
    var _loop = (argument_count > 1 && argument[1] != undefined) ? argument[1] : true;
    var _singleton = (argument_count > 2 && argument[2] != undefined) ? argument[2] : true;
    
    if (_singleton)
    {
        var _old = audioGetByAsset(_asset);
        
        if (_old != undefined)
            return _old;
    }
    
    var _struct = new __audioClassSound(_asset, _loop);
    _struct.world = false;
    _struct.isMusic = true;
    _struct.tick(false);
    return _struct.audioId;
}
