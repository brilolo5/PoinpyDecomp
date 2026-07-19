function drawBgVineLight(arg0, arg1, arg2, arg3)
{
    var _xscale = arg2 / 1600;
    var _yscale = arg3 / 3452;
    draw_set_colour(#DFF226);
    draw_primitive_begin(pr_trianglelist);
    draw_vertex(arg0 + (_xscale * 956), arg1);
    draw_vertex(arg0 + (_xscale * 1002), arg1);
    draw_vertex(arg0, arg1 + (_yscale * 2233));
    draw_vertex(arg0 + (_xscale * 1002), arg1);
    draw_vertex(arg0, arg1 + (_yscale * 2233));
    draw_vertex(arg0, arg1 + (_yscale * 3012));
    draw_vertex(arg0 + (_xscale * 1047), arg1);
    draw_vertex(arg0 + (_xscale * 1079), arg1);
    draw_vertex(arg0 + (_xscale * 211), arg1 + (_yscale * 3452));
    draw_vertex(arg0 + (_xscale * 1079), arg1);
    draw_vertex(arg0 + (_xscale * 211), arg1 + (_yscale * 3452));
    draw_vertex(arg0 + (_xscale * 756), arg1 + (_yscale * 3452));
    draw_vertex(arg0 + (_xscale * 1104), arg1);
    draw_vertex(arg0 + (_xscale * 1574), arg1 + (_yscale * 3452));
    draw_vertex(arg0 + (_xscale * 1600), arg1 + (_yscale * 3452));
    draw_vertex(arg0 + (_xscale * 1104), arg1);
    draw_vertex(arg0 + (_xscale * 1150), arg1);
    draw_vertex(arg0 + (_xscale * 1600), arg1 + (_yscale * 3452));
    draw_vertex(arg0 + (_xscale * 1150), arg1);
    draw_vertex(arg0 + (_xscale * 1600), arg1 + (_yscale * 3452));
    draw_vertex(arg0 + (_xscale * 1600), arg1 + (_yscale * 2217));
    draw_primitive_end();
    draw_set_colour(c_white);
}
