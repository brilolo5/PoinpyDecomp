function diagboxCreate()
{
    return new __diagboxClass();
}

function __diagboxClass() constructor
{
    static snapToTargetPos = function()
    {
        if (text != __oldText)
            tick();
        
        calculateTargetPosition();
        boxX = boxTargetX;
        boxY = boxTargetY;
        calculateBoxBounds();
        calculateKnobPosition();
    };
    
    static textFadeOut = function()
    {
        if (textElement.get_typewriter_state() == 1)
            textElement.typewriter_out(0, 0).typewriter_skip();
    };
    
    static textSkip = function()
    {
        textElement.typewriter_in(3, 0);
        show_debug_message("AA");
    };
    
    static tick = function()
    {
        if (text != __oldText)
        {
            __oldText = text;
            textElement = scribble(text).starting_format(global.defaultFont, make_color_rgb(46, 50, 59)).align(0, 1).typewriter_reset().typewriter_in(0, 20).typewriter_ease(UnknownEnum.Value_4, 0, -2, 1, 1.1, 0, 0.05).typewriter_sound(speakSoundArray, 120, 1.2, 1.4);
            
            if (textElement.get_typewriter_state() < 1)
            {
                if ((abs(boxWidth - boxTargetWidth) + abs(boxHeight - boxTargetHeight)) < 4)
                {
                    var _typeInSpeed = 0.65;
                    
                    if (locIsAsian())
                        _typeInSpeed = 0.4;
                    
                    textElement.typewriter_in(_typeInSpeed, 20);
                }
            }
        }
        
        var _max_width = min(textMaxWidth, boxLimitRight - boxLimitLeft);
        textElement.transform(textScaling, textScaling, 0).wrap(_max_width / textScaling, -1, locIsAsian());
        
        if (textElement.get_typewriter_state() == 1 && !forceLerpTween)
            posLerpRate = 1;
        
        calculateTargetSize();
        tickSizeTween();
        calculateTargetPosition();
        tickPositionTween();
        calculateBoxBounds();
        calculateKnobPosition();
    };
    
    static calculateTargetSize = function()
    {
        var _bbox = textElement.get_bbox();
        boxTargetWidth = _bbox.width;
        boxTargetHeight = _bbox.height + 10;
    };
    
    static tickSizeTween = function()
    {
        boxWidth ??= boxTargetWidth;
        
        boxHeight ??= boxTargetHeight;
        
        boxWidth = lerp(boxWidth, boxTargetWidth, 0.19);
        boxHeight = lerp(boxHeight, boxTargetHeight, 0.19);
    };
    
    static calculateTargetPosition = function()
    {
        if (boxMode == "float")
        {
            boxTargetX = knobTargetX + boxFloatXOffset;
            boxTargetY = knobTargetY + boxFloatYOffset;
        }
        else if (boxMode == "lock")
        {
            boxTargetX = boxLockX;
            boxTargetY = boxLockY;
        }
        
        __boxYAlign = (boxTargetY > knobTargetY) ? "below" : "above";
        
        if (boxMode == "float")
        {
            if (__boxYAlign == "above")
                boxTargetY -= (boxTargetHeight / 2);
            
            if (__boxYAlign == "below")
                boxTargetY += (boxTargetHeight / 2);
        }
        
        boxTargetX = clamp(boxTargetX, boxLimitLeft + (0.5 * boxTargetWidth), boxLimitRight - (0.5 * boxTargetWidth));
        boxTargetY = clamp(boxTargetY, boxLimitTop + (0.5 * boxTargetHeight), boxLimitBottom - (0.5 * boxTargetHeight));
    };
    
    static tickPositionTween = function()
    {
        boxX ??= boxTargetX;
        
        boxY ??= boxTargetY;
        
        boxX = lerp(boxX, boxTargetX, posLerpRate);
        boxY = lerp(boxY, boxTargetY, posLerpRate);
    };
    
    static calculateBoxBounds = function()
    {
        boxLeft = boxX - (boxWidth / 2);
        boxTop = boxY - (boxHeight / 2);
        boxRight = boxX + (boxWidth / 2);
        boxBottom = boxY + (boxHeight / 2);
    };
    
    static calculateKnobPosition = function()
    {
        knobX = knobTargetX;
        knobY = knobTargetY;
        var _knobJoinWidth = knobJoinRightOffset - knobJoinLeftOffset;
        __knobJoinLeft = clamp(knobX + knobJoinLeftOffset, boxLeft, boxRight - _knobJoinWidth);
        __knobJoinRight = __knobJoinLeft + _knobJoinWidth;
        __knobJoinY = (__boxYAlign == "above") ? boxBottom : boxTop;
    };
    
    static draw = function(arg0)
    {
        var _outline_thickness = 1;
        var _knob_outline_thickness = 1;
        
        if (text != __oldText)
            tick();
        
        if (knobShow)
        {
            var _knob_base_x = (__knobJoinLeft + __knobJoinRight) / 2;
            var _knob_base_y = __knobJoinY;
            var _dx = knobX - _knob_base_x;
            var _dy = knobY - _knob_base_y;
            var _d = sqrt((_dx * _dx) + (_dy * _dy));
            _dx /= _d;
            _dy /= _d;
            var _dir_l = point_direction(knobX, knobY, __knobJoinLeft, _knob_base_y);
            var _dir_r = point_direction(knobX, knobY, __knobJoinRight, _knob_base_y);
            var _dir_delta = angle_difference(_dir_l, _dir_r);
            var _distance = 1 / dsin(_dir_delta / 2);
            _dx *= (_knob_outline_thickness * _distance);
            _dy *= (_knob_outline_thickness * _distance);
            draw_primitive_begin(pr_trianglelist);
            draw_vertex_colour(knobX + _dx, knobY + _dy, make_color_rgb(46, 50, 59), 1);
            draw_vertex_colour(__knobJoinLeft - _outline_thickness, _knob_base_y, make_color_rgb(46, 50, 59), 1);
            draw_vertex_colour(__knobJoinRight + _outline_thickness, _knob_base_y, make_color_rgb(46, 50, 59), 1);
            draw_primitive_end();
        }
        
        drawPillWithOutline((boxLeft + 2) - (0.5 * boxHeight), boxTop, (boxRight - 2) + (0.5 * boxHeight), boxBottom, make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), _outline_thickness);
        
        if (knobShow)
        {
            draw_primitive_begin(pr_trianglelist);
            draw_vertex(knobX, knobY);
            draw_vertex(__knobJoinLeft, __knobJoinY);
            draw_vertex(__knobJoinRight, __knobJoinY);
            draw_primitive_end();
        }
        
        textElement.draw(boxLeft + 1, (boxTop + boxBottom) / 2);
        
        if (arg0)
        {
            if (textElement.get_typewriter_state() == 1)
            {
                var _x = (boxRight - 5) + (0.25 * boxHeight);
                var _y = boxBottom;
                _x += (2 * (0.5 + (0.5 * dsin(current_time / 6))));
                draw_triangle_colour(_x - 6, _y - 3, _x - 6, _y + 3, _x, _y, make_color_rgb(46, 50, 59), make_color_rgb(46, 50, 59), make_color_rgb(46, 50, 59), false);
            }
        }
    };
    
    text = "";
    textMaxWidth = 500;
    textScaling = 1;
    speakSoundArray[0] = sfx_tutorial_text;
    posLerpRateDefault = 0.28;
    posLerpRate = posLerpRateDefault;
    forceLerpTween = 0;
    knobShow = true;
    knobTargetX = 0;
    knobTargetY = 0;
    boxMode = "float";
    boxFloatXOffset = 0;
    boxFloatYOffset = -20;
    boxLockX = room_width / 2;
    boxLockY = room_height / 2;
    knobJoinLeftOffset = -2;
    knobJoinRightOffset = 2;
    boxLimitLeft = 0;
    boxLimitTop = 0;
    boxLimitRight = room_width;
    boxLimitBottom = room_height;
    __waitForResize = false;
    boxX = undefined;
    boxY = undefined;
    boxLeft = 0;
    boxTop = 0;
    boxRight = 0;
    boxBottom = 0;
    boxWidth = undefined;
    boxHeight = undefined;
    boxTargetWidth = 0;
    boxTargetHeight = 0;
    boxWidth = boxTargetWidth;
    boxHeight = boxTargetHeight;
    __boxYAlign = "above";
    __knobJoinLeft = 0;
    __knobJoinRight = 0;
    __knobJoinY = 0;
    __oldText = undefined;
    textBBox = undefined;
}
