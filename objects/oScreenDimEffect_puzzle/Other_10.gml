var _viewx = getViewx(global.cam);
var _viewy = getViewy(global.cam);
draw_set_color(make_color_rgb(46, 50, 59));
drawRectangleFast(_viewx, _viewy, _viewx + global.viewWidth, _viewy + global.viewHeight, make_color_rgb(46, 50, 59), dimAlpha);
draw_set_color(make_color_rgb(255, 255, 255));
killTimer -= doDelta(1);

if (killTimer <= 0)
{
    dimAlpha = approach(dimAlpha, 0, doDelta(dimAlphaGoal / 6));
    
    if (dimAlpha <= 0)
        instance_destroy();
}
else
{
    dimAlpha = approach(dimAlpha, dimAlphaGoal, doDelta(dimAlphaGoal / 6));
}
