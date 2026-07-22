if (whiteFlash)
    image_index = 2;

if (!whiteFlash)
    draw_sprite_ext(spriteIndex, image_index, x + cx, y + cy, 0.1 * xShrink * baseSize * xDirection, 0.1 * yShrink * baseSize * yDirection, imageAngle * xDirection, c_white, 1);

if (bubbleState == "idle")
{
    jumpTimesOrbSprite = sJumpCounts00;
    draw_sprite_ext(jumpTimesOrbSprite, 0, x + cx, y + cy, 0.1, 0.1, imageAngle * xDirection, c_white, 1);
}
