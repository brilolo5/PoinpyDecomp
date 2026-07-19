if (pressed)
{
    image_index = clamp(image_index, 1, 10);
    pressed = approach(pressed, image_number - 1, 0.3 * global.timeScale);
}

draw_sprite_ext(sBlueSwitch, pressed, x + cx, y + cy, 0.1, 0.1, image_angle, c_white, image_alpha);
