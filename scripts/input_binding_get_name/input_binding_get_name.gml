function input_binding_get_name(arg0)
{
    if (!input_value_is_binding(arg0))
        return undefined;
    
    with (arg0)
    {
        switch (type)
        {
            case "key":
                if (value >= 65 && value <= 90)
                {
                    return chr(value);
                }
                else if (value >= 112 && value <= 123)
                {
                    return "F" + string((1 + value) - 112);
                }
                else if (value >= 48 && value <= 57)
                {
                    return chr(value);
                }
                else
                {
                    switch (value)
                    {
                        case 186:
                            return ";";
                            break;
                        
                        case 187:
                            return "=";
                            break;
                        
                        case 188:
                            return ",";
                            break;
                        
                        case 189:
                            return "-";
                            break;
                        
                        case 190:
                            return ".";
                            break;
                        
                        case 191:
                            return "/";
                            break;
                        
                        case 192:
                            return "'";
                            break;
                        
                        case 219:
                            return "[";
                            break;
                        
                        case 220:
                            return "\\";
                            break;
                        
                        case 221:
                            return "]";
                            break;
                        
                        case 222:
                            return "#";
                            break;
                        
                        case 223:
                            return "`";
                            break;
                        
                        case 96:
                            return "numpad 0";
                            break;
                        
                        case 97:
                            return "numpad 1";
                            break;
                        
                        case 98:
                            return "numpad 2";
                            break;
                        
                        case 99:
                            return "numpad 3";
                            break;
                        
                        case 100:
                            return "numpad 4";
                            break;
                        
                        case 101:
                            return "numpad 5";
                            break;
                        
                        case 102:
                            return "numpad 6";
                            break;
                        
                        case 103:
                            return "numpad 7";
                            break;
                        
                        case 104:
                            return "numpad 8";
                            break;
                        
                        case 105:
                            return "numpad 9";
                            break;
                        
                        case 111:
                            return "numpad /";
                            break;
                        
                        case 110:
                            return "numpad .";
                            break;
                        
                        case 106:
                            return "numpad *";
                            break;
                        
                        case 107:
                            return "numpad +";
                            break;
                        
                        case 109:
                            return "numpad -";
                            break;
                        
                        case 161:
                            return "right shift";
                            break;
                        
                        case 160:
                            return "left shift";
                            break;
                        
                        case 16:
                            return "shift";
                            break;
                        
                        case 163:
                            return "right ctrl";
                            break;
                        
                        case 162:
                            return "left ctrl";
                            break;
                        
                        case 17:
                            return "ctrl";
                            break;
                        
                        case 165:
                            return "right alt";
                            break;
                        
                        case 164:
                            return "left alt";
                            break;
                        
                        case 18:
                            return "alt";
                            break;
                        
                        case 38:
                            return "arrow up";
                            break;
                        
                        case 40:
                            return "arrow down";
                            break;
                        
                        case 37:
                            return "arrow left";
                            break;
                        
                        case 39:
                            return "arrow right";
                            break;
                        
                        case 27:
                            return "escape";
                            break;
                        
                        case 8:
                            return "backspace";
                            break;
                        
                        case 32:
                            return "space";
                            break;
                        
                        case 9:
                            return "tab";
                            break;
                        
                        case 13:
                            return "enter";
                            break;
                        
                        case 36:
                            return "home";
                            break;
                        
                        case 35:
                            return "end";
                            break;
                        
                        case 45:
                            return "insert";
                            break;
                        
                        case 46:
                            return "delete";
                            break;
                        
                        case 34:
                            return "page down";
                            break;
                        
                        case 33:
                            return "page up";
                            break;
                        
                        case 44:
                            return "print screen";
                            break;
                        
                        case 19:
                            return "pause break";
                            break;
                        
                        case 12:
                            return "clear";
                            break;
                        
                        case 20:
                            return "capslock";
                            break;
                        
                        case 91:
                            return "windows";
                            break;
                        
                        case 93:
                            return "menu";
                            break;
                        
                        case 144:
                            return "numlock";
                            break;
                        
                        case 145:
                            return "scrolll lock";
                            break;
                    }
                    
                    return chr(value);
                }
                
                break;
            
            case "mouse button":
                switch (value)
                {
                    case 1:
                        return "mouse button left";
                        break;
                    
                    case 3:
                        return "mouse button middle";
                        break;
                    
                    case 2:
                        return "mouse button right";
                        break;
                    
                    default:
                        return "mouse button unknown";
                        break;
                }
                
                break;
            
            case "mouse wheel up":
                return "mouse wheel up";
                break;
            
            case "mouse wheel down":
                return "mouse wheel down";
                break;
            
            case "gamepad button":
                switch (value)
                {
                    case 32769:
                        return "gamepad button a";
                        break;
                    
                    case 32770:
                        return "gamepad button b";
                        break;
                    
                    case 32771:
                        return "gamepad button x";
                        break;
                    
                    case 32772:
                        return "gamepad button y";
                        break;
                    
                    case 32773:
                        return "gamepad button shoulder l";
                        break;
                    
                    case 32774:
                        return "gamepad button shoulder r";
                        break;
                    
                    case 32775:
                        return "gamepad button trigger l";
                        break;
                    
                    case 32776:
                        return "gamepad button trigger b";
                        break;
                    
                    case 32777:
                        return "gamepad button select";
                        break;
                    
                    case 32778:
                        return "gamepad button start";
                        break;
                    
                    case 32779:
                        return "gamepad button thumbstick l click";
                        break;
                    
                    case 32780:
                        return "gamepad button thumbstick r click";
                        break;
                    
                    case 32781:
                        return "gamepad button dpad up";
                        break;
                    
                    case 32782:
                        return "gamepad button dpad down";
                        break;
                    
                    case 32783:
                        return "gamepad button dpad left";
                        break;
                    
                    case 32784:
                        return "gamepad button dpad right";
                        break;
                    
                    case 32789:
                        return "gamepad button guide";
                        break;
                    
                    case 32790:
                        return "gamepad button misc 1";
                        break;
                    
                    case 32785:
                        return axis_negative ? "gamepad button thumbstick l left" : "gamepad button thumbstick l right";
                        break;
                    
                    case 32786:
                        return axis_negative ? "gamepad button thumbstick l up" : "gamepad button thumbstick l down";
                        break;
                    
                    case 32787:
                        return axis_negative ? "gamepad button thumbstick l left" : "gamepad button thumbstick l right";
                        break;
                    
                    case 32788:
                        return axis_negative ? "gamepad button thumbstick l up" : "gamepad button thumbstick l down";
                        break;
                    
                    default:
                        return "gamepad button unknown";
                        break;
                }
                
                break;
            
            case "gamepad axis":
                switch (value)
                {
                    case 32775:
                        return "gamepad axis trigger l";
                        break;
                    
                    case 32776:
                        return "gamepad axis trigger b";
                        break;
                    
                    case 32785:
                        return axis_negative ? "gamepad axis thumbstick l left" : "gamepad axis thumbstick l right";
                        break;
                    
                    case 32786:
                        return axis_negative ? "gamepad axis thumbstick l up" : "gamepad axis thumbstick l down";
                        break;
                    
                    case 32787:
                        return axis_negative ? "gamepad axis thumbstick r left" : "gamepad axis thumbstick r right";
                        break;
                    
                    case 32788:
                        return axis_negative ? "gamepad axis thumbstick r up" : "gamepad axis thumbstick r down";
                        break;
                    
                    default:
                        return "gamepad axis unknown";
                        break;
                }
                
                break;
        }
    }
}
