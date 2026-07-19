var _nextDiscoveryText = "Final challenge at\nGourmet Level [fredoka]20[fredoka][fredoka]\n(1/20)";
var _goalTextColor = 6377541;
var _goalTextBorderSize = 1.75;
var _goalTextSize = 3.6;
var _goalTextPosx = 183.475938409567;
var _bgBoxTop = 35;
scribble(_nextDiscoveryText).starting_format(global.defaultFont, make_color_rgb(255, 255, 255)).blend(_goalTextColor, 1).line_height(10, 26).msdf_border(make_color_rgb(46, 50, 59), _goalTextBorderSize).transform(_goalTextSize / 2, _goalTextSize / 2, 0).align(0, 1).draw(_goalTextPosx, _bgBoxTop + 11);
