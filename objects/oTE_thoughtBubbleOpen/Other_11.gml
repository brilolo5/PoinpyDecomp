delay -= 1;

if (delay <= 0)
{
    if (!openSound)
    {
        openSound = 1;
        playSoundStartupTransition();
    }
    
    seqTimer += doDelta(0.011111111111111112);
}

var _cloudCenterx = global.windowCenterx;
var _cloudMiddley = global.windowMiddley;
var _cloudScale = seqTimer * 3;
var _cloudWidth = sprite_get_width(sUItestThoughtCloud) * _cloudScale;
var _cloudHeight = sprite_get_height(sUItestThoughtCloud) * _cloudScale;
var _cloudLeft = _cloudCenterx - (_cloudWidth / 2);
var _cloudRight = _cloudCenterx + (_cloudWidth / 2);
var _cloudTop = _cloudMiddley - (_cloudHeight / 2);
var _cloudBottom = _cloudMiddley + (_cloudHeight / 2);
var _windowRight = window_get_width();
var _windowBottom = window_get_height();
draw_set_color(c_black);
draw_rectangle(0, 0, _cloudLeft, _windowBottom, 0);
draw_rectangle(_cloudRight, 0, _windowRight, _windowBottom, 0);
draw_rectangle(0, 0, _windowRight, _cloudTop, 0);
draw_rectangle(0, _cloudBottom, _windowRight, _windowBottom, 0);
draw_sprite_ext(sUItestThoughtCloud, 1, _cloudCenterx, _cloudMiddley, _cloudScale, _cloudScale, 0, c_white, 1);

if (seqTimer >= 1)
{
    if (room == rmPlayableMainMenu)
        playLobbyMusic();
    
    instance_destroy();
}
