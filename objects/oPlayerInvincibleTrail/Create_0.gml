_invincibleJumpSound = playSoundPlayerInvincibleSpinStart();
startFading = 0;
x = oPlayer.x;
y = oPlayer.y;
trailAmount = 12;
killTimer = 180;
timeStep = 0;

for (var i = 0; i < trailAmount; i += 1)
{
    trailArray[i][UnknownEnum.Value_0] = oPlayer.x;
    trailArray[i][UnknownEnum.Value_1] = oPlayer.y;
    trailArray[i][UnknownEnum.Value_2] = oPlayer.sprite_index;
    trailArray[i][UnknownEnum.Value_3] = oPlayer.image_index;
    trailArray[i][UnknownEnum.Value_4] = oPlayer.xDirection;
}

_uniColor = shader_get_uniform(shColorOver, "u_color");
var _col = make_color_rgb(255, 255, 255);
_color = [color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255, 1];
