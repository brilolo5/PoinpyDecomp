function uiDebugTree()
{
    var _element = argument[0];
    var _variable_array = (argument_count > 1 && is_array(argument[1])) ? argument[1] : [];
    global.__uiDebugTreePrefix = "";
    _element.__debugTree(true, _variable_array);
}
