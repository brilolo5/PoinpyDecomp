if (oPlayer.bbox_bottom <= bbox_bottom)
{
    if (!start)
    {
        start = 1;
        screenShake(5, 5);
        sleep(5);
        var _area = instance_place(x, y, oMagmaEmitterActivateArea);
        
        if (_area)
        {
            with (_area)
            {
                while (place_meeting(x, y, oMagmaStreamEmitter))
                {
                    var _target = instance_place(x, y, oMagmaStreamEmitter);
                    _target.alarm[0] = _target.timeBetweenEmit;
                    instance_deactivate_object(_target);
                }
                
                instance_activate_object(oMagmaStreamEmitter);
                instance_destroy();
            }
        }
        
        alarm[1] = 60;
    }
}
