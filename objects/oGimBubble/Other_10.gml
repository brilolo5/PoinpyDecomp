if (whiteFlash)
    image_index = 2;

if (!whiteFlash)
    draw_sprite_ext(spriteIndex, image_index, x + cx, y + cy, xscale, yscale, imageAngle * xDirection, c_white, 1);

if (bubbleState == "idle")
{
    jumpTimesOrbSprite = sJumpCounts00;
    var jumpTimesOrbWidth = sprite_get_width(jumpTimesOrbSprite);
    var jumpTimesOrbWidthScale = 0.1;
    draw_sprite_ext(jumpTimesOrbSprite, 0, x + cx, y + cy, jumpTimesOrbWidthScale, jumpTimesOrbWidthScale, imageAngle * xDirection, c_white, 1);
}
