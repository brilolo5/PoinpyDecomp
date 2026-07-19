topLimit = bbox_top;

function parseCameraData()
{
    instance_activate_object(oCameraActivateArea);
    var target = instance_position(x, bbox_bottom, oCameraActivateArea);
    
    if (target)
        target.topLimit = topLimit;
    else
        alarm[0] = 1;
}

parseCameraData();
