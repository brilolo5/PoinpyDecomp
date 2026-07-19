pauseStart();
var _buttonHeight = 17;
draw_set_halign(fa_left);
draw_set_valign(fa_top);

with (uiCreate("service root"))
{
    eventAddFunction(UnknownEnum.Value_0, function()
    {
        setLTRBToWindow();
    });
    updateShape();
    eventAddFunction(UnknownEnum.Value_14, function()
    {
        instance_destroy(rootInstance);
        instance_create_depth(0, 0, 0, oPauseMenu);
    });
    eventAddFunction(UnknownEnum.Value_2, function()
    {
        if (rootInstance.previousSignInState == 0)
            scribble("[wave][rainbow]Signing In...").align(1, 1).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).msdf_border(make_color_rgb(46, 50, 59), 3).draw(getDrawX(), getDrawY());
    });
    
    with (newChild("service sign in text", "service sign in group"))
    {
        text = "[scale,0.5]" + loc((os_type == os_ios) ? "service text GC" : "service text GPS");
        visBlend = make_color_rgb(255, 255, 255);
        borderColor = make_color_rgb(46, 50, 59);
        borderThickness = 4;
        textElement = scribble(text).align(1, 0).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).wrap(getParent().getShapeWidth() - 16);
        setX(getParent().getShapeWidth() / 2);
        setY((getParent().getShapeHeight() / 2) - 30);
        setWidth(textElement.get_width());
        setHeight(textElement.get_height());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            textElement.blend(visBlend, visAlpha).msdf_border(borderColor, borderThickness).draw(getDrawX(), getDrawTop());
        });
        updateShape();
    }
    
    with (newChild("service sign in", "service sign in group"))
    {
        uiTemplateButtonLimit(loc("service sign in button"), 1.3, getParent().getShapeWidth() - 70);
        setHeight(_buttonHeight);
        setX(getParent().getShapeWidth() / 2);
        setTop(uiGet("service sign in text").getShapeBottom() + 20);
        updateShape();
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            rootInstance.alarm[0] = 25;
            rootInstance.previousSignInState = 0;
            uiGroupDeactivate("service root", "service sign in group");
            uiGroupDeactivate("service root", "service retry group");
        });
    }
    
    with (newChild("service back", "service sign in group"))
    {
        uiTemplateButtonLimit(loc("service back button"), 1.3, getParent().getShapeWidth() - 70);
        setHeight(_buttonHeight);
        setX(getParent().getShapeWidth() / 2);
        setTop(uiGet("service sign in").getShapeBottom() + 10);
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            instance_destroy(rootInstance);
            instance_create_depth(0, 0, 0, oPauseMenu);
        });
    }
    
    with (newChild("service retry text", "service retry group"))
    {
        text = "[scale,0.5]" + loc("service text retry");
        visBlend = make_color_rgb(255, 255, 255);
        borderColor = make_color_rgb(46, 50, 59);
        borderThickness = 4;
        textElement = scribble(text).align(1, 0).starting_format(locGetFontFromLanguage(), make_color_rgb(255, 255, 255)).wrap(getParent().getShapeWidth() - 16);
        setX(getParent().getShapeWidth() / 2);
        setY((getParent().getShapeHeight() / 2) - 30);
        setWidth(textElement.get_width());
        setHeight(textElement.get_height());
        eventAddFunction(UnknownEnum.Value_2, function()
        {
            textElement.blend(visBlend, visAlpha).msdf_border(borderColor, borderThickness).draw(getDrawX(), getDrawTop());
        });
        updateShape();
    }
    
    with (newChild("service retry button", "service retry group"))
    {
        uiTemplateButtonLimit(loc("service retry button"), 1.3, getParent().getShapeWidth() - 70);
        setHeight(_buttonHeight);
        setX(getParent().getShapeWidth() / 2);
        setTop(uiGet("service sign in text").getShapeBottom() + 20);
        updateShape();
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            rootInstance.alarm[0] = 25;
            rootInstance.previousSignInState = 0;
            uiGroupDeactivate("service root", "service sign in group");
            uiGroupDeactivate("service root", "service retry group");
        });
    }
    
    with (newChild("service retry back", "service retry group"))
    {
        uiTemplateButtonLimit(loc("service back button"), 1.3, getParent().getShapeWidth() - 70);
        setHeight(_buttonHeight);
        setX(getParent().getShapeWidth() / 2);
        setTop(uiGet("service sign in").getShapeBottom() + 10);
        eventAddFunction(UnknownEnum.Value_10, function()
        {
            instance_destroy(rootInstance);
            instance_create_depth(0, 0, 0, oPauseMenu);
        });
    }
}

previousSignInState = leaderboardsLoginState();

if (previousSignInState == 0)
    uiGroupDeactivate("service root", "service sign in group");

uiGroupDeactivate("service root", "service retry group");
