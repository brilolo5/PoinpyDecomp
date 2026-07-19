function checkOnewayPlatform()
{
    if (ysp >= 0)
    {
        if (place_meeting(x, y + 1, oOnewayPlatform) && !place_meeting(x, y, oOnewayPlatform))
            return instance_place(x, y + 1, oOnewayPlatform);
    }
}
