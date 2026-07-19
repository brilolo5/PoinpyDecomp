global.__locLanguageArray = [];
global.locTagArray = [];
global.__locDatabase = {};
global.__locLanguage = undefined;
global.__locLanguageStruct = {};

function __locTrace()
{
    var _string = "Loc: ";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message(_string);
}
