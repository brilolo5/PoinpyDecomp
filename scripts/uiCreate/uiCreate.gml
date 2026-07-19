function uiCreate()
{
    var _tag = (argument_count > 0) ? argument[0] : undefined;
    
    if (_tag == undefined)
    {
        _tag = "anon__" + string(global.__uiAnonymousIndex);
        global.__uiAnonymousIndex++;
    }
    
    var _element = new __uiElementClass();
    __uiElementRegister(_element, _tag);
    _element.globalTag = _tag;
    _element.tagPath = _tag;
    _element.rootTag = _tag;
    
    if (instanceof(self) == "instance")
        _element.rootInstance = id;
    
    return _element;
}
