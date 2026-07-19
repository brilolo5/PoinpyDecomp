if (instance_exists(oPlayer))
{
    oPlayer.x = x;
    oPlayer.y = y;
}

with (oCamera)
{
    x = other.x;
    y = other.y;
    camPosx = x;
    camPosy = y;
}

instance_destroy();
