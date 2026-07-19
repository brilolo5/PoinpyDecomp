bottomLimit = bbox_bottom;

function parseCameraData()
{
    instance_activate_object(oCameraActivateArea);
    var target = instance_position(x, bbox_top, oCameraActivateArea);
    
    if (target)
        target.bottomLimit = bottomLimit;
    else
        alarm[0] = 1;
}

parseCameraData();
