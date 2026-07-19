playSoundAbilityFruitOffering();
sprite_index = sUIheart;
sprite_index = sItem_juice_resurrection;
sprite_index = sItem_endless_mode;

if (instance_exists(oPlayer))
{
    x = oPlayer.x;
    y = oPlayer.y;
}

cx = 0;
cy = 0;
xscale = 0.1;
yscale = 0.1;
baseScale = 1;
imageAngle = 0;
imageIndex = 0;
imageAlpha = 1;
timer = 0;
