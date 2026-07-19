if (live_call())
    return global.live_result;

var gts = global.timeScale;
timer += ((1 / (60 * sparkleTime)) * gts);

if (timer >= 1)
{
    timer = random(0.5);
    var _randx = random_range(bbox_left, bbox_right);
    var _randy = random_range(bbox_top, bbox_bottom);
    generateEffect(_randx, _randy, "lobby sparkle", sparkleColor);
}
