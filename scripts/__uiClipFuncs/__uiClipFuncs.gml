global.__uiClipStack = [[-999999999, -999999999, 999999999, 999999999]];
global.__uiClipShaderUniform = shader_get_uniform(__shdUIClip, "u_vClipWindow");
global.__uiClipUniformCache = [];
var _i = 0;
var _fail = false;

while (!_fail)
{
    try
    {
        var _name = shader_get_name(_i);
        var _uniform = shader_get_uniform(_i, "u_vClipWindow");
        __uiTrace("Found shader \"", _name, "\", u_vClipWindow = ", _uniform);
        array_set(global.__uiClipUniformCache, _i, _uniform);
        _i++;
    }
    catch (_)
    {
        _fail = true;
    }
}

function uiClipGet()
{
    return global.__uiClipStack[array_length(global.__uiClipStack) - 1];
}

function uiShaderSet(arg0)
{
    shader_set_track(arg0);
    uiClipSetInShader(arg0);
}

function uiShaderReset()
{
    shader_set_track(__shdUIClip);
    uiClipSetInShader(__shdUIClip);
}

function uiClipSetInShader()
{
    var _shader = (argument_count > 0 && argument[0] != undefined) ? argument[0] : shader_current();
    
    if (_shader >= 0)
        shader_set_uniform_f_array(global.__uiClipUniformCache[_shader], uiClipGet());
}

function uiClipResetInShader()
{
    var _shader = (argument_count > 0 && argument[0] != undefined) ? argument[0] : shader_current();
    
    if (_shader >= 0)
        shader_set_uniform_f_array(global.__uiClipUniformCache[_shader], global.__uiClipStack[0]);
}

function __uiClipPushInside(arg0, arg1, arg2, arg3)
{
    var _current = uiClipGet();
    var _new = array_create(4, 0);
    array_copy(_new, 0, _current, 0, 4);
    array_set(_new, 0, max(_current[0], arg0));
    array_set(_new, 1, max(_current[1], arg1));
    array_set(_new, 2, min(_current[2], arg2 + 1));
    array_set(_new, 3, min(_current[3], arg3 + 1));
    array_push(global.__uiClipStack, _new);
    uiClipSetInShader(shader_current());
}

function __uiClipPushOutside(arg0, arg1, arg2, arg3)
{
    array_push(global.__uiClipStack, [arg0, arg1, arg2, arg3]);
    uiClipSetInShader(shader_current());
}

function __uiClipPop()
{
    var _length = array_length(global.__uiClipStack);
    
    if (_length == 1)
    {
        __uiTrace("Warning! Can't pop clipping window stack, only one entry remaining");
    }
    else
    {
        array_pop(global.__uiClipStack);
        uiClipSetInShader(shader_current());
    }
}
