var i;
x = oPlayer.x;
y = oPlayer.y;
var _debugForce = 0;
timeStep += global.timeScale;
var _modTime = timeStep % 1;

if (timeStep > _modTime)
{
    if (oPlayer.currentState == "invincible spin jump" || (oPlayer.currentState == "in bubble" && (oPlayer.stateBeforeBubble == "invincible spin jump" || oPlayer.stateBeforeBubble == "slamming - invincible")) || oPlayer.currentState == "slamming - invincible" || _debugForce)
    {
        timeStep = _modTime;
        i = 0;
        array_insert(trailArray, i, array_create(UnknownEnum.Value_5, -1));
        array_set(array_get(trailArray, i), UnknownEnum.Value_0, oPlayer.x);
        array_set(array_get(trailArray, i), UnknownEnum.Value_1, oPlayer.y);
        array_set(array_get(trailArray, i), UnknownEnum.Value_2, oPlayer.sprite_index);
        array_set(array_get(trailArray, i), UnknownEnum.Value_3, oPlayer.image_index);
        array_set(array_get(trailArray, i), UnknownEnum.Value_4, oPlayer.xDirection);
        array_resize(trailArray, trailAmount);
    }
    else
    {
        if (!startFading)
        {
            startFading = 1;
            playSoundPlayerInvincibleSpinStop(_invincibleJumpSound);
        }
        
        trailAmount -= 0.75;
        array_resize(trailArray, trailAmount);
    }
}

colorArray[0] = make_color_rgb(248, 45, 97);
colorArray[1] = make_color_rgb(255, 238, 96);
colorArray[2] = make_color_rgb(254, 66, 113);
colorArray[3] = make_color_rgb(255, 255, 255);
colorArray[4] = make_color_rgb(255, 238, 96);
colorMax = 3;
drawSetInterpolation(false);
shader_set_track(shColorOver);
i = trailAmount - 1;

while (i >= 0)
{
    var _xpos = trailArray[i][UnknownEnum.Value_0];
    var _ypos = trailArray[i][UnknownEnum.Value_1];
    var _spriteIndex = trailArray[i][UnknownEnum.Value_2];
    var _imageIndex = trailArray[i][UnknownEnum.Value_3];
    var _xdir = trailArray[i][UnknownEnum.Value_4];
    var _col = colorArray[((global.time / 1.5) - (i / 3)) % (colorMax + 1)];
    _color = [color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255, 1];
    shader_set_uniform_f_array(_uniColor, _color);
    var _trailScale = 0.08000000000000002;
    draw_sprite_ext(_spriteIndex, _imageIndex, _xpos, _ypos, _xdir * _trailScale, _trailScale, 0, c_white, 1);
    i -= 1;
}

shader_reset_track();
drawSetInterpolation(true);

if (trailAmount <= 0)
    instance_destroy();
