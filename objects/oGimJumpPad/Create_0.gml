image_speed = 0;
image_index = choose(0, 1);
imageIndex = 0;

if (padAngle == -1)
    padAngle = choose(0, 1);

if (!atFinalArea())
{
    switch (padAngle)
    {
        case 0:
            padSpriteIndex = sJumpPadHigh;
            break;
        
        case 1:
            padSpriteIndex = sJumpPadLow;
            break;
    }
}
else
{
    switch (padAngle)
    {
        case 0:
            padSpriteIndex = sJumpPadHigh_neon;
            break;
        
        case 1:
            padSpriteIndex = sJumpPadLow_neon;
            break;
    }
}

image_xscale = getHDirectionOnCreate(noFlip, oppositeSide, image_xscale);

drawJumppad = function()
{
    draw_sprite_ext(padSpriteIndex, 1, x, y, 0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);
    draw_sprite_ext(padSpriteIndex, 0, x, y, 0.1 * image_xscale, 0.1 * image_yscale, 0, c_white, 1);
};
