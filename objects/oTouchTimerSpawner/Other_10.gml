if (crackFlash)
{
    shader_set_track(shaderWhiteFlash);
    crackFlash -= global.timeScale;
}

if (!cracked)
{
    draw_self();
}
else
{
    draw_sprite(sEnPot, 1, x, y);
    draw_sprite(sEnPot, 2, x, y);
}

shader_reset_track();
