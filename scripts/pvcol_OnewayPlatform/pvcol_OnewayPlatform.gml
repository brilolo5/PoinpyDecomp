function pvcol_OnewayPlatform()
{
    var _target = instance_place(x, y + 1, oOnewayPlatform);
    
    if (_target)
    {
        if (!place_meeting(x, y, _target))
        {
            if (ysp >= 0)
            {
                if (_target.object_index == oBouncySwitch || _target.object_index == oBouncySwitch_gacha || _target.object_index == oBeastInLobby)
                {
                    if (oPlayer.currentState != "ground" && oPlayer.currentState != "ground - asleep")
                    {
                        _target.ysp = clamp(ysp, -5, 5);
                        _target.xsp = 0;
                        _target.briefBounce = 1;
                        
                        if (_target.object_index == oBeastInLobby)
                            playSoundBeastBounce();
                    }
                }
                
                ysp = 0;
                return _target;
            }
        }
        else
        {
            return false;
        }
    }
    else
    {
        audioVarLand = 0;
        return false;
    }
}
