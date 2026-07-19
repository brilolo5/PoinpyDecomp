bottomLimit = bbox_bottom;
topLimit = bbox_top;
focusPointV = y;

function parseCameraData()
{
    var target = instance_position(x, y, oCameraActivateArea);
    
    if (target)
    {
        if (image_yscale == 1)
        {
            target.bottomLimit = -1;
            target.topLimit = -1;
            target.focusPointV = focusPointV;
        }
        else
        {
            target.bottomLimit = bottomLimit;
            target.topLimit = topLimit;
        }
        
        return true;
    }
    else
    {
        return false;
    }
}

if (!parseCameraData())
    alarm[0] = 1;
