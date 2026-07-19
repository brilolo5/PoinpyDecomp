global.__uiWireframeOpacity = 0;
global.__uiWireframeOnly = false;
global.__uiDictionary = ds_map_create();
global.__uiAnonymousIndex = 1;
global.__uiEventStack = [undefined];
global.__uiTickSize = 1;
global.__uiScrollMode = 2;
global.__uiScrollThreshold = (os_type == os_ios || os_type == os_android) ? 6 : 2;
global.__uiScrollTweenSpeed = 15;
global.__uiScrollMouseWheelSpeed = 12;
global.__uiScrollMouseWheelReverse = false;
global.__uiNullElement = new __uiElementClass();

with (global.__uiNullElement)
{
    globalTag = "UI_NULL_ELEMENT";
    tagPath = "UI_NULL_ELEMENT";
    shapeXCenter = 0;
    shapeYCenter = 0;
    shapeLeft = 0;
    shapeTop = 0;
    shapeRight = 0;
    shapeBottom = 0;
    shapeWidth = 0;
    shapeHeight = 0;
}

global.__uiTempX = undefined;
global.__uiTempY = undefined;
global.__uiTempX2 = undefined;
global.__uiTempY2 = undefined;
global.__uiTempMinDist = 999999999;
global.__uiTempOver = global.__uiNullElement;
global.__uiTempPrevOver = global.__uiNullElement;

function __uiTrace()
{
    var _string = "UI: ";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message(_string);
}

function __uiError()
{
    var _string = "UI:\n";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message("ERROR " + string_replace_all(_string, "\n", "\n      "));
}
