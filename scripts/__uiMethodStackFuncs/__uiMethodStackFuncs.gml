function __uiEventStackPush(arg0)
{
    if (array_length(global.__uiEventStack) > 1000)
        __uiTrace("Warning! UI event stack has grown very large. Check event stack push/pops are balanced (top was \"", __uiEventStackTop(), "\", adding \"", _method_name, "\")");
    
    array_push(global.__uiEventStack, arg0);
}

function __uiEventStackPop()
{
    if (array_length(global.__uiEventStack) <= 1)
    {
        __uiTrace("Warning! UI event stack was fully emptied. Check event stack push/pops are balanced (top was \"", __uiEventStackTop(), "\")");
        array_push(global.__uiEventStack, undefined);
    }
    
    array_pop(global.__uiEventStack);
}

function __uiEventStackTop()
{
    return global.__uiEventStack[array_length(global.__uiEventStack) - 1];
}
