var _scale = 20 * clamp(mouse_x / room_width, 0, 1);
scribble(test_string).transform(_scale, _scale, 0).msdf_border(0, 2).draw(10, 10);
