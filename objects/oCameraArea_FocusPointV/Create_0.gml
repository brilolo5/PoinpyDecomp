focusPointV = y;

function parseCameraData()
{
    instance_activate_object(oCameraActivateArea);
    var target = instance_position(x, y, oCameraActivateArea);
    
    if (target)
        target.focusPointV = focusPointV;
    else
        alarm[0] = 1;
}

parseCameraData();
