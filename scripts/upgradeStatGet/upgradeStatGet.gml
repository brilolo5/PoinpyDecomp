function upgradeStatGet()
{
    var _upgradeLevel = argument[0];
    var _upgradeIndex = argument[1];
    var _upgradeStat;
    
    switch (_upgradeIndex)
    {
        case UnknownEnum.Value_1:
            var _statDefault = 2;
            var _statIncrement = 1;
            var _upgradeStatList;
            
            for (var i = 0; i <= 4; i += 1)
                _upgradeStatList[i] = _statDefault + (_statIncrement * i);
            
            _upgradeStat = _upgradeStatList[_upgradeLevel];
            break;
        
        case UnknownEnum.Value_2:
            _statDefault = 30000;
            _statIncrement = 30;
            
            for (var i = 0; i <= 4; i += 1)
                _upgradeStatList[i] = _statDefault + (_statIncrement * i);
            
            _upgradeStat = _upgradeStatList[_upgradeLevel];
            break;
        
        case UnknownEnum.Value_0:
            _statDefault = 2;
            _statIncrement = 1;
            
            for (var i = 0; i <= 4; i += 1)
                _upgradeStatList[i] = _statDefault + (_statIncrement * i);
            
            _upgradeStat = _upgradeStatList[_upgradeLevel];
            break;
    }
    
    return _upgradeStat;
}
