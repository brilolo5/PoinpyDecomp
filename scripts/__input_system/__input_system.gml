global.__input_debug_log = "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt";
__input_trace("Welcome to Input by @jujuadams and @offalynne! This is version ", "3.2.2.pre000", ", ", "2020-02-06");
global.__input_frame = 0;
global.__input_mouse_x = 0;
global.__input_mouse_y = 0;
global.__input_mouse_moved = false;
global.__input_cursor_verb_u = undefined;
global.__input_cursor_verb_d = undefined;
global.__input_cursor_verb_l = undefined;
global.__input_cursor_verb_r = undefined;
global.__input_cursor_speed = 0;
global.__input_cursor_using_mouse = true;
global.__input_keyboard_valid = false;
global.__input_mouse_valid = false;
global.__input_gamepad_valid = false;
global.__input_swap_ab = false;
global.__input_history_include = {};
global.__input_source_names = ["none", "keyboard and mouse", "gamepad"];
global.__input_players = array_create(4, undefined);
var _p = 0;

repeat (4)
{
    array_set(global.__input_players, _p, new __input_class_player());
    _p++;
}

global.__input_default_player = new __input_class_player();
global.__input_rebind_last_player = undefined;
global.__input_gamepads = array_create(gamepad_get_device_count(), undefined);
global.__input_sdl2_database = 
{
    array: [],
    by_vendor_product: {},
    by_platform: {}
};
global.__input_sdl2_look_up_table = 
{
    a: 32769,
    b: 32770,
    x: 32771,
    y: 32772,
    dpup: 32781,
    dpdown: 32782,
    dpleft: 32783,
    dpright: 32784,
    leftx: 32785,
    lefty: 32786,
    rightx: 32787,
    righty: 32788,
    leftshoulder: 32773,
    rightshoulder: 32774,
    lefttrigger: 32775,
    righttrigger: 32776,
    leftstick: 32779,
    rightstick: 32780,
    start: 32778,
    back: 32777
};

if (file_exists("gamecontrollerdb.txt"))
    __input_load_sdl2_from_file("gamecontrollerdb.txt");
else
    __input_trace("Warning! \"", "gamecontrollerdb.txt", "\" not found in Included Files");

var _external_string = environment_get_variable("SDL_GAMECONTROLLERCONFIG");

if (_external_string != "")
{
    __input_trace("External SDL2 string found");
    
    try
    {
        __input_load_sdl2_from_string(_external_string);
    }
    catch (_error)
    {
        __input_trace_loud("Error!\n\n%SDL_GAMECONTROLLERCONFIG% could not be parsed.\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, clear %SDL_GAMECONTROLLERCONFIG%\n\nInput ", "3.2.2.pre000", "   @jujuadams ", "2020-02-06");
    }
}

global.__input_type_dictionary = 
{
    none: "xb360"
};

if (file_exists("controllertypes.csv"))
    __input_load_type_csv("controllertypes.csv");
else
    __input_trace("Warning! \"", "controllertypes.csv", "\" not found in Included Files");

global.__input_blacklist_dictionary = {};

if (file_exists("controllerblacklist.csv"))
    __input_load_blacklist_csv("controllerblacklist.csv");
else
    __input_trace("Warning! \"", "controllerblacklist.csv", "\" not found in Included Files");

function __input_binding_duplicate(arg0)
{
    with (arg0)
        return new __input_class_binding(type, value, axis_negative);
}

function __input_binding_overwrite(arg0, arg1)
{
    with (arg1)
    {
        type = arg0.type;
        value = arg0.value;
        axis_negative = arg0.axis_negative;
    }
    
    return arg1;
}

function __input_source_is_available()
{
    var _source = argument[0];
    var _gamepad = (argument_count > 1 && argument[1] != undefined) ? argument[1] : -1;
    
    switch (_source)
    {
        case UnknownEnum.Value_0:
            return true;
            break;
        
        case UnknownEnum.Value_2:
            if (!global.__input_gamepad_valid)
                return false;
            
            if (_gamepad == -1)
                return true;
            
            var _p = 0;
            
            repeat (4)
            {
                if (global.__input_players[_p].source == UnknownEnum.Value_2 && global.__input_players[_p].gamepad == _gamepad)
                    return false;
                
                _p++;
            }
            
            break;
        
        case UnknownEnum.Value_1:
            if (!global.__input_keyboard_valid && !global.__input_mouse_valid)
                return false;
            
            var _p = 0;
            
            repeat (4)
            {
                if (global.__input_players[_p].source == UnknownEnum.Value_1)
                    return false;
                
                _p++;
            }
            
            break;
    }
    
    return true;
}

function __input_gamepad_guid_parse(arg0, arg1)
{
    var _vendor = "";
    var _product = "";
    
    if (arg1)
    {
        _vendor = string_copy(arg0, 1, 4);
        _product = string_copy(arg0, 5, 4);
    }
    else
    {
        _vendor = string_copy(arg0, 9, 4);
        _product = string_copy(arg0, 17, 4);
    }
    
    return 
    {
        vendor: _vendor,
        product: _product
    };
}

function __input_trace()
{
    var _string = "";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message("Input: " + _string);
}

function __input_trace_loud()
{
    var _string = "";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message("Input: LOUD " + _string);
    show_message(_string);
}

function __input_error()
{
    var _string = "";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_error("Input:\n" + _string + "\n ", false);
}

function __input_get_time()
{
    return global.__input_frame;
}
