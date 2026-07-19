function uiDestroy(arg0)
{
    var _element = __uiElementFind(arg0);
    
    if (_element == global.__uiNullElement)
    {
        __uiTrace("Element \"", arg0, "\" doesn't exist, it may already have been destroyed");
        return undefined;
    }
    
    _element.__destroy();
}
