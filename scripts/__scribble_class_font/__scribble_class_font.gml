function __scribble_class_font(arg0) constructor
{
    static copy_to = function(arg0)
    {
        var _names = variable_struct_get_names(self);
        var _i = 0;
        
        repeat (array_length(_names))
        {
            var _name = _names[_i];
            
            if (_name != "name" && _name != "glyphs_map")
                variable_struct_set(arg0, _name, variable_struct_get(self, _name));
            
            _i++;
        }
    };
    
    static calculate_font_height = function()
    {
        height = yscale * array_get(glyphs_map[? 32], UnknownEnum.Value_3);
        return height;
    };
    
    static clear = function()
    {
        if (!collage)
            __scribble_error("Cannot clear non-collage fonts");
        
        ds_map_clear(glyphs_map);
        msdf_pxrange = undefined;
        msdf = undefined;
        height = 0;
    };
    
    global.__scribble_font_data[? arg0] = self;
    name = arg0;
    glyphs_map = ds_map_create();
    collage = false;
    msdf_pxrange = undefined;
    msdf = undefined;
    xscale = 1;
    yscale = 1;
    scale_dist = 1;
    height = 0;
    style_regular = undefined;
    style_bold = undefined;
    style_italic = undefined;
    style_bold_italic = undefined;
}
