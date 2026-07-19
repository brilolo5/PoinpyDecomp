function playSfxUI()
{
    var _asset = argument[0];
    var _loop = (argument_count > 1 && argument[1] != undefined) ? argument[1] : false;
    var _singleton = (argument_count > 2 && argument[2] != undefined) ? argument[2] : true;
    
    if (_singleton)
        audioSystemStopAsset(_asset);
    
    var _struct = new __audioClassSound(_asset, _loop);
    _struct.world = false;
    _struct.tick(false);
    return _struct.audioId;
}
