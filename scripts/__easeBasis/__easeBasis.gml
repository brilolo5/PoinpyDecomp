__curveDevOutput([easeQuad, easeCubic, easeQuart, easeQuint, easeSine, easeExpo, easeCirc, easeBack, easeElastic, easeBounce], 101, 0);
__curveDevOutput([easeQuad, easeCubic, easeQuart, easeQuint, easeSine, easeExpo, easeCirc, easeBack, easeElastic, easeBounce], 101, 1);
__curveDevOutput([easeQuad, easeCubic, easeQuart, easeQuint, easeSine, easeExpo, easeCirc, easeBack, easeElastic, easeBounce], 101, 2);

function easeQuad(arg0)
{
    return arg0 * arg0;
}

function easeCubic(arg0)
{
    return arg0 * arg0 * arg0;
}

function easeQuart(arg0)
{
    return arg0 * arg0 * arg0 * arg0;
}

function easeQuint(arg0)
{
    return arg0 * arg0 * arg0 * arg0 * arg0;
}

function easeSine(arg0)
{
    return 1 - cos(0.5 * (arg0 * pi));
}

function easeExpo(arg0)
{
    if (arg0 == 0)
        return 0;
    
    return power(2, (10 * arg0) - 10);
}

function easeCirc(arg0)
{
    return 1 - sqrt(1 - (arg0 * arg0));
}

function easeBack(arg0)
{
    var param = 1.70158;
    return arg0 * arg0 * (((param + 1) * arg0) - param);
}

function easeElastic(arg0)
{
    if (arg0 == 0)
        return 0;
    
    if (arg0 == 1)
        return 1;
    
    return -power(2, (10 * arg0) - 10) * sin((((arg0 * 10) - 10.75) * (2 * pi)) / 3);
}

function easeBounce(arg0)
{
    var n1 = 7.5625;
    var d1 = 2.75;
    arg0 = 1 - arg0;
    
    if (arg0 < (1 / d1))
    {
        return 1 - (n1 * arg0 * arg0);
    }
    else if (arg0 < (2 / d1))
    {
        arg0 -= (1.5 / d1);
        return 1 - ((n1 * arg0 * arg0) + 0.75);
    }
    else if (arg0 < (2.5 / d1))
    {
        arg0 -= (2.25 / d1);
        return 1 - ((n1 * arg0 * arg0) + 0.9375);
    }
    else
    {
        arg0 -= (2.625 / d1);
        return 1 - ((n1 * arg0 * arg0) + 0.984375);
    }
}

function __curveDevOutput(arg0, arg1, arg2)
{
    if (arg1 < 2)
        throw "Need 2 or more points";
    
    var _copy_paste_string = "";
    var _i = 0;
    
    repeat (array_length(arg0))
    {
        var _func = arg0[_i];
        
        switch (arg2)
        {
            case 0:
                _name = script_get_name(_func);
                break;
            
            case 1:
                _name = script_get_name(_func) + "Inv";
                break;
            
            case 2:
                _name = script_get_name(_func) + "InOut";
                break;
        }
        
        var _name = string_replace_all(_name, "ease", "curve");
        var _buffer = buffer_create(1, buffer_grow, 1);
        buffer_write(_buffer, buffer_text, "{\n");
        buffer_write(_buffer, buffer_text, "  \"function\": 0,\n");
        buffer_write(_buffer, buffer_text, "  \"channels\": [\n");
        buffer_write(_buffer, buffer_text, "    {\"colour\":4290799884,\"visible\":true,\"points\":[\n");
        var _t = 0;
        
        repeat (arg1)
        {
            var _value;
            
            switch (arg2)
            {
                case 0:
                    _value = _func(_t);
                    break;
                
                case 1:
                    _value = 1 - _func(1 - _t);
                    break;
                
                case 2:
                    _value = (_t < 0.5) ? ((1 - _func(1 - (2 * _t))) / 2) : ((1 + _func((2 * _t) - 1)) / 2);
                    break;
            }
            
            buffer_write(_buffer, buffer_text, "        {\"th0\":0.0,\"th1\":0.0,\"tv0\":0.0,\"tv1\":0.0,\"x\":" + string_format(_t, 0, 10) + ",\"y\":" + string_format(_value, 0, 10) + "},\n");
            _t += (1 / arg1);
        }
        
        buffer_write(_buffer, buffer_text, "        {\"th0\":0.0,\"th1\":0.0,\"tv0\":0.0,\"tv1\":0.0,\"x\":1.0,\"y\":1.0,},\n");
        buffer_write(_buffer, buffer_text, "      ],\"resourceVersion\":\"1.0\",\"name\":\"curve1\",\"tags\":[],\"resourceType\":\"GMAnimCurveChannel\",},\n");
        buffer_write(_buffer, buffer_text, "  ],\n");
        buffer_write(_buffer, buffer_text, "  \"parent\": {\n");
        buffer_write(_buffer, buffer_text, "    \"name\": \"Animation Curves\",\n");
        buffer_write(_buffer, buffer_text, "    \"path\": \"folders/Animation Curves.yy\",\n");
        buffer_write(_buffer, buffer_text, "  },\n");
        buffer_write(_buffer, buffer_text, "  \"resourceVersion\": \"1.2\",\n");
        buffer_write(_buffer, buffer_text, "  \"name\": \"" + _name + "\",\n");
        buffer_write(_buffer, buffer_text, "  \"tags\": [],\n");
        buffer_write(_buffer, buffer_text, "  \"resourceType\": \"GMAnimCurve\",\n");
        buffer_write(_buffer, buffer_text, "}");
        buffer_save(_buffer, _name + ".yy");
        buffer_delete(_buffer);
        _copy_paste_string += ("\n    {\"id\":{\"name\":\"" + _name + "\",\"path\":\"animcurves/" + _name + ".yy\",},\"order\":0,},");
        _i++;
    }
}
