if (faceState == "glug receive" || faceState == "end glug receive" || faceState == "magma glug receive")
{
    drawSetInterpolation(false);
    beastFaceSpriteSet(sBeastPart_FaceGlug_Receiving);
    draw_sprite_ext(faceSprite, 1, faceDrawx, faceDrawy, faceXscale, faceYscale, image_angle, c_white, image_alpha);
    draw_sprite_ext(sBeastPart_GlugMouthRect, 0, faceDrawx, faceDrawy + 8, faceXscale * 2, faceYscale * 100, image_angle, c_white, image_alpha);
    drawSetInterpolation(true);
}
