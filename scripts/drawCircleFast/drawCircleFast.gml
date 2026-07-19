function drawCircleFast(arg0, arg1, arg2, arg3, arg4)
{
    if (gpu_get_tex_filter())
    {
        gpu_set_tex_filter(false);
        draw_sprite_stretched_ext(sUI320circle, 0, arg0 - arg2, arg1 - arg2, 2 * arg2, 2 * arg2, arg3, arg4);
        gpu_set_tex_filter(true);
    }
    else
    {
        draw_sprite_stretched_ext(sUI320circle, 0, arg0 - arg2, arg1 - arg2, 2 * arg2, 2 * arg2, arg3, arg4);
    }
}
