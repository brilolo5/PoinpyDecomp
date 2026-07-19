var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = -10;
var _drawy = y;
var _checkMbHeld = (oPlayer.mbHeld && oPlayer.slingLength >= 2) ? 1 : 0;

if (_checkMbHeld)
{
    audioVarCannonTail = 0;
    cannonAuraRadius = lerp(cannonAuraRadius, 18 + (sin(global.time / 16) * 1), 0.7);
}
else
{
    audioVarCannon = 0;
    
    if (audioVarCannonTail == 0)
    {
        playSoundCannonTail();
        audioVarCannonTail = 1;
    }
    
    audioSystemStopAsset(sfx_cannon_rotate_head);
    audioSystemStopAsset(sfx_cannon_rotate_lp);
    cannonAuraRadius = lerp(cannonAuraRadius, 10, 0.5);
}

draw_set_color(make_color_rgb(255, 255, 255));
draw_set_alpha(0.75);
draw_circle(x, y, cannonAuraRadius, 0);
draw_circle(x, y, cannonAuraRadius - 2, 0);
draw_set_alpha(1);
var _angDif = angle_difference(cannonAngle, global.cannonAngleGoal) * 0.5;
cannonAngle -= _angDif;

if (pCannonTempSlingAngle != global.cannonTempSlingAngle)
{
    if (audioVarCannon == 0)
    {
        playSoundCannonRotate();
        audioVarCannon = 1;
    }
    
    pCannonTempSlingAngle = global.cannonTempSlingAngle;
}

var _spr = afterImageIndex;
draw_sprite_ext(spriteIndex, 0, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, cannonTime, c_white, 1);
draw_sprite_ext(_spr, 1, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, cannonAngle, c_white, 1);
draw_sprite_ext(spriteIndex, 1, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, global.cannonTempSlingAngle, c_white, 1);
draw_sprite_ext(spriteIndex, 2, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);

if (cannonUseCount >= 1)
{
    inactive = 1;
    spriteIndex = sCannonParts_gray;
    myRemains = instance_create_depth(x, y, depth, oGimCannonRemains);
    myRemains.cannonAngle = cannonAngle;
    instance_destroy();
}
