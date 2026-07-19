function juicerRankTotal(arg0)
{
    var _total = 0;
    var _i = 0;
    
    repeat (min(arg0, global.juicerRankMax))
    {
        _total += global.juicerRankUpThreshold[_i];
        _i++;
    }
    
    return _total;
}
