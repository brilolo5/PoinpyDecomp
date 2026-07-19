function makeAnimationArrayFromSprite(arg0)
{
    var _spriteInfoStruct = sprite_get_info(arg0);
    var _spriteNumber = sprite_get_number(arg0) - 1;
    var _frameToImageArray = [];
    
    if (!variable_struct_exists(_spriteInfoStruct, "frame_info") || !is_array(_spriteInfoStruct.frame_info))
    {
        var _i = 0;
        
        repeat (_spriteNumber + 1)
        {
            array_set(_frameToImageArray, _i, _i);
            _i++;
        }
    }
    else
    {
        var _frameInfoArray = _spriteInfoStruct.frame_info;
        var _frameNumber = _frameInfoArray[_spriteNumber].frame;
        var __imgIndex = 0;
        
        for (var _frameIndex = 0; _frameIndex <= _frameNumber; _frameIndex += 1)
        {
            if (__imgIndex < _spriteNumber)
            {
                if (_frameIndex >= _frameInfoArray[__imgIndex + 1].frame)
                    __imgIndex += 1;
            }
            
            _frameToImageArray[_frameIndex] = __imgIndex;
        }
    }
    
    return _frameToImageArray;
}

function animFrameToIndex(arg0, arg1)
{
    var _frameNumber = animFrameNumber(arg0);
    var _frameLooped = arg1 % (_frameNumber + 1);
    var _imageIndex = array_get(global.animDataMap[? arg0], _frameLooped);
    return _imageIndex;
}

function animFrameNumber(arg0)
{
    var _spriteInfoStruct = sprite_get_info(arg0);
    var _spriteNumber = sprite_get_number(arg0) - 1;
    var _frameNumber;
    
    if (!variable_struct_exists(_spriteInfoStruct, "frame_info") || !is_array(_spriteInfoStruct.frame_info))
    {
        _frameNumber = _spriteNumber;
    }
    else
    {
        var _frameInfoArray = _spriteInfoStruct.frame_info;
        _frameNumber = _frameInfoArray[_spriteNumber].frame;
    }
    
    return _frameNumber;
}

function atImageIndex(arg0, arg1)
{
    static triggeringAtImageIndex = 0;
    
    var _argCount = argument_count - 1;
    var _trigger = 0;
    
    for (var i = 0; i < _argCount; i += 1)
    {
        if (floor(arg0) == argument[i + 1])
        {
            _trigger = 1;
            break;
        }
    }
    
    var _returnValue = false;
    
    if (_trigger)
    {
        if (!triggeringAtImageIndex)
        {
            _returnValue = true;
            triggeringAtImageIndex = 1;
        }
    }
    else
    {
        triggeringAtImageIndex = 0;
    }
    
    return _returnValue;
}
