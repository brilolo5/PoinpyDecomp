function initializeWindow(arg0)
{
    global.viewWidth = 160;
    global.viewHeight = 346;
    var _deviceHeight = display_get_height();
    var _deviceWidth = display_get_width();
    var _simulate_ios = false;
    
    if (_simulate_ios || global.debugForceShorterPortraitScreen)
    {
        _simulate_ios = 1;
        _deviceHeight = 1136;
    }
    
    global.notchOffset = 0;
    
    if ((os_type == os_ios || _simulate_ios) || os_type == os_android)
    {
        global.hapticAvailable = os_type == os_ios;
        var _aspectRatio = _deviceHeight / _deviceWidth;
        global.viewHeight = round(global.viewWidth * _aspectRatio);
        global.viewHeight = clamp(global.viewHeight, 284, 346);
        var _displayAspectRatio = display_get_height() / display_get_width();
        
        if (_displayAspectRatio < 1.7777777777777777)
        {
            global.viewHeight = 346;
            global.hapticAvailable = false;
        }
        
        if (abs(_aspectRatio - 2.1666666666666665) < 0.1)
            global.notchOffset = 12;
        
        global.hapticEnabled = global.hapticAvailable;
    }
    
    if (global.debugForceShorterPortraitScreen)
        global.viewHeight = 284;
    
    if (arg0)
        display_set_gui_size(global.viewWidth, global.viewHeight);
    
    var _windowScale = 6;
    var _windowWidth = global.viewWidth * _windowScale;
    var _windowHeight = global.viewHeight * _windowScale;
    _windowWidth = clamp(_windowWidth, global.viewWidth, display_get_width());
    _windowHeight = clamp(_windowHeight, global.viewHeight, display_get_height());
    window_set_size(_windowWidth, _windowHeight);
    
    if (os_type == os_ios || os_type == os_android)
        surface_resize_track(application_surface, global.viewWidth * 10, global.viewHeight * 10);
    
    if (os_type == os_macosx || os_type == os_windows)
    {
        surface_resize_track(application_surface, global.viewWidth * 10, global.viewHeight * 10);
        var _deviceAspectRatio = _deviceWidth / _deviceHeight;
        _deviceAspectRatio = 4/3;
        _windowWidth = _windowHeight * _deviceAspectRatio;
        
        if (global.userWindowWidth != -1)
        {
            _windowWidth = global.userWindowWidth;
            _windowHeight = global.userWindowHeight;
        }
        
        window_set_size(_windowWidth, _windowHeight);
        windowCenter(_windowWidth, _windowHeight);
    }
}
