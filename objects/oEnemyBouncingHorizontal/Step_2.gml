cx += (xsp * global.timeScale);
cy += (ysp * global.timeScale);
var xspRound = floor(abs(cx)) * sign(cx);
var yspRound = floor(abs(cy)) * sign(cy);
cx -= xspRound;
cy -= yspRound;

repeat (abs(xspRound))
{
    target = instance_place(x + sign(xspRound), y, parentWall);
    
    if (target == -4)
    {
        x += sign(xspRound);
    }
    else
    {
        xsp *= -1;
        image_xscale = sign(xsp);
        break;
    }
}

repeat (abs(yspRound))
{
    target = instance_place(x, y + sign(yspRound), parentWall);
    
    if (target == -4)
    {
        y += sign(yspRound);
    }
    else
    {
        ysp *= -1;
        break;
    }
    
    y += sign(yspRound);
}
