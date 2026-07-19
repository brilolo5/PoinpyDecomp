function haptic(arg0)
{
    if (global.hapticEnabled)
    {
        switch (arg0)
        {
            case "pop":
                if (os_type == os_ios)
                    extension_stubfunc_real();
                else if (os_type == os_android)
                    AndroidRumbleTick();
                
                break;
            
            case "peek":
                if (os_type == os_ios)
                    extension_stubfunc_real();
                else if (os_type == os_android)
                    AndroidRumbleClick();
                
                break;
            
            case "click 2":
                if (os_type == os_ios)
                    extension_stubfunc_real(1161);
                else if (os_type == os_android)
                    AndroidRumbleDoubleClick();
                
                break;
            
            default:
                if (os_type == os_ios)
                    extension_stubfunc_real();
                else if (os_type == os_android)
                    AndroidRumbleTick();
                
                break;
        }
    }
}
