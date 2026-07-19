focusPointV = bbox_bottom - (global.viewHeight / 2);

function parseCameraData()
{
    instance_activate_object(oCameraActivateArea);
    var target = instance_position(x, bbox_top, oCameraActivateArea);
    
    if (target)
        target.focusPointV = focusPointV;
    else
        alarm[0] = 1;
}

parseCameraData();
