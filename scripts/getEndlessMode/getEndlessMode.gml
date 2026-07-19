function getEndlessMode()
{
    var _mode = -1;
    
    switch (getMaxJump())
    {
        case 10:
            _mode = UnknownEnum.Value_0;
            break;
        
        case 8:
            _mode = UnknownEnum.Value_1;
            break;
        
        case 6:
            _mode = UnknownEnum.Value_2;
            break;
        
        case 4:
            _mode = UnknownEnum.Value_3;
            break;
        
        case 2:
            _mode = UnknownEnum.Value_4;
            break;
        
        default:
            _mode = -1;
    }
    
    return _mode;
}
