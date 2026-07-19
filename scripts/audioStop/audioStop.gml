function audioStop(arg0)
{
    if (arg0 == undefined || arg0 < 0)
        exit;
    
    var _existingStruct = global.__audioSoundMap[? arg0];
    
    if (is_struct(_existingStruct))
        _existingStruct.stop();
}
