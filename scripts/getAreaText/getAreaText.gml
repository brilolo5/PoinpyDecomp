function getAreaText(arg0)
{
    var _txt = -1;
    
    switch (arg0)
    {
        case UnknownEnum.Value_1:
            _txt = "beginner (error)";
            break;
        
        case UnknownEnum.Value_2:
            _txt = loc("area name jungle");
            break;
        
        case UnknownEnum.Value_3:
            _txt = loc("area name aqua");
            break;
        
        case UnknownEnum.Value_4:
            _txt = loc("area name mines");
            break;
        
        case UnknownEnum.Value_5:
            _txt = loc("area name temple");
            break;
        
        case UnknownEnum.Value_6:
            _txt = loc("area name outerspace");
            break;
        
        default:
            _txt = "error!";
            break;
    }
    
    return _txt;
}
