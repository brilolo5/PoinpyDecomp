var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = -10;
var _drawy = y + 1;

if (global.endingReached >= UnknownEnum.Value_2)
{
    imageIndex += (0.08333333333333333 * global.timeScale);
    draw_sprite_ext(anemoneSprite, imageIndex, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);
}
else
{
    draw_sprite_ext(sLobbyAnemone_baby, imageIndex, x, _drawy, -0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);
}

draw_sprite_ext(baseSprite, imageIndex, x, _drawy, 0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);
