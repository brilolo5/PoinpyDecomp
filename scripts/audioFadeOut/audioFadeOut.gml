function audioFadeOut(arg0, arg1)
{
    audioSetVolumeTarget(arg0, 0, arg1);
    var _struct = __audioGetStruct(arg0);
    
    if (is_struct(_struct))
        _struct.destroyAtZeroVolume = true;
}
