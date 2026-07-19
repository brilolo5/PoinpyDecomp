var viewx = getViewx(global.cam);
var viewy = getViewy(global.cam);
image_index += (0.08333333333333333 * global.timeScale);
var _centerx = viewx + (global.viewWidth / 2);
var _magmaPartScale = global.viewWidth / 2 / sprite_get_width(sMagmaHead);
var _magmaHeady = y + 8;
var _magmaHeadUndery = _magmaHeady + 16 + 4;
var _magmaScrollLength = 80;
var _magmaBottom = y + _magmaScrollLength;
var _magmaTop = y + 16;
var _magmaScroll = -global.timeScaledTime % _magmaScrollLength;
var _magmaRatio = ((abs(_magmaScroll + _magmaScrollLength) / _magmaScrollLength) * 0.3) + 0.7;
var _magmaBodyPartCount = 4;
var _magmaSeparationy = _magmaScrollLength / _magmaBodyPartCount;
magmaCol[0] = 65535;
magmaCol[1] = 4235519;
magmaCol[2] = 255;
magmaCol[3] = 4235519;
texture_set_interpolation(false);
var _scrollSpeed = (global.timeScale * 1) / 240;

for (var _i = 0; _i < magmaBodyCount; _i += 1)
    magmaBodyGrid[# UnknownEnum.Value_0, _i] = (magmaBodyGrid[# UnknownEnum.Value_0, _i] + _scrollSpeed) % 1;

ds_grid_sort(magmaBodyGrid, UnknownEnum.Value_0, true);

for (var _i = 0; _i < magmaBodyCount; _i += 1)
{
    var _magmaCol = magmaBodyGrid[# UnknownEnum.Value_1, _i];
    var _magmaHeight = (1 - magmaBodyGrid[# UnknownEnum.Value_0, _i]) * 7;
    draw_sprite_ext(sMagmaBody, 0, _centerx, _magmaTop, _magmaPartScale * 2.1, _magmaPartScale * _magmaHeight, 0, _magmaCol, 1);
}

var _magmaSidex = _centerx + (global.viewWidth / 2) + 2;
draw_sprite_ext(sMagmaSide, 0, _magmaSidex, _magmaHeady + 16 + 16, 0.1, 6.4, 0, c_white, 1);
draw_sprite_ext(sMagmaSideTop, 0, _magmaSidex, _magmaHeady + 16 + 4, 0.1, 0.1, 0, c_white, 1);
_magmaSidex = _centerx - (global.viewWidth / 2) - 2;
draw_sprite_ext(sMagmaSide, 0, _magmaSidex, _magmaHeady + 16 + 16, -0.1, 6.4, 0, c_white, 1);
draw_sprite_ext(sMagmaSideTop, 0, _magmaSidex, _magmaHeady + 16 + 4, -0.1, 0.1, 0, c_white, 1);
draw_sprite_ext(sMagmaHeadUnder, 0, _centerx, _magmaHeadUndery, _magmaPartScale * 1, _magmaPartScale, 0, c_white, 1);
draw_sprite_ext(sMagmaHeadUnder, 0, _centerx, _magmaHeadUndery, _magmaPartScale * -1, _magmaPartScale, 0, c_white, 1);
_centerx = viewx + (global.viewWidth / 2);
_magmaPartScale = global.viewWidth / 2 / sprite_get_width(sMagmaHead);
draw_sprite_ext(sMagmaHead, 0, _centerx, _magmaHeady, _magmaPartScale * 1, _magmaPartScale, 0, c_white, 1);
draw_sprite_ext(sMagmaHead, 0, _centerx, _magmaHeady, _magmaPartScale * -1, _magmaPartScale, 0, c_white, 1);
var _flowIndex = global.timeScaledTime / 8;
draw_sprite_ext(sMagmaHeadFlow, _flowIndex, _centerx, _magmaHeady, _magmaPartScale * 2, _magmaPartScale * 2, 0, c_white, 1);
draw_sprite_ext(sMagmaHeadFlow, _flowIndex + 3, _centerx, _magmaHeady, _magmaPartScale * -1 * 2, _magmaPartScale * 2, 0, c_white, 1);
texture_set_interpolation(true);
magmaParticleSpawnTimer += (global.timeScale / 6);

if (magmaParticleSpawnTimer > 1)
{
    magmaParticleSpawnTimer -= 1;
    var _widthCut = 96;
    var _flarePosx = lerp(bbox_left + _widthCut, bbox_right - _widthCut, (sin(global.timeScaledTime * 16541) + 1) / 2);
    generateEffect(_flarePosx, bbox_top, "magma flare", 90 + random_range(-45, 45));
}
