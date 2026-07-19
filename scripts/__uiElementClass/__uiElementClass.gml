function __uiElementClass() constructor
{
    static setLTRBToWindow = function()
    {
        setLTRB(global.lastValidWindowLeft, global.lastValidWindowTop, global.lastValidWindowRight, global.lastValidWindowBottom);
    };
    
    static setLTRB = function(arg0, arg1, arg2, arg3)
    {
        setLeft(arg0);
        setTop(arg1);
        setRight(arg2);
        setBottom(arg3);
    };
    
    static setLeft = function(arg0)
    {
        shapeLeft = arg0;
    };
    
    static setTop = function(arg0)
    {
        shapeTop = arg0;
    };
    
    static setRight = function(arg0)
    {
        shapeRight = arg0;
    };
    
    static setBottom = function(arg0)
    {
        shapeBottom = arg0;
    };
    
    static setX = function(arg0)
    {
        shapeXCenter = arg0;
    };
    
    static setY = function(arg0)
    {
        shapeYCenter = arg0;
    };
    
    static setWidth = function(arg0)
    {
        shapeWidth = arg0;
    };
    
    static setHeight = function(arg0)
    {
        shapeHeight = arg0;
    };
    
    static getRawLeft = function()
    {
        return shapeLeft;
    };
    
    static getRawTop = function()
    {
        return shapeTop;
    };
    
    static getRawRight = function()
    {
        return shapeRight;
    };
    
    static getRawBottom = function()
    {
        return shapeBottom;
    };
    
    static getRawX = function()
    {
        return shapeXCenter;
    };
    
    static getRawY = function()
    {
        return shapeYCenter;
    };
    
    static getRawWidth = function()
    {
        return shapeWidth;
    };
    
    static getRawHeight = function()
    {
        return shapeHeight;
    };
    
    static getShapeLeft = function()
    {
        return outShapeLeft;
    };
    
    static getShapeTop = function()
    {
        return outShapeTop;
    };
    
    static getShapeRight = function()
    {
        return outShapeRight;
    };
    
    static getShapeBottom = function()
    {
        return outShapeBottom;
    };
    
    static getShapeX = function()
    {
        return outShapeXCenter;
    };
    
    static getShapeY = function()
    {
        return outShapeYCenter;
    };
    
    static getShapeWidth = function()
    {
        return outShapeWidth;
    };
    
    static getShapeHeight = function()
    {
        return outShapeHeight;
    };
    
    static getDrawLeft = function()
    {
        return outVisLeft;
    };
    
    static getDrawTop = function()
    {
        return outVisTop;
    };
    
    static getDrawRight = function()
    {
        return outVisRight;
    };
    
    static getDrawBottom = function()
    {
        return outVisBottom;
    };
    
    static getDrawX = function()
    {
        return outVisXCenter;
    };
    
    static getDrawY = function()
    {
        return outVisYCenter;
    };
    
    static getDrawWidth = function()
    {
        return outVisWidth;
    };
    
    static getDrawHeight = function()
    {
        return outVisHeight;
    };
    
    static setVisible = function(arg0)
    {
        visDraw = arg0;
    };
    
    static getVisible = function()
    {
        return visDraw;
    };
    
    static setChildrenVisible = function(arg0)
    {
        visDrawChildren = arg0;
    };
    
    static getChildrenVisible = function()
    {
        return visDrawChildren;
    };
    
    static setActive = function(arg0)
    {
        gestureAllow = arg0;
    };
    
    static getActive = function()
    {
        return gestureAllow;
    };
    
    static setChildrenActive = function(arg0)
    {
        gestureChildrenAllow = arg0;
    };
    
    static getChildrenActive = function()
    {
        return gestureChildrenAllow;
    };
    
    static newChild = function()
    {
        var _tag = (argument_count > 0) ? argument[0] : undefined;
        var _group_array = (argument_count > 1) ? argument[1] : undefined;
        var _child_element = uiCreate(_tag);
        var _child_global_tag = _child_element.globalTag;
        var _index = arrayFindIndex(children, _child_global_tag);
        
        if (_index >= 0)
        {
            __uiError("Tag \"", _child_global_tag, "\" already exists in parent \"", tagPath, "\"\n(element=\"", tagPath, "\")");
        }
        else
        {
            array_push(children, _child_global_tag);
            _child_element.parentTag = globalTag;
            _child_element.tagPath = tagPath + "." + _child_global_tag;
            _child_element.rootTag = rootTag;
            _child_element.rootInstance = rootInstance;
            
            if (flowStyle == "list" || flowStyle == "grid" || flowStyle == "wrap")
                __cacheShapeDirty = true;
        }
        
        if (!is_array(_group_array))
            _group_array = [_group_array];
        
        var _i = 0;
        
        repeat (array_length(_group_array))
        {
            var _group_name = _group_array[_i];
            
            if (is_numeric(_group_name) || is_string(_group_name))
            {
                var _root = __uiElementFind(rootTag);
                
                if (_root != global.__uiNullElement)
                {
                    var _array = variable_struct_get(_root.__rootGroupDict, _group_name);
                    
                    if (!is_array(_array))
                    {
                        __uiTrace("Adding group \"", _group_name, "\" to root element \"", rootTag, "\"");
                        _array = [];
                        variable_struct_set(_root.__rootGroupDict, _group_name, _array);
                    }
                    
                    array_push(_array, _child_element.globalTag);
                }
            }
            
            _i++;
        }
        
        return _child_element;
    };
    
    static updateShape = function()
    {
        __updatePosition(false);
        __calculateShape();
        __finalizeShape();
        __calculateVisual();
    };
    
    static updateVisual = function()
    {
        __calculateVisual();
    };
    
    static getParent = function()
    {
        return uiGet(parentTag);
    };
    
    static setFlow = function(arg0, arg1)
    {
        if (arg0 != "list" && arg0 != "grid" && arg0 != "wrap")
            __uiError("Flow style \"", arg0, "\" not supported\n(element=\"", tagPath, "\")");
        
        if (arg1 != "x" && arg1 != "y")
            __uiError("Flow direction \"", arg1, "\" not supported for style \"", arg0, "\"\n(element=\"", tagPath, "\")");
        
        flowStyle = arg0;
        flowDirection = arg1;
    };
    
    static setFlowSpacing = function(arg0, arg1, arg2, arg3, arg4, arg5)
    {
        flowMarginLeft = arg0;
        flowMarginTop = arg1;
        flowMarginRight = arg2;
        flowMarginBottom = arg3;
        flowGutterH = arg4;
        flowGutterV = arg5;
    };
    
    static setFlowAlignment = function(arg0, arg1, arg2, arg3)
    {
        if (arg0 != "left" && arg0 != "centre" && arg0 != "center" && arg0 != "right")
            __uiError("Flow area horizontal alignment \"", arg0, "\" not supported\n(element=\"", tagPath, "\")");
        
        if (arg1 != "top" && arg1 != "middle" && arg1 != "bottom")
            __uiError("Flow area vertical alignment \"", arg1, "\" not supported\n(element=\"", tagPath, "\")");
        
        if (arg2 != "left" && arg2 != "centre" && arg2 != "center" && arg2 != "right")
            __uiError("Flow line horizontal alignment \"", arg2, "\" not supported\n(element=\"", tagPath, "\")");
        
        if (arg3 != "top" && arg3 != "middle" && arg3 != "bottom")
            __uiError("Flow line vertical alignment \"", arg3, "\" not supported\n(element=\"", tagPath, "\")");
        
        flowAreaHAlign = arg0;
        flowAreaVAlign = arg1;
        flowLineHAlign = arg2;
        flowLineVAlign = arg3;
    };
    
    static scrollTo = function()
    {
        var _parent = uiGet(parentTag);
        
        if (_parent != global.__uiNullElement)
        {
            if (_parent.scrollAllow)
            {
                var _targetX = 0.5 * _parent.outFlowWidth;
                var _targetY = 0.5 * _parent.outFlowHeight;
                var _areaL = _parent.outShapeLeft;
                var _areaT = _parent.outShapeTop;
                var _areaR = _parent.outShapeRight;
                var _areaB = _parent.outShapeBottom;
                _areaL += _parent.flowMarginLeft;
                _areaT += _parent.flowMarginTop;
                _areaR -= _parent.flowMarginRight;
                _areaB -= _parent.flowMarginBottom;
                _areaL += (0.5 * outShapeWidth);
                _areaT += (0.5 * outShapeHeight);
                _areaR -= (0.5 * outShapeWidth);
                _areaB -= (0.5 * outShapeHeight);
                _areaL -= _parent.scrollXMaxOffset;
                _areaT -= _parent.scrollYMaxOffset;
                _areaR += _parent.scrollXMinOffset;
                _areaB += _parent.scrollYMinOffset;
                
                if (_areaL < _areaR)
                    _targetX = clamp(outShapeXCenter, _areaL, _areaR) - _parent.outShapeLeft;
                
                if (_areaT < _areaB)
                    _targetY = clamp(outShapeYCenter, _areaT, _areaB) - _parent.outShapeTop;
                
                _parent.scrollTargetX = _targetX - (outShapeXCenter - (_parent.outShapeLeft + _parent.scrollX));
                _parent.scrollTargetY = _targetY - (outShapeYCenter - (_parent.outShapeTop + _parent.scrollY));
            }
        }
    };
    
    static eventAddFunction = function(arg0, arg1)
    {
        array_push(__getEventArray(arg0), arg1);
        
        if (arg0 == UnknownEnum.Value_0)
            __cacheShapeDirty = true;
    };
    
    static eventInsertFunction = function(arg0, arg1, arg2)
    {
        array_insert(__getEventArray(arg0), arg1, arg2);
        
        if (arg0 == UnknownEnum.Value_0)
            __cacheShapeDirty = true;
    };
    
    static eventOverwriteWithFunction = function(arg0, arg1)
    {
        var _array = __getEventArray(arg0);
        array_resize(_array, 0);
        array_push(_array, arg1);
        
        if (arg0 == UnknownEnum.Value_0)
            __cacheShapeDirty = true;
    };
    
    static callEventInChildren = function()
    {
        var _event = (argument_count > 0 && argument[0] != undefined) ? argument[0] : __uiEventStackTop();
        var _i = 0;
        
        repeat (array_length(children))
        {
            __uiElementFind(children[_i]).__callEvent(_event);
            _i++;
        }
        
        return undefined;
    };
    
    static animDefine = function(arg0, arg1)
    {
        if (variable_struct_exists(__animDict, arg0))
            __uiTrace("Warning! Overwriting animation \"", arg0, "\"");
        
        variable_struct_set(__animDict, arg0, method(self, arg1));
    };
    
    static animStart = function()
    {
        var _anim_name = argument[0];
        var _include_children = (argument_count > 1 && argument[1] != undefined) ? argument[1] : true;
        var _animation = undefined;
        
        if (!variable_struct_exists(__animDict, _anim_name))
        {
            __uiTrace("Warning! Animation \"", _anim_name, "\" doesn't exist for element \"", tagPath, "\"");
        }
        else
        {
            _animation = new __uiAnimationClass();
            _animation.name = _anim_name;
            animQueue = [_animation];
            animStartTime = animTime;
            __animTick(false);
        }
        
        if (_include_children)
        {
            var _array = [_animation];
            var _i = 0;
            
            repeat (array_length(children))
            {
                var _child_tag = children[_i];
                var _child = __uiElementFind(_child_tag);
                var _result = _child.animStart(_anim_name, _include_children);
                
                if (_result != undefined)
                    array_push(_array, _result);
                
                _i++;
            }
            
            return _array;
        }
        else
        {
            return _animation;
        }
    };
    
    static animSetData = function(arg0)
    {
        if (array_length(animQueue) > 0)
            animQueue[0].data = arg0;
    };
    
    static animSetCallback = function(arg0)
    {
        if (array_length(animQueue) > 0)
        {
            var _animation = animQueue[0];
            
            if (is_method(_animation.callback))
                __uiError("Animation \"", _animation.name, "\" already has a callback");
            else
                _animation.callback = arg0;
        }
    };
    
    static animEnqueue = function()
    {
        var _anim_name = argument[0];
        var _force = (argument_count > 1 && argument[1] != undefined) ? argument[1] : false;
        var _include_children = (argument_count > 2 && argument[2] != undefined) ? argument[2] : true;
        
        if (!_force && array_length(animQueue) > 0)
        {
            if (animQueue[array_length(animQueue) - 1].name == _anim_name)
            {
                __uiTrace("Warning! Animation \"", _anim_name, "\" is already queued");
                return undefined;
            }
        }
        
        var _animation = undefined;
        
        if (!variable_struct_exists(__animDict, _anim_name))
        {
            __uiTrace("Warning! Animation \"", _anim_name, "\" doesn't exist for element \"", tagPath, "\"");
        }
        else
        {
            _animation = new __uiAnimationClass();
            _animation.name = _anim_name;
            array_push(animQueue, _animation);
            
            if (array_length(animQueue) == 1)
            {
                animStartTime = animTime;
                __animTick(false);
            }
        }
        
        if (_include_children)
        {
            var _array = [_animation];
            var _i = 0;
            
            repeat (array_length(children))
            {
                var _child_tag = children[_i];
                var _child = __uiElementFind(_child_tag);
                var _result = _child.animEnqueue(_anim_name, _force, _include_children);
                
                if (_result != undefined)
                    array_push(_array, _result);
                
                _i++;
            }
            
            return _array;
        }
        else
        {
            return _animation;
        }
    };
    
    static animEnd = function()
    {
        animStartTime = undefined;
        __animTick(false);
    };
    
    static animGet = function()
    {
        return (array_length(animQueue) > 0) ? animQueue[0] : undefined;
    };
    
    static animGetNext = function()
    {
        return (array_length(animQueue) > 1) ? animQueue[1] : undefined;
    };
    
    static animIsFinished = function()
    {
        var _include_children = (argument_count > 0 && argument[0] != undefined) ? argument[0] : true;
        
        if (animGet() != undefined)
            return false;
        
        if (_include_children)
        {
            var _i = 0;
            
            repeat (array_length(children))
            {
                var _child_tag = children[_i];
                var _child = __uiElementFind(_child_tag);
                
                if (!_child.animIsFinished(true))
                    return false;
                
                _i++;
            }
        }
        
        return true;
    };
    
    static __destroy = function()
    {
        __uiElementUnregister(globalTag);
        var _i = 0;
        
        repeat (array_length(children))
        {
            var _child_tag = children[_i];
            var _child = __uiElementFind(_child_tag);
            _child.__destroy();
            _i++;
        }
    };
    
    static __calculateScrollArea = function()
    {
        if (flowStyle == "list")
        {
            if (flowDirection == "x")
            {
                __scrollXMin = min(outShapeWidth - (outFlowAreaWidth + flowMarginLeft + flowMarginRight), 0);
                __scrollXMax = 0;
                __scrollYMin = 0;
                __scrollYMax = 0;
            }
            else if (flowDirection == "y")
            {
                __scrollXMin = 0;
                __scrollXMax = 0;
                __scrollYMin = min(outShapeHeight - (outFlowAreaHeight + flowMarginTop + flowMarginBottom), 0);
                __scrollYMax = 0;
            }
        }
        else if (flowStyle == "grid" || flowStyle == "wrap")
        {
            __scrollXMin = min(outShapeWidth - (outFlowAreaWidth + flowMarginLeft + flowMarginRight), 0);
            __scrollXMax = 0;
            __scrollYMin = min(outShapeHeight - (outFlowAreaHeight + flowMarginTop + flowMarginBottom), 0);
            __scrollYMax = 0;
        }
        else
        {
            __scrollXMin = 0;
            __scrollXMax = 0;
            __scrollYMin = 0;
            __scrollYMax = 0;
        }
        
        __scrollXMin += scrollXMinOffset;
        __scrollXMax += scrollXMaxOffset;
        __scrollYMin += scrollYMinOffset;
        __scrollYMax += scrollYMaxOffset;
        scrollX = clamp(scrollX, __scrollXMin, __scrollXMax);
        scrollY = clamp(scrollY, __scrollYMin, __scrollYMax);
    };
    
    static __debugTree = function(arg0, arg1)
    {
        var _string = global.__uiDebugTreePrefix + "+-- " + globalTag;
        var _length = array_length(arg1);
        
        if (_length > 0)
        {
            var _i = 0;
            
            repeat (_length)
            {
                _string += concat(", ", arg1[_i], " = ", variable_struct_get(self, arg1[_i]));
                _i++;
            }
        }
        
        __uiTrace(_string);
        _length = array_length(children);
        
        if (_length > 0)
        {
            var _old = global.__uiDebugTreePrefix;
            global.__uiDebugTreePrefix += (arg0 ? "   " : "|  ");
            var _i = 0;
            
            repeat (_length - 1)
            {
                __uiElementFind(children[_i]).__debugTree(false, arg1);
                _i++;
            }
            
            __uiElementFind(children[_i]).__debugTree(true, arg1);
            global.__uiDebugTreePrefix = _old;
        }
    };
    
    static __updatePosition = function(arg0)
    {
        __callEvent(UnknownEnum.Value_0);
        
        if (arg0)
        {
            var _i = 0;
            
            repeat (array_length(children))
            {
                __uiElementFind(children[_i]).__updatePosition(true);
                _i++;
            }
        }
    };
    
    static __forEachInGroup = function(arg0, arg1, arg2)
    {
        var _root = __uiElementFind(rootTag);
        
        if (_root == global.__uiNullElement)
        {
            __uiError("Warning! Root element \"", rootTag, "\" not found");
        }
        else
        {
            var _array = variable_struct_get(_root.__rootGroupDict, arg0);
            
            if (!is_array(_array))
            {
                __uiTrace("Warning! Group \"", arg0, "\" not found in root element \"", rootTag, "\"");
            }
            else
            {
                var _i = 0;
                
                repeat (array_length(_array))
                {
                    var _element = __uiElementFind(_array[_i]);
                    
                    if (_element != global.__uiNullElement)
                    {
                        var _method = method(_element, arg1);
                        _method(arg2);
                    }
                    
                    _i++;
                }
            }
        }
    };
    
    static __forEachChild = function(arg0, arg1)
    {
        var _i = 0;
        
        repeat (array_length(children))
        {
            with (__uiElementFind(children[_i]))
                arg0(arg1);
            
            _i++;
        }
    };
    
    static __tick = function()
    {
        scrollTargetX = clamp(scrollTargetX, __scrollXMin, __scrollXMax);
        scrollTargetY = clamp(scrollTargetY, __scrollYMin, __scrollYMax);
        
        switch (global.__uiScrollMode)
        {
            case 0:
                scrollX = scrollTargetX;
                scrollY = scrollTargetY;
                break;
            
            case 1:
                scrollX += clamp(scrollTargetX - scrollX, -scrollSpeed, scrollSpeed);
                scrollY += clamp(scrollTargetY - scrollY, -scrollSpeed, scrollSpeed);
                break;
            
            case 2:
                scrollX = lerp(scrollX, scrollTargetX, 0.02 * scrollSpeed);
                scrollY = lerp(scrollY, scrollTargetY, 0.02 * scrollSpeed);
                break;
            
            default:
                __uiError("Scroll mode ", global.__uiScrollMode, " unsupported");
                break;
        }
        
        scrollX = clamp(scrollX, __scrollXMin, __scrollXMax);
        scrollY = clamp(scrollY, __scrollYMin, __scrollYMax);
        __checkShapeCache();
        
        if (__cacheShapeDirty)
            updateShape();
        
        __callEvent(UnknownEnum.Value_1);
        __uiClipPushInside(outShapeLeft, outShapeTop, outShapeRight, outShapeBottom);
        var _window = uiClipGet();
        outShapeClipLeft = _window[0];
        outShapeClipTop = _window[1];
        outShapeClipRight = _window[2];
        outShapeClipBottom = _window[3];
        
        if (!clipChildrenAllow)
            __uiClipPop();
        
        var _i = 0;
        
        repeat (array_length(children))
        {
            __uiElementFind(children[_i]).__tick();
            _i++;
        }
        
        if (clipChildrenAllow)
            __uiClipPop();
    };
    
    static __draw = function()
    {
        __checkShapeCache();
        
        if (__cacheShapeDirty)
            updateShape();
        
        __animTick(true);
        __checkVisualCache();
        
        if (__cacheVisualDirty)
            updateVisual();
        
        if (visDraw)
        {
            if (!__isEventEmpty(UnknownEnum.Value_2))
            {
                if (!global.__uiWireframeOnly)
                    __callEvent(UnknownEnum.Value_2);
                
                uiShaderReset();
                
                if (global.__uiWireframeOpacity > 0)
                    __drawWireframe();
            }
            else
            {
                __drawWireframe();
            }
        }
        
        if (visDrawChildren && array_length(children) > 0)
        {
            if (clipChildrenAllow)
                __uiClipPushInside(outVisLeft, outVisTop, outVisRight, outVisBottom);
            
            var _i = 0;
            
            repeat (array_length(children))
            {
                __uiElementFind(children[_i]).__draw();
                _i++;
            }
            
            if (clipChildrenAllow)
                __uiClipPop();
        }
        
        if (visDraw)
        {
            if (!global.__uiWireframeOnly)
                __callEvent(UnknownEnum.Value_3);
        }
    };
    
    static __drawWireframe = function()
    {
        drawRectangleOutlineFast(outShapeLeft, outShapeTop, outShapeRight, outShapeBottom, visBlend, global.__uiWireframeOpacity * visAlpha, 1);
        drawRectangleFast(outVisLeft, outVisTop, outVisRight, outVisBottom, visBlend, global.__uiWireframeOpacity * visAlpha);
    };
    
    static __callEvent = function()
    {
        var _event = argument[0];
        var _array = __getEventArray(_event);
        
        if (array_length(_array) <= 0)
        {
            switch (_event)
            {
                case UnknownEnum.Value_20:
                    scrollTargetY += (global.__uiScrollMouseWheelReverse ? -global.__uiScrollMouseWheelSpeed : global.__uiScrollMouseWheelSpeed);
                    break;
                
                case UnknownEnum.Value_21:
                    scrollTargetY -= (global.__uiScrollMouseWheelReverse ? -global.__uiScrollMouseWheelSpeed : global.__uiScrollMouseWheelSpeed);
                    break;
                
                case UnknownEnum.Value_16:
                case UnknownEnum.Value_17:
                case UnknownEnum.Value_18:
                    scrollTargetX += argument[1];
                    scrollTargetY += argument[2];
                    break;
            }
        }
        else
        {
            __uiEventStackPush(_event);
            var _result = undefined;
            var _i = 0;
            
            repeat (array_length(_array))
            {
                var _func = _array[_i];
                
                switch (argument_count)
                {
                    case 1:
                        _result = _func();
                        break;
                    
                    case 2:
                        _result = _func(argument[1]);
                        break;
                    
                    case 3:
                        _result = _func(argument[1], argument[2]);
                        break;
                    
                    case 4:
                        _result = _func(argument[1], argument[2], argument[3]);
                        break;
                    
                    case 5:
                        _result = _func(argument[1], argument[2], argument[3], argument[4]);
                        break;
                    
                    case 6:
                        _result = _func(argument[1], argument[2], argument[3], argument[4], argument[5]);
                        break;
                    
                    default:
                        __uiError("Argument count (", argument_count, ") unsupported");
                        break;
                }
                
                _i++;
            }
            
            __uiEventStackPop();
            return _result;
        }
        
        return undefined;
    };
    
    static __pointInside = function(arg0, arg1)
    {
        var _result = __pointDistance(arg0, arg1);
        
        if (_result == undefined)
            return false;
        
        return _result == 0;
    };
    
    static __pointDistance = function(arg0, arg1)
    {
        var _result = __nearestPointToPoint(arg0, arg1);
        
        if (_result == undefined)
            return undefined;
        
        return point_distance(arg0, arg1, _result[0], _result[1]);
    };
    
    static __nearestPointToPoint = function(arg0, arg1)
    {
        var _result = undefined;
        
        if (!__isEventEmpty(UnknownEnum.Value_22))
            _result = __callEvent(UnknownEnum.Value_22, arg0, arg1);
        else
            _result = [clamp(arg0, outShapeClipLeft, outShapeClipRight), clamp(arg1, outShapeClipTop, outShapeClipBottom)];
        
        return _result;
    };
    
    static __axisDistance = function(arg0, arg1, arg2, arg3)
    {
        var _p = __nearestPointToPoint(arg0, arg1);
        
        if (_p == undefined)
            return undefined;
        
        return (arg2 * _p[0]) + (arg3 * _p[1]);
    };
    
    static __axisDot = function(arg0, arg1, arg2, arg3)
    {
        var _p = __nearestPointToPoint(arg0, arg1);
        
        if (_p == undefined)
            return undefined;
        
        var _px = _p[0] - arg0;
        var _py = _p[1] - arg1;
        var _inv_dist = 1 / sqrt((_px * _px) + (_py * _py));
        _px *= _inv_dist;
        _py *= _inv_dist;
        return (_px * arg2) + (_py * arg3);
    };
    
    static __lineIntersectionDistance = function(arg0, arg1, arg2, arg3)
    {
        var _result = undefined;
        
        if (!__isEventEmpty(UnknownEnum.Value_23))
        {
            _result = __callEvent(UnknownEnum.Value_23, arg0, arg1, arg2, arg3);
        }
        else
        {
            var _dx = arg2 - arg0;
            var _dy = arg3 - arg1;
            var _tLow = 0;
            var _tHigh = 1;
            var _tx0 = (outShapeClipLeft - arg0) / _dx;
            var _tx1 = (outShapeClipRight - arg0) / _dx;
            
            if (_tx0 > _tx1)
            {
                var _temp = _tx0;
                _tx0 = _tx1;
                _tx1 = _temp;
            }
            
            if (_tx1 > _tLow && _tx0 < _tHigh)
            {
                if (_tx0 > _tLow)
                    _tLow = _tx0;
                
                if (_tx1 < _tHigh)
                    _tHigh = _tx1;
                
                if (_tLow < _tHigh)
                {
                    var _ty0 = (outShapeClipTop - arg1) / _dy;
                    var _ty1 = (outShapeClipBottom - arg1) / _dy;
                    
                    if (_ty0 > _ty1)
                    {
                        var _temp = _ty0;
                        _ty0 = _ty1;
                        _ty1 = _temp;
                    }
                    
                    if (_ty1 > _tLow && _ty0 < _tHigh)
                    {
                        if (_ty0 > _tLow)
                            _tLow = _ty0;
                        
                        if (_ty1 < _tHigh)
                            _tHigh = _ty1;
                        
                        if (_tLow < _tHigh)
                            _result = _tLow * point_distance(0, 0, _dx, _dy);
                    }
                }
            }
        }
        
        return _result;
    };
    
    static __getEventArray = function(arg0)
    {
        if (!is_numeric(arg0) || arg0 < 0 || arg0 >= UnknownEnum.Value_24)
            __uiError("Event \"", arg0, "\" not supported. Please use a value from the UI_EVENT enum");
        
        return __eventsArray[arg0];
    };
    
    static __isEventEmpty = function(arg0)
    {
        return array_length(__getEventArray(arg0)) <= 0;
    };
    
    static __isEventGroupEmpty = function(arg0)
    {
        switch (arg0)
        {
            case UnknownEnum.Value_1:
                if (!__isEventEmpty(UnknownEnum.Value_2) || !__isEventEmpty(UnknownEnum.Value_3))
                    return false;
                
                break;
            
            case UnknownEnum.Value_0:
                if (!__isEventEmpty(UnknownEnum.Value_1))
                    return false;
                
                break;
            
            case UnknownEnum.Value_2:
                if (!__isEventEmpty(UnknownEnum.Value_4) || !__isEventEmpty(UnknownEnum.Value_5) || !__isEventEmpty(UnknownEnum.Value_6) || !__isEventEmpty(UnknownEnum.Value_7))
                    return false;
                
                break;
            
            case UnknownEnum.Value_3:
                if (!__isEventEmpty(UnknownEnum.Value_8) || !__isEventEmpty(UnknownEnum.Value_9) || !__isEventEmpty(UnknownEnum.Value_10) || !__isEventEmpty(UnknownEnum.Value_11))
                    return false;
                
                break;
            
            case UnknownEnum.Value_4:
                if (!__isEventEmpty(UnknownEnum.Value_12) || !__isEventEmpty(UnknownEnum.Value_13) || !__isEventEmpty(UnknownEnum.Value_14) || !__isEventEmpty(UnknownEnum.Value_15))
                    return false;
                
                break;
            
            case UnknownEnum.Value_5:
                if (!__isEventEmpty(UnknownEnum.Value_16) || !__isEventEmpty(UnknownEnum.Value_17) || !__isEventEmpty(UnknownEnum.Value_18) || !__isEventEmpty(UnknownEnum.Value_19) || !__isEventEmpty(UnknownEnum.Value_20) || !__isEventEmpty(UnknownEnum.Value_21))
                    return false;
                
                break;
            
            case UnknownEnum.Value_6:
                if (!__isEventEmpty(UnknownEnum.Value_22))
                    return false;
                
                break;
            
            case UnknownEnum.Value_7:
                if (!__isEventEmpty(UnknownEnum.Value_23))
                    return false;
                
                break;
            
            default:
                __uiError("Event group \"", arg0, "\" not supported. Please use a value from the UI_EVENT_GROUP enum");
                break;
        }
        
        return true;
    };
    
    static __findAncestorWithEventGroup = function(arg0)
    {
        if (scrollAllow && arg0 == UnknownEnum.Value_5)
            return self;
        
        if (gestureAllow && !__isEventGroupEmpty(arg0))
            return self;
        
        if (parentTag == undefined)
            return global.__uiNullElement;
        
        return __uiElementFind(parentTag).__findAncestorWithEventGroup(arg0);
    };
    
    static __focusCursor = function(arg0)
    {
        if (arg0)
        {
            outCursorInside = false;
            var _i = 0;
            
            repeat (array_length(children))
            {
                var _child_tag = children[_i];
                var _child = __uiElementFind(_child_tag);
                _child.__focusCursor(true);
                _i++;
            }
        }
        else
        {
            __checkShapeCache();
            
            if (__cacheShapeDirty)
                updateShape();
            
            if (gestureAllow && __pointInside(global.__uiTempX, global.__uiTempY))
            {
                outCursorInside = true;
                global.__uiTempOver = self;
            }
            else
            {
                outCursorInside = false;
            }
            
            var _i = 0;
            
            repeat (array_length(children))
            {
                var _child_tag = children[_i];
                var _child = __uiElementFind(_child_tag);
                _child.__focusCursor(!gestureChildrenAllow);
                _i++;
            }
        }
    };
    
    static __focusGamepad = function()
    {
        if ((gestureAllow && !__isEventGroupEmpty(UnknownEnum.Value_2)) || gestureChildrenAllow == true)
        {
            __checkShapeCache();
            
            if (__cacheShapeDirty)
                updateShape();
            
            if (gestureAllow && !__isEventGroupEmpty(UnknownEnum.Value_2))
            {
                if (global.__uiTempPrevOver != self)
                {
                    var _dist = __lineIntersectionDistance(global.__uiTempX, global.__uiTempY, global.__uiTempX2, global.__uiTempY2);
                    
                    if (_dist != undefined && _dist <= global.__uiTempMinDist)
                    {
                        global.__uiTempOver = self;
                        global.__uiTempMinDist = _dist;
                    }
                }
            }
            
            if (gestureChildrenAllow == true)
            {
                var _i = 0;
                
                repeat (array_length(children))
                {
                    var _child_tag = children[_i];
                    var _child = __uiElementFind(_child_tag);
                    _child.__focusGamepad();
                    _i++;
                }
            }
        }
    };
    
    static __focusGamepadBuildTree = function(arg0, arg1, arg2, arg3, arg4, arg5)
    {
        var _process = gestureAllow && !__isEventGroupEmpty(UnknownEnum.Value_2);
        
        if (gestureChildrenAllow)
        {
            var _i = 0;
            
            repeat (array_length(children))
            {
                if (__uiElementFind(children[_i]).__focusGamepadBuildTree(arg0, arg1, arg2, arg3, arg4, arg5))
                    _process = true;
                
                _i++;
            }
        }
        else
        {
            var _i = 0;
            
            repeat (array_length(children))
            {
                __uiElementFind(children[_i]).__focusGamepadBuildTreeNeutral();
                _i++;
            }
        }
        
        if (_process)
        {
            var _distance = __axisDistance(arg0, arg1, arg3, arg4) - arg2;
            
            if (_distance > 0)
            {
                var _dot = __axisDot(arg0, arg1, arg3, arg4);
                
                if (_dot > arg5)
                {
                    var _struct = 
                    {
                        tag: globalTag,
                        distance: _distance
                    };
                    array_push(global.__uiTempElementArray, _struct);
                    variable_struct_set(global.__uiTempElementDict, globalTag, _struct);
                }
            }
        }
        
        return _process;
    };
    
    static __focusGamepadBuildTreeNeutral = function()
    {
        var _i = 0;
        
        repeat (array_length(children))
        {
            __uiElementFind(children[_i]).__focusGamepadBuildTreeNeutral();
            _i++;
        }
    };
    
    static __nearestFocusableDecendent = function(arg0, arg1)
    {
        global.__uiTempX = arg0;
        global.__uiTempY = arg1;
        global.__uiTempOver = global.__uiNullElement;
        global.__uiTempMinDist = 999999999;
        __nearestFocusableDecendentInner();
        return global.__uiTempOver;
    };
    
    static __nearestFocusableDecendentInner = function()
    {
        if ((gestureAllow && !__isEventGroupEmpty(UnknownEnum.Value_2)) || gestureChildrenAllow == true)
        {
            __checkShapeCache();
            
            if (__cacheShapeDirty)
                updateShape();
            
            if (gestureAllow && !__isEventGroupEmpty(UnknownEnum.Value_2))
            {
                var _dist = __pointDistance(global.__uiTempX, global.__uiTempY);
                
                if (_dist < global.__uiTempMinDist)
                {
                    global.__uiTempMinDist = _dist;
                    global.__uiTempOver = self;
                }
            }
            
            if (gestureChildrenAllow == true)
            {
                var _i = 0;
                
                repeat (array_length(children))
                {
                    __uiElementFind(children[_i]).__nearestFocusableDecendentInner();
                    _i++;
                }
            }
        }
    };
    
    static __isFocusable = function()
    {
        if (!gestureAllow || __isEventGroupEmpty(UnknownEnum.Value_2))
            return false;
        
        var _parent = __uiElementFind(parentTag);
        
        if (_parent == global.__uiNullElement)
            return true;
        
        return _parent.__isFocusableInner();
    };
    
    static __isFocusableInner = function(arg0)
    {
        if (!gestureChildrenAllow)
            return false;
        
        var _parent = __uiElementFind(parentTag);
        
        if (_parent == global.__uiNullElement)
            return true;
        
        return _parent.__isFocusableInner();
    };
    
    static __checkShapeCache = function()
    {
        if (!__cacheShapeDirty)
        {
            if (__cacheShapeCenterX != shapeXCenter || __cacheShapeCenterY != shapeYCenter || __cacheShapeLeft != shapeLeft || __cacheShapeTop != shapeTop || __cacheShapeRight != shapeRight || __cacheShapeBottom != shapeBottom || __cacheShapeWidth != shapeWidth || __cacheShapeHeight != shapeHeight || __cacheShapeFlowStyle != flowStyle || __cacheShapeFlowDirection != flowDirection || __cacheShapeFlowAreaHAlign != flowAreaHAlign || __cacheShapeFlowAreaVAlign != flowAreaVAlign || __cacheShapeFlowLineHAlign != flowLineHAlign || __cacheShapeFlowLineVAlign != flowLineVAlign || __cacheShapeFlowMarginLeft != flowMarginLeft || __cacheShapeFlowMarginTop != flowMarginTop || __cacheShapeFlowMarginRight != flowMarginRight || __cacheShapeFlowMarginBottom != flowMarginBottom || __cacheShapeFlowGutterX != flowGutterH || __cacheShapeFlowGutterY != flowGutterV || __cacheShapeScrollX != scrollX || __cacheShapeScrollY != scrollY)
                __cacheShapeDirty = true;
            else
                __cacheShapeDirty = false;
        }
    };
    
    static __updateShapeCache = function()
    {
        __cacheShapeDirty = false;
        __cacheShapeCenterX = shapeXCenter;
        __cacheShapeCenterY = shapeYCenter;
        __cacheShapeLeft = shapeLeft;
        __cacheShapeTop = shapeTop;
        __cacheShapeRight = shapeRight;
        __cacheShapeBottom = shapeBottom;
        __cacheShapeWidth = shapeWidth;
        __cacheShapeHeight = shapeHeight;
        __cacheShapeFlowStyle = flowStyle;
        __cacheShapeFlowDirection = flowDirection;
        __cacheShapeFlowAreaHAlign = flowAreaHAlign;
        __cacheShapeFlowAreaVAlign = flowAreaVAlign;
        __cacheShapeFlowLineHAlign = flowLineHAlign;
        __cacheShapeFlowLineVAlign = flowLineVAlign;
        __cacheShapeFlowMarginLeft = flowMarginLeft;
        __cacheShapeFlowMarginTop = flowMarginTop;
        __cacheShapeFlowMarginRight = flowMarginRight;
        __cacheShapeFlowMarginBottom = flowMarginBottom;
        __cacheShapeFlowGutterX = flowGutterH;
        __cacheShapeFlowGutterY = flowGutterV;
        __cacheShapeScrollX = scrollX;
        __cacheShapeScrollY = scrollY;
    };
    
    static __initializeCalcVariables = function()
    {
        __calcOffsetX = 0;
        __calcOffsetY = 0;
        __calcCenterX = shapeXCenter;
        __calcCenterY = shapeYCenter;
        __calcLeft = shapeLeft;
        __calcTop = shapeTop;
        __calcRight = shapeRight;
        __calcBottom = shapeBottom;
        __calcWidth = shapeWidth;
        __calcHeight = shapeHeight;
        __calcWidthAuto = false;
        __calcHeightAuto = false;
        
        if (__calcLeft != undefined && __calcRight != undefined)
        {
            if (__calcLeft > __calcRight)
            {
                var _temp = __calcLeft;
                __calcLeft = __calcRight;
                __calcRight = _temp;
            }
        }
        
        if (__calcTop != undefined && __calcBottom != undefined)
        {
            if (__calcTop > __calcBottom)
            {
                var _temp = __calcTop;
                __calcTop = __calcBottom;
                __calcBottom = _temp;
            }
        }
    };
    
    static __calculateShape = function()
    {
        __updateShapeCache();
        __initializeCalcVariables();
        __calculateXAxisDimensions();
        __calculateYAxisDimensions();
        __calculateChildDimensions();
        __resolveAutoWidth();
        __resolveAutoHeight();
        __calculateFlow();
    };
    
    static __calculateXAxisDimensions = function()
    {
        var _freedom = (__calcCenterX == undefined) + (__calcLeft == undefined) + (__calcRight == undefined) + (__calcWidth == undefined);
        
        switch (_freedom)
        {
            case 0:
            case 1:
                __uiError("Overconstrained x-axis\n(element=\"", tagPath, "\")");
                break;
            
            case 2:
                __calcWidthAuto = false;
                
                if (__calcCenterX == undefined)
                {
                    if (__calcLeft == undefined)
                        __calcLeft = (1 + __calcRight) - __calcWidth;
                    
                    if (__calcRight == undefined)
                        __calcRight = -1 + __calcLeft + __calcWidth;
                    
                    if (__calcWidth == undefined)
                        __calcWidth = (1 + __calcRight) - __calcLeft;
                    
                    __calcCenterX = (__calcLeft + __calcRight) / 2;
                }
                else
                {
                    if (__calcLeft != undefined)
                    {
                        __calcWidth = (__calcCenterX - __calcLeft) * 2;
                        __calcRight = -1 + __calcLeft + __calcWidth;
                    }
                    
                    if (__calcRight != undefined)
                    {
                        __calcWidth = (__calcRight - __calcCenterX) * 2;
                        __calcLeft = (1 + __calcRight) - __calcWidth;
                    }
                    
                    if (__calcWidth != undefined)
                    {
                        __calcLeft = __calcCenterX - (__calcWidth / 2);
                        __calcRight = __calcCenterX + (__calcWidth / 2);
                    }
                }
                
                break;
            
            case 3:
                if (__calcWidth == undefined)
                {
                    __calcWidthAuto = true;
                }
                else
                {
                    __calcLeft = 0;
                    __calcRight = __calcWidth - 1;
                    __calcCenterX = (__calcWidth - 1) / 2;
                }
                
                break;
            
            default:
                __calcWidthAuto = true;
                break;
        }
    };
    
    static __calculateYAxisDimensions = function()
    {
        var _freedom = (__calcCenterY == undefined) + (__calcTop == undefined) + (__calcBottom == undefined) + (__calcHeight == undefined);
        
        switch (_freedom)
        {
            case 0:
            case 1:
                __uiError("Overconstrained y-axis\n(element=\"", tagPath, "\")");
                break;
            
            case 2:
                __calcHeightAuto = false;
                
                if (__calcCenterY == undefined)
                {
                    if (__calcTop == undefined)
                        __calcTop = (1 + __calcBottom) - __calcHeight;
                    
                    if (__calcBottom == undefined)
                        __calcBottom = -1 + __calcTop + __calcHeight;
                    
                    if (__calcHeight == undefined)
                        __calcHeight = (1 + __calcBottom) - __calcTop;
                    
                    __calcCenterY = (__calcTop + __calcBottom) / 2;
                }
                else
                {
                    if (__calcTop != undefined)
                    {
                        __calcHeight = (__calcCenterY - __calcTop) * 2;
                        __calcBottom = -1 + __calcTop + __calcHeight;
                    }
                    
                    if (__calcBottom != undefined)
                    {
                        __calcHeight = (__calcBottom - __calcCenterY) * 2;
                        __calcTop = (1 + __calcBottom) - __calcHeight;
                    }
                    
                    if (__calcHeight != undefined)
                    {
                        __calcTop = __calcCenterY - (__calcHeight / 2);
                        __calcBottom = __calcCenterY + (__calcHeight / 2);
                    }
                }
                
                break;
            
            case 3:
                if (__calcHeight == undefined)
                {
                    __calcHeightAuto = true;
                }
                else
                {
                    __calcTop = 0;
                    __calcBottom = __calcHeight - 1;
                    __calcCenterY = (__calcHeight - 1) / 2;
                }
                
                break;
            
            default:
                __calcHeightAuto = true;
                break;
        }
    };
    
    static __calculateChildDimensions = function()
    {
        var _i = 0;
        
        repeat (array_length(children))
        {
            var _child_tag = children[_i];
            var _child = __uiElementFind(_child_tag);
            _child.__calculateShape();
            _i++;
        }
    };
    
    static __resolveAutoWidth = function()
    {
        if (__calcWidthAuto)
        {
            __calcWidth = (flowDirection == "x") ? __findTotalChildWidth(true, true) : __findMaxChildWidth();
            __calculateXAxisDimensions();
        }
    };
    
    static __resolveAutoHeight = function()
    {
        if (__calcHeightAuto)
        {
            __calcHeight = (flowDirection == "y") ? __findTotalChildHeight(true, true) : __findMaxChildHeight();
            __calculateYAxisDimensions();
        }
    };
    
    static __calculateFlow = function()
    {
        if (flowStyle == "list")
        {
            var _flow_width = __calcWidth - (flowMarginLeft + flowMarginRight);
            var _flow_height = __calcHeight - (flowMarginTop + flowMarginBottom);
            outFlowWidth = _flow_width;
            outFlowHeight = _flow_height;
            
            if (flowDirection == "x")
            {
                outFlowAreaWidth = __findTotalChildWidth(false, true);
                outFlowAreaHeight = __findMaxChildHeight();
                var _area_offset_x = flowMarginLeft;
                var _area_offset_y = flowMarginTop;
                
                switch (flowAreaHAlign)
                {
                    case 0:
                    case "left":
                        break;
                    
                    case 1:
                    case "center":
                    case "centre":
                        _area_offset_x += ((_flow_width - outFlowAreaWidth) / 2);
                        break;
                    
                    case 2:
                    case "right":
                        _area_offset_x += (_flow_width - outFlowAreaWidth);
                        break;
                    
                    default:
                        __uiError("Flow area horizontal alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                switch (flowAreaVAlign)
                {
                    case 0:
                    case "top":
                        break;
                    
                    case 1:
                    case "middle":
                        _area_offset_y += ((_flow_height - outFlowAreaHeight) / 2);
                        break;
                    
                    case 2:
                    case "bottom":
                        _area_offset_y += (_flow_height - outFlowAreaHeight);
                        break;
                    
                    default:
                        __uiError("Flow area vertical alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                var _x = _area_offset_x;
                var _y = _area_offset_y;
                var _i = 0;
                
                repeat (array_length(children))
                {
                    var _child_tag = children[_i];
                    var _child = __uiElementFind(_child_tag);
                    
                    with (_child)
                    {
                        var _offset;
                        
                        switch (other.flowLineVAlign)
                        {
                            case 0:
                            case "top":
                                _offset = 0;
                                break;
                            
                            case 1:
                            case "middle":
                                _offset = (getParent().outFlowAreaHeight - __calcHeight) / 2;
                                break;
                            
                            case 2:
                            case "bottom":
                                _offset = getParent().outFlowAreaHeight - __calcHeight;
                                break;
                            
                            default:
                                __uiError("Flow line vertical alignment \"", other.flowLineVAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                                break;
                        }
                        
                        __calcOffsetX += _x;
                        __calcOffsetY += (_y + _offset);
                        outFlowIndex = _i;
                        outFlowGridX = 0;
                        outFlowGridY = _i;
                        _x += (__calcWidth + other.flowGutterH);
                    }
                    
                    _i++;
                }
            }
            else if (flowDirection == "y")
            {
                outFlowAreaWidth = __findMaxChildWidth();
                outFlowAreaHeight = __findTotalChildHeight(false, true);
                var _area_offset_x = flowMarginLeft;
                var _area_offset_y = flowMarginTop;
                
                switch (flowAreaHAlign)
                {
                    case 0:
                    case "left":
                        break;
                    
                    case 1:
                    case "center":
                    case "centre":
                        _area_offset_x += ((_flow_width - outFlowAreaWidth) / 2);
                        break;
                    
                    case 2:
                    case "right":
                        _area_offset_x += (_flow_width - outFlowAreaWidth);
                        break;
                    
                    default:
                        __uiError("Flow area horizontal alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                switch (flowAreaVAlign)
                {
                    case 0:
                    case "top":
                        break;
                    
                    case 1:
                    case "middle":
                        _area_offset_y += ((_flow_height - outFlowAreaHeight) / 2);
                        break;
                    
                    case 2:
                    case "bottom":
                        _area_offset_y += (_flow_height - outFlowAreaHeight);
                        break;
                    
                    default:
                        __uiError("Flow area vertical alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                var _x = _area_offset_x;
                var _y = _area_offset_y;
                var _i = 0;
                
                repeat (array_length(children))
                {
                    var _child_tag = children[_i];
                    var _child = __uiElementFind(_child_tag);
                    
                    with (_child)
                    {
                        var _offset;
                        
                        switch (other.flowLineHAlign)
                        {
                            case 0:
                            case "left":
                                _offset = 0;
                                break;
                            
                            case 1:
                            case "center":
                            case "centre":
                                _offset = (getParent().outFlowAreaWidth - __calcWidth) / 2;
                                break;
                            
                            case 2:
                            case "right":
                                _offset = getParent().outFlowAreaWidth - __calcWidth;
                                break;
                            
                            default:
                                __uiError("Flow line horizontal alignment \"", other.flowLineHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                                break;
                        }
                        
                        __calcOffsetX += (_x + _offset);
                        __calcOffsetY += _y;
                        outFlowIndex = _i;
                        outFlowGridX = _i;
                        outFlowGridY = 0;
                        _y += (__calcHeight + other.flowGutterV);
                    }
                    
                    _i++;
                }
            }
            else
            {
                __uiError("Flow direction \"", flowDirection, "\" not supported for flow style \"", flowStyle, "\"\n(element=\"", tagPath, "\")\n(element=\"", tagPath, "\")");
            }
        }
        else if (flowStyle == "grid")
        {
            if ((flowGridXCount == undefined) == (flowGridYCount == undefined))
                __uiError("Grid flow must have one (and only one) dimension defined (x=", flowGridXCount, ", y=", flowGridYCount, ")");
            
            outFlowAreaWidth = 0;
            outFlowAreaHeight = 0;
            var _area_line_array = [];
            var _flow_width = __calcWidth - (flowMarginLeft + flowMarginRight);
            var _flow_height = __calcHeight - (flowMarginTop + flowMarginBottom);
            outFlowWidth = _flow_width;
            outFlowHeight = _flow_height;
            var _x = 0;
            var _y = 0;
            var _line_child_array = [];
            var _line_width = 0;
            var _line_height = 0;
            var _line_data = 
            {
                children: _line_child_array,
                x: _x,
                y: _y,
                width: undefined,
                height: undefined
            };
            array_push(_area_line_array, _line_data);
            
            if (flowDirection == "x")
            {
                _x += flowWaveSize;
                _line_data.x = _x;
                var _i = 0;
                
                repeat (array_length(children))
                {
                    var _child_tag = children[_i];
                    var _child = __uiElementFind(_child_tag);
                    
                    if (array_length(_line_child_array) >= flowGridXCount)
                    {
                        _line_data.width = _line_width;
                        _line_data.height = _line_height;
                        outFlowAreaWidth = max(outFlowAreaWidth, _line_width);
                        outFlowAreaHeight = max(outFlowAreaHeight, _y + _line_height);
                        _x = 2 * flowWaveSize * triangleWave(array_length(_area_line_array) + 3, 4);
                        _y += (_line_height + flowGutterV);
                        _line_child_array = [];
                        _line_width = 0;
                        _line_height = 0;
                        _line_data = 
                        {
                            children: _line_child_array,
                            x: _x,
                            y: _y,
                            width: undefined,
                            height: undefined
                        };
                        array_push(_area_line_array, _line_data);
                    }
                    
                    array_push(_line_child_array, _child);
                    _line_width = max(_line_width, _x + _child.__calcWidth);
                    _line_height = max(_line_height, _child.__calcHeight);
                    _x += (_child.__calcWidth + flowGutterH);
                    _i++;
                }
                
                _line_data.width = _line_width;
                _line_data.height = _line_height;
                outFlowAreaWidth = max(outFlowAreaWidth, _line_width);
                outFlowAreaHeight = max(outFlowAreaHeight, _y + _line_height);
                var _area_offset_x = flowMarginLeft;
                var _area_offset_y = flowMarginTop;
                
                switch (flowAreaHAlign)
                {
                    case 0:
                    case "left":
                        break;
                    
                    case 1:
                    case "center":
                    case "centre":
                        _area_offset_x += ((_flow_width - outFlowAreaWidth) / 2);
                        break;
                    
                    case 2:
                    case "right":
                        _area_offset_x += (_flow_width - outFlowAreaWidth);
                        break;
                    
                    default:
                        __uiError("Flow area horizontal alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                switch (flowAreaVAlign)
                {
                    case 0:
                    case "top":
                        break;
                    
                    case 1:
                    case "middle":
                        _area_offset_y += ((_flow_height - outFlowAreaHeight) / 2);
                        break;
                    
                    case 2:
                    case "bottom":
                        _area_offset_y += (_flow_height - outFlowAreaHeight);
                        break;
                    
                    default:
                        __uiError("Flow area vertical alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                var _child_index = 0;
                var _child_grid_x = 0;
                var _child_grid_y = 0;
                var _l = 0;
                
                repeat (array_length(_area_line_array))
                {
                    _line_data = _area_line_array[_l];
                    _line_child_array = _line_data.children;
                    _line_width = _line_data.width;
                    _line_height = _line_data.height;
                    _child_grid_x = 0;
                    var _line_offset_x;
                    
                    switch (flowLineHAlign)
                    {
                        case 0:
                        case "left":
                            _line_offset_x = 0;
                            break;
                        
                        case 1:
                        case "center":
                        case "centre":
                            _line_offset_x = (outFlowAreaWidth - _line_width) / 2;
                            break;
                        
                        case 2:
                        case "right":
                            _line_offset_x = outFlowAreaWidth - _line_width;
                            break;
                        
                        default:
                            __uiError("Flow line horizontal alignment \"", flowLineHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                            break;
                    }
                    
                    _x = _area_offset_x + _line_offset_x + _line_data.x;
                    _y = _area_offset_y + _line_data.y;
                    var _c = 0;
                    
                    repeat (array_length(_line_child_array))
                    {
                        with (_line_child_array[_c])
                        {
                            var _offset;
                            
                            switch (other.flowLineVAlign)
                            {
                                case 0:
                                case "top":
                                    _offset = 0;
                                    break;
                                
                                case 1:
                                case "middle":
                                    _offset = (_line_height - __calcHeight) / 2;
                                    break;
                                
                                case 2:
                                case "bottom":
                                    _offset = _line_height - __calcHeight;
                                    break;
                                
                                default:
                                    __uiError("Flow line vertical alignment \"", flowLineVAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                                    break;
                            }
                            
                            __calcOffsetX += _x;
                            __calcOffsetY += (_y + _offset);
                            outFlowIndex = _child_index;
                            outFlowGridX = _child_grid_x;
                            outFlowGridY = _child_grid_y;
                            _x += (__calcWidth + other.flowGutterH);
                            _child_index++;
                        }
                        
                        _c++;
                        _child_grid_x++;
                    }
                    
                    _l++;
                    _child_grid_y++;
                }
            }
            else if (flowDirection == "y")
            {
                var _i = 0;
                
                repeat (array_length(children))
                {
                    var _child_tag = children[_i];
                    var _child = __uiElementFind(_child_tag);
                    
                    if (array_length(_line_child_array) >= flowGridYCount)
                    {
                        _line_data.width = _line_width;
                        _line_data.height = _line_height;
                        outFlowAreaWidth = max(outFlowAreaWidth, _x + _line_width);
                        outFlowAreaHeight = max(outFlowAreaHeight, _line_height);
                        _y = 0;
                        _x += (_line_width + flowGutterH);
                        _line_child_array = [];
                        _line_width = 0;
                        _line_height = 0;
                        _line_data = 
                        {
                            children: _line_child_array,
                            x: _x,
                            y: _y,
                            width: undefined,
                            height: undefined
                        };
                        array_push(_area_line_array, _line_data);
                    }
                    
                    array_push(_line_child_array, _child);
                    outFlowAreaWidth = max(outFlowAreaWidth, _child.__calcWidth);
                    outFlowAreaHeight = max(outFlowAreaHeight, _y + _child.__calcHeight);
                    _y += (_child.__calcHeight + flowGutterV);
                    _i++;
                }
                
                _line_data.width = _line_width;
                _line_data.height = _line_height;
                outFlowAreaWidth = max(outFlowAreaWidth, _x + _line_width);
                outFlowAreaHeight = max(outFlowAreaHeight, _line_height);
                var _area_offset_x = flowMarginLeft;
                var _area_offset_y = flowMarginTop;
                
                switch (flowAreaHAlign)
                {
                    case 0:
                    case "left":
                        break;
                    
                    case 1:
                    case "center":
                    case "centre":
                        _area_offset_x += ((_flow_width - outFlowAreaWidth) / 2);
                        break;
                    
                    case 2:
                    case "right":
                        _area_offset_x += (_flow_width - outFlowAreaWidth);
                        break;
                    
                    default:
                        __uiError("Flow area horizontal alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                switch (flowAreaVAlign)
                {
                    case 0:
                    case "top":
                        break;
                    
                    case 1:
                    case "middle":
                        _area_offset_y += ((_flow_height - outFlowAreaHeight) / 2);
                        break;
                    
                    case 2:
                    case "bottom":
                        _area_offset_y += (_flow_height - outFlowAreaHeight);
                        break;
                    
                    default:
                        __uiError("Flow area vertical alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                var _child_index = 0;
                var _child_grid_x = 0;
                var _child_grid_y = 0;
                var _l = 0;
                
                repeat (array_length(_area_line_array))
                {
                    _line_data = _area_line_array[_l];
                    _line_child_array = _line_data.children;
                    _line_width = _line_data.width;
                    _line_height = _line_data.height;
                    _child_grid_y = 0;
                    var _line_offset_y;
                    
                    switch (flowLineVAlign)
                    {
                        case 0:
                        case "top":
                            _line_offset_y = 0;
                            break;
                        
                        case 1:
                        case "middle":
                            _line_offset_y = (outFlowAreaHeight - _line_height) / 2;
                            break;
                        
                        case 2:
                        case "bottom":
                            _line_offset_y = outFlowAreaHeight - _line_height;
                            break;
                        
                        default:
                            __uiError("Flow line vertical alignment \"", flowLineVAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                            break;
                    }
                    
                    _x = _area_offset_x + _line_data.x;
                    _y = _area_offset_y + _line_offset_y + _line_data.y;
                    var _c = 0;
                    
                    repeat (array_length(_line_child_array))
                    {
                        with (_line_child_array[_c])
                        {
                            var _offset;
                            
                            switch (other.flowLineHAlign)
                            {
                                case 0:
                                case "left":
                                    _offset = 0;
                                    break;
                                
                                case 1:
                                case "center":
                                case "centre":
                                    _offset = (_line_width - __calcWidth) / 2;
                                    break;
                                
                                case 2:
                                case "right":
                                    _offset = _line_width - __calcWidth;
                                    break;
                                
                                default:
                                    __uiError("Flow line horizontal alignment \"", flowLineHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                                    break;
                            }
                            
                            __calcOffsetX += (_x + _offset);
                            __calcOffsetY += _y;
                            outFlowIndex = _child_index;
                            outFlowGridX = _child_grid_x;
                            outFlowGridY = _child_grid_y;
                            _y += (__calcHeight + other.flowGutterV);
                            _child_index++;
                        }
                        
                        _c++;
                        _child_grid_y++;
                    }
                    
                    _l++;
                    _child_grid_x++;
                }
            }
            else
            {
                __uiError("Flow direction \"", flowDirection, "\" not supported for flow style \"", flowStyle, "\"\n(element=\"", tagPath, "\")");
            }
        }
        else if (flowStyle == "wrap")
        {
            outFlowAreaWidth = 0;
            outFlowAreaHeight = 0;
            var _area_line_array = [];
            var _flow_width = __calcWidth - (flowMarginLeft + flowMarginRight);
            var _flow_height = __calcHeight - (flowMarginTop + flowMarginBottom);
            outFlowWidth = _flow_width;
            outFlowHeight = _flow_height;
            var _x = 0;
            var _y = 0;
            var _line_child_array = [];
            var _line_width = 0;
            var _line_height = 0;
            var _line_data = 
            {
                children: _line_child_array,
                x: _x,
                y: _y,
                width: undefined,
                height: undefined
            };
            array_push(_area_line_array, _line_data);
            
            if (flowDirection == "x")
            {
                if (__calcWidthAuto)
                    __uiTrace("Warning! Using x-first wrap flow, but width was not explicitly defined");
                
                _x += flowWaveSize;
                _line_data.x = _x;
                var _i = 0;
                
                repeat (array_length(children))
                {
                    var _child_tag = children[_i];
                    var _child = __uiElementFind(_child_tag);
                    
                    if ((_x + _child.__calcWidth) > _flow_width)
                    {
                        if (_x != 0 || _child.__calcWidth <= _flow_width)
                        {
                            _line_data.width = _line_width;
                            _line_data.height = _line_height;
                            outFlowAreaWidth = max(outFlowAreaWidth, _line_width);
                            outFlowAreaHeight = max(outFlowAreaHeight, _y + _line_height);
                            _x = 2 * flowWaveSize * triangleWave(array_length(_area_line_array) + 3, 4);
                            _y += (_line_height + flowGutterV);
                            _line_child_array = [];
                            _line_width = 0;
                            _line_height = 0;
                            _line_data = 
                            {
                                children: _line_child_array,
                                x: _x,
                                y: _y,
                                width: undefined,
                                height: undefined
                            };
                            array_push(_area_line_array, _line_data);
                        }
                    }
                    
                    array_push(_line_child_array, _child);
                    _line_width = max(_line_width, _x + _child.__calcWidth);
                    _line_height = max(_line_height, _child.__calcHeight);
                    _x += (_child.__calcWidth + flowGutterH);
                    _i++;
                }
                
                _line_data.width = _line_width;
                _line_data.height = _line_height;
                outFlowAreaWidth = max(outFlowAreaWidth, _line_width);
                outFlowAreaHeight = max(outFlowAreaHeight, _y + _line_height);
                var _area_offset_x = flowMarginLeft;
                var _area_offset_y = flowMarginTop;
                
                switch (flowAreaHAlign)
                {
                    case 0:
                    case "left":
                        break;
                    
                    case 1:
                    case "center":
                    case "centre":
                        _area_offset_x += ((_flow_width - outFlowAreaWidth) / 2);
                        break;
                    
                    case 2:
                    case "right":
                        _area_offset_x += (_flow_width - outFlowAreaWidth);
                        break;
                    
                    default:
                        __uiError("Flow area horizontal alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                switch (flowAreaVAlign)
                {
                    case 0:
                    case "top":
                        break;
                    
                    case 1:
                    case "middle":
                        _area_offset_y += ((_flow_height - outFlowAreaHeight) / 2);
                        break;
                    
                    case 2:
                    case "bottom":
                        _area_offset_y += (_flow_height - outFlowAreaHeight);
                        break;
                    
                    default:
                        __uiError("Flow area vertical alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                var _child_index = 0;
                var _child_grid_x = 0;
                var _child_grid_y = 0;
                var _l = 0;
                
                repeat (array_length(_area_line_array))
                {
                    _line_data = _area_line_array[_l];
                    _line_child_array = _line_data.children;
                    _line_width = _line_data.width;
                    _line_height = _line_data.height;
                    _child_grid_x = 0;
                    var _line_offset_x;
                    
                    switch (flowLineHAlign)
                    {
                        case 0:
                        case "left":
                            _line_offset_x = 0;
                            break;
                        
                        case 1:
                        case "center":
                        case "centre":
                            _line_offset_x = (outFlowAreaWidth - _line_width) / 2;
                            break;
                        
                        case 2:
                        case "right":
                            _line_offset_x = outFlowAreaWidth - _line_width;
                            break;
                        
                        default:
                            __uiError("Flow line horizontal alignment \"", flowLineHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                            break;
                    }
                    
                    _x = _area_offset_x + _line_offset_x + _line_data.x;
                    _y = _area_offset_y + _line_data.y;
                    var _c = 0;
                    
                    repeat (array_length(_line_child_array))
                    {
                        with (_line_child_array[_c])
                        {
                            var _offset;
                            
                            switch (other.flowLineVAlign)
                            {
                                case 0:
                                case "top":
                                    _offset = 0;
                                    break;
                                
                                case 1:
                                case "middle":
                                    _offset = (_line_height - __calcHeight) / 2;
                                    break;
                                
                                case 2:
                                case "bottom":
                                    _offset = _line_height - __calcHeight;
                                    break;
                                
                                default:
                                    __uiError("Flow line vertical alignment \"", flowLineVAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                                    break;
                            }
                            
                            __calcOffsetX += _x;
                            __calcOffsetY += (_y + _offset);
                            outFlowIndex = _child_index;
                            outFlowGridX = _child_grid_x;
                            outFlowGridY = _child_grid_y;
                            _x += (__calcWidth + other.flowGutterH);
                            _child_index++;
                        }
                        
                        _c++;
                        _child_grid_x++;
                    }
                    
                    _l++;
                    _child_grid_y++;
                }
            }
            else if (flowDirection == "y")
            {
                if (__calcHeightAuto)
                    __uiTrace("Warning! Using y-first wrap flow, but height was not explicitly defined");
                
                var _i = 0;
                
                repeat (array_length(children))
                {
                    var _child_tag = children[_i];
                    var _child = __uiElementFind(_child_tag);
                    
                    if ((_y + _child.__calcHeight) > _flow_height)
                    {
                        if (_y != 0 || _child.__calcHeight <= _flow_height)
                        {
                            _line_data.width = _line_width;
                            _line_data.height = _line_height;
                            outFlowAreaWidth = max(outFlowAreaWidth, _x + _line_width);
                            outFlowAreaHeight = max(outFlowAreaHeight, _line_height);
                            _y = 0;
                            _x += (_line_width + flowGutterH);
                            _line_child_array = [];
                            _line_width = 0;
                            _line_height = 0;
                            _line_data = 
                            {
                                children: _line_child_array,
                                x: _x,
                                y: _y,
                                width: undefined,
                                height: undefined
                            };
                            array_push(_area_line_array, _line_data);
                        }
                    }
                    
                    array_push(_line_child_array, _child);
                    outFlowAreaWidth = max(outFlowAreaWidth, _child.__calcWidth);
                    outFlowAreaHeight = max(outFlowAreaHeight, _y + _child.__calcHeight);
                    _y += (_child.__calcHeight + flowGutterV);
                    _i++;
                }
                
                _line_data.width = _line_width;
                _line_data.height = _line_height;
                outFlowAreaWidth = max(outFlowAreaWidth, _x + _line_width);
                outFlowAreaHeight = max(outFlowAreaHeight, _line_height);
                var _area_offset_x = flowMarginLeft;
                var _area_offset_y = flowMarginTop;
                
                switch (flowAreaHAlign)
                {
                    case 0:
                    case "left":
                        break;
                    
                    case 1:
                    case "center":
                    case "centre":
                        _area_offset_x += ((_flow_width - outFlowAreaWidth) / 2);
                        break;
                    
                    case 2:
                    case "right":
                        _area_offset_x += (_flow_width - outFlowAreaWidth);
                        break;
                    
                    default:
                        __uiError("Flow area horizontal alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                switch (flowAreaVAlign)
                {
                    case 0:
                    case "top":
                        break;
                    
                    case 1:
                    case "middle":
                        _area_offset_y += ((_flow_height - outFlowAreaHeight) / 2);
                        break;
                    
                    case 2:
                    case "bottom":
                        _area_offset_y += (_flow_height - outFlowAreaHeight);
                        break;
                    
                    default:
                        __uiError("Flow area vertical alignment \"", flowAreaHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                        break;
                }
                
                var _child_index = 0;
                var _child_grid_x = 0;
                var _child_grid_y = 0;
                var _l = 0;
                
                repeat (array_length(_area_line_array))
                {
                    _line_data = _area_line_array[_l];
                    _line_child_array = _line_data.children;
                    _line_width = _line_data.width;
                    _line_height = _line_data.height;
                    _child_grid_y = 0;
                    var _line_offset_y;
                    
                    switch (flowLineVAlign)
                    {
                        case 0:
                        case "top":
                            _line_offset_y = 0;
                            break;
                        
                        case 1:
                        case "middle":
                            _line_offset_y = (outFlowAreaHeight - _line_height) / 2;
                            break;
                        
                        case 2:
                        case "bottom":
                            _line_offset_y = outFlowAreaHeight - _line_height;
                            break;
                        
                        default:
                            __uiError("Flow line vertical alignment \"", flowLineVAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                            break;
                    }
                    
                    _x = _area_offset_x + _line_data.x;
                    _y = _area_offset_y + _line_offset_y + _line_data.y;
                    var _c = 0;
                    
                    repeat (array_length(_line_child_array))
                    {
                        with (_line_child_array[_c])
                        {
                            var _offset;
                            
                            switch (other.flowLineHAlign)
                            {
                                case 0:
                                case "left":
                                    _offset = 0;
                                    break;
                                
                                case 1:
                                case "center":
                                case "centre":
                                    _offset = (_line_width - __calcWidth) / 2;
                                    break;
                                
                                case 2:
                                case "right":
                                    _offset = _line_width - __calcWidth;
                                    break;
                                
                                default:
                                    __uiError("Flow line horizontal alignment \"", flowLineHAlign, "\" not recognised\n(element=\"", tagPath, "\")");
                                    break;
                            }
                            
                            __calcOffsetX += (_x + _offset);
                            __calcOffsetY += _y;
                            outFlowIndex = _child_index;
                            outFlowGridX = _child_grid_x;
                            outFlowGridY = _child_grid_y;
                            _y += (__calcHeight + other.flowGutterV);
                            _child_index++;
                        }
                        
                        _c++;
                        _child_grid_y++;
                    }
                    
                    _l++;
                    _child_grid_x++;
                }
            }
            else
            {
                __uiError("Flow direction \"", flowDirection, "\" not supported for flow style \"", flowStyle, "\"\n(element=\"", tagPath, "\")");
            }
        }
        else if (flowStyle == undefined)
        {
            outFlowWidth = outShapeWidth;
            outFlowHeight = outShapeHeight;
        }
        else
        {
            __uiError("Flow style \"", flowStyle, "\" not supported\n(element=\"", tagPath, "\")");
        }
    };
    
    static __finalizeShape = function()
    {
        var _parent = __uiElementFind(parentTag);
        __calcOffsetX += (_parent.outShapeLeft + _parent.scrollX);
        __calcOffsetY += (_parent.outShapeTop + _parent.scrollY);
        outShapeWidth = __calcWidth;
        outShapeHeight = __calcHeight;
        outShapeWidthAuto = __calcWidthAuto;
        outShapeHeightAuto = __calcHeightAuto;
        outShapeXCenter = __calcCenterX + __calcOffsetX;
        outShapeYCenter = __calcCenterY + __calcOffsetY;
        outShapeLeft = __calcLeft + __calcOffsetX;
        outShapeTop = __calcTop + __calcOffsetY;
        outShapeRight = __calcRight + __calcOffsetX;
        outShapeBottom = __calcBottom + __calcOffsetY;
        __calculateScrollArea();
        __finalizeChildShapes();
    };
    
    static __finalizeChildShapes = function()
    {
        var _i = 0;
        
        repeat (array_length(children))
        {
            var _child_tag = children[_i];
            var _child = __uiElementFind(_child_tag);
            _child.__finalizeShape();
            _i++;
        }
    };
    
    static __findTotalChildWidth = function(arg0, arg1)
    {
        var _total = 0;
        var _i = 0;
        
        repeat (array_length(children))
        {
            var _child_tag = children[_i];
            var _child = __uiElementFind(_child_tag);
            _total += _child.__calcWidth;
            _i++;
        }
        
        if (arg0)
            _total += (flowMarginLeft + flowMarginRight);
        
        if (arg1)
            _total += (flowGutterH * max(0, array_length(children) - 1));
        
        return _total;
    };
    
    static __findMaxChildWidth = function(arg0)
    {
        var _max = 0;
        var _i = 0;
        
        repeat (array_length(children))
        {
            var _child_tag = children[_i];
            var _child = __uiElementFind(_child_tag);
            _max = max(_max, _child.__calcWidth);
            _i++;
        }
        
        return _max;
    };
    
    static __findTotalChildHeight = function(arg0, arg1)
    {
        var _total = 0;
        var _i = 0;
        
        repeat (array_length(children))
        {
            var _child_tag = children[_i];
            var _child = __uiElementFind(_child_tag);
            _total += _child.__calcHeight;
            _i++;
        }
        
        if (arg0)
            _total += (flowMarginTop + flowMarginBottom);
        
        if (arg1)
            _total += (flowGutterV * max(0, array_length(children) - 1));
        
        return _total;
    };
    
    static __findMaxChildHeight = function()
    {
        var _max = 0;
        var _i = 0;
        
        repeat (array_length(children))
        {
            var _child_tag = children[_i];
            var _child = __uiElementFind(_child_tag);
            _max = max(_max, _child.__calcHeight);
            _i++;
        }
        
        return _max;
    };
    
    static __animTick = function(arg0)
    {
        if (array_length(animQueue) > 0)
        {
            if (arg0)
                animTime += global.__uiTickSize;
            
            var _animation = animQueue[0];
            var _finished = variable_struct_get(__animDict, _animation.name)(_animation.data);
            
            if (_finished == true || animStartTime == undefined)
            {
                var _callback = _animation.callback;
                
                if (is_method(_callback))
                    _callback(_animation.data);
                
                array_delete(animQueue, 0, 1);
                animStartTime = animTime;
                
                if (array_length(animQueue) > 0)
                    __animTick(false);
            }
        }
    };
    
    static __checkVisualCache = function()
    {
        if (!__cacheVisualDirty)
        {
            if (__cacheVisualOffsetX != visXOffset || __cacheVisualOffsetY != visYOffset)
                __cacheVisualDirty = true;
            else
                __cacheVisualDirty = false;
        }
    };
    
    static __calculateVisual = function()
    {
        __checkShapeCache();
        
        if (__cacheShapeDirty)
        {
            __calculateShape();
            __finalizeShape();
        }
        
        __cacheVisualDirty = false;
        __cacheVisualOffsetX = visXOffset;
        __cacheVisualOffsetY = visYOffset;
        var _parent = __uiElementFind(parentTag);
        outVisXOffset = visXOffset + _parent.outVisXOffset;
        outVisYOffset = visYOffset + _parent.outVisYOffset;
        outVisXCenter = outShapeXCenter + outVisXOffset;
        outVisYCenter = outShapeYCenter + outVisYOffset;
        outVisLeft = outShapeLeft + outVisXOffset;
        outVisTop = outShapeTop + outVisYOffset;
        outVisRight = outShapeRight + outVisXOffset;
        outVisBottom = outShapeBottom + outVisYOffset;
        outVisWidth = outShapeWidth;
        outVisHeight = outShapeHeight;
        __calculateChildVisual();
    };
    
    static __calculateChildVisual = function()
    {
        var _i = 0;
        
        repeat (array_length(children))
        {
            var _child_tag = children[_i];
            var _child = __uiElementFind(_child_tag);
            _child.updateVisual();
            _i++;
        }
    };
    
    tagPath = undefined;
    globalTag = undefined;
    parentTag = undefined;
    rootTag = undefined;
    children = [];
    data = undefined;
    rootInstance = undefined;
    scrollAllow = false;
    scrollSpeed = global.__uiScrollTweenSpeed;
    scrollTargetX = 0;
    scrollX = 0;
    scrollXMinOffset = 0;
    scrollXMaxOffset = 0;
    scrollTargetY = 0;
    scrollY = 0;
    scrollYMinOffset = 0;
    scrollYMaxOffset = 0;
    scrollCursorWait = 0;
    scrollCursorLastX = undefined;
    scrollCursorLastY = undefined;
    visBlend = 16777215;
    visAlpha = 1;
    visXOffset = 0;
    visYOffset = 0;
    flowWaveSize = 0;
    flowStyle = undefined;
    flowDirection = undefined;
    flowAreaHAlign = "center";
    flowAreaVAlign = "middle";
    flowLineHAlign = "center";
    flowLineVAlign = "middle";
    flowMarginLeft = 0;
    flowMarginTop = 0;
    flowMarginRight = 0;
    flowMarginBottom = 0;
    flowGutterH = 0;
    flowGutterV = 0;
    flowGridXCount = 5;
    flowGridYCount = undefined;
    clipChildrenAllow = false;
    outShapeClipLeft = -999999999;
    outShapeClipTop = -999999999;
    outShapeClipRight = 999999999;
    outShapeClipBottom = 999999999;
    outCursorInside = false;
    outCursorTop = false;
    outCursorClick = false;
    outCursorBack = false;
    outCursorDrag = false;
    outFlowAreaWidth = 0;
    outFlowAreaHeight = 0;
    outFlowWidth = 0;
    outFlowHeight = 0;
    outFlowIndex = 0;
    outFlowGridX = 0;
    outFlowGridY = 0;
    animTime = 0;
    animStartTime = 0;
    animQueue = [];
    shapeXCenter = undefined;
    shapeYCenter = undefined;
    shapeLeft = undefined;
    shapeTop = undefined;
    shapeRight = undefined;
    shapeBottom = undefined;
    shapeWidth = undefined;
    shapeHeight = undefined;
    outShapeXCenter = 0;
    outShapeYCenter = 0;
    outShapeLeft = 0;
    outShapeTop = 0;
    outShapeRight = 0;
    outShapeBottom = 0;
    outShapeWidth = 0;
    outShapeHeight = 0;
    outShapeWidthAuto = false;
    outShapeHeightAuto = false;
    visDraw = true;
    visDrawChildren = true;
    gestureAllow = true;
    gestureChildrenAllow = true;
    outVisXOffset = 0;
    outVisYOffset = 0;
    outVisXCenter = 0;
    outVisYCenter = 0;
    outVisLeft = 0;
    outVisTop = 0;
    outVisRight = 0;
    outVisBottom = 0;
    outVisWidth = 0;
    outVisHeight = 0;
    __calcOffsetX = 0;
    __calcOffsetY = 0;
    __calcCenterX = 0;
    __calcCenterY = 0;
    __calcLeft = 0;
    __calcTop = 0;
    __calcRight = 0;
    __calcBottom = 0;
    __calcWidth = 0;
    __calcHeight = 0;
    __calcWidthAuto = false;
    __calcHeightAuto = false;
    __scrollXMin = 0;
    __scrollXMax = 0;
    __scrollYMin = 0;
    __scrollYMax = 0;
    __cacheShapeDirty = true;
    __cacheShapeCenterX = 0;
    __cacheShapeCenterY = 0;
    __cacheShapeLeft = 0;
    __cacheShapeTop = 0;
    __cacheShapeRight = 0;
    __cacheShapeBottom = 0;
    __cacheShapeWidth = 0;
    __cacheShapeHeight = 0;
    __cacheShapeFlowStyle = undefined;
    __cacheShapeFlowDirection = undefined;
    __cacheShapeFlowAreaHAlign = "center";
    __cacheShapeFlowAreaVAlign = "middle";
    __cacheShapeFlowLineHAlign = "center";
    __cacheShapeFlowLineVAlign = "middle";
    __cacheShapeFlowMarginLeft = 0;
    __cacheShapeFlowMarginTop = 0;
    __cacheShapeFlowMarginRight = 0;
    __cacheShapeFlowMarginBottom = 0;
    __cacheShapeFlowGutterX = 0;
    __cacheShapeFlowGutterY = 0;
    __cacheShapeScrollX = 0;
    __cacheShapeScrollY = 0;
    __cacheVisualDirty = true;
    __cacheVisualOffsetX = 0;
    __cacheVisualOffsetY = 0;
    __eventsArray = array_create(UnknownEnum.Value_24, undefined);
    var _i = 0;
    
    repeat (UnknownEnum.Value_24)
    {
        array_set(__eventsArray, _i, []);
        _i++;
    }
    
    __animDict = {};
    
    if (!variable_global_exists("__uiNullElement"))
    {
        __rootCursorButtonState = undefined;
        __rootCursorClickState = undefined;
        __rootCursorBackState = undefined;
        __rootCursorGesture = "none";
        __rootCursorEvent = "off";
        __rootGamepadLastFocus = -1;
        __rootPrevElement = undefined;
        __rootPrevTopElement = undefined;
        __rootDragTime = -1;
        __rootDragLastX = 0;
        __rootDragLastY = 0;
        __rootGroupDict = {};
    }
    else
    {
        __rootCursorButtonState = undefined;
        __rootCursorClickState = undefined;
        __rootCursorBackState = undefined;
        __rootCursorGesture = "none";
        __rootCursorEvent = "off";
        __rootGamepadLastFocus = -1;
        __rootPrevElement = global.__uiNullElement;
        __rootPrevTopElement = global.__uiNullElement;
        __rootDragTime = -1;
        __rootDragLastX = 0;
        __rootDragLastY = 0;
        __rootGroupDict = {};
    }
    
    __callOnOffEvents = function(arg0)
    {
        __callEvent(outCursorInside ? UnknownEnum.Value_5 : UnknownEnum.Value_7);
        __callEvent(outCursorClick ? UnknownEnum.Value_9 : UnknownEnum.Value_11);
        __callEvent(outCursorBack ? UnknownEnum.Value_13 : UnknownEnum.Value_15);
        
        if (!outCursorDrag)
            __callEvent(UnknownEnum.Value_19, 0, 0);
        
        if (arg0)
        {
            var _i = 0;
            
            repeat (array_length(children))
            {
                __uiElementFind(children[_i]).__callOnOffEvents(arg0);
                _i++;
            }
        }
    };
}
