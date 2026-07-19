function arrayPathDraw(arg0)
{
    draw_primitive_begin(pr_linestrip);
    var _i = 0;
    
    repeat (array_length(arg0) div 2)
    {
        draw_vertex(arg0[_i], arg0[_i + 1]);
        _i += 2;
    }
    
    draw_primitive_end();
}
