function __scribble_class_page() constructor
{
    static __get_vertex_buffer = function(arg0, arg1, arg2, arg3)
    {
        var _pointer_string = string(arg0);
        var _data = variable_struct_get(__texture_to_vertex_buffer_dict, _pointer_string);
        
        if (_data == undefined)
        {
            var _font_msdf_pxrange;
            
            if (is_struct(arg1))
                _font_msdf_pxrange = arg1.msdf_pxrange;
            else
                _font_msdf_pxrange = undefined;
            
            var _shader;
            
            if (_font_msdf_pxrange == undefined)
            {
                arg3.uses_standard_font = true;
                _shader = __shd_scribble;
            }
            else
            {
                arg3.uses_msdf_font = true;
                _shader = __shd_scribble_msdf;
            }
            
            var _vbuff = vertex_create_buffer();
            vertex_begin(_vbuff, global.__scribble_vertex_format);
            _data = array_create(UnknownEnum.Value_6);
            array_set(_data, UnknownEnum.Value_0, _vbuff);
            array_set(_data, UnknownEnum.Value_1, arg0);
            array_set(_data, UnknownEnum.Value_2, _font_msdf_pxrange);
            array_set(_data, UnknownEnum.Value_3, texture_get_texel_width(arg0));
            array_set(_data, UnknownEnum.Value_4, texture_get_texel_height(arg0));
            array_set(_data, UnknownEnum.Value_5, _shader);
            __scribble_gc_add_vbuff(self, _vbuff);
            array_set(__vertex_buffer_array, array_length(__vertex_buffer_array), _data);
            variable_struct_set(__texture_to_vertex_buffer_dict, _pointer_string, _data);
            return _vbuff;
        }
        else
        {
            return _data[UnknownEnum.Value_0];
        }
    };
    
    static __finalize_vertex_buffers = function(arg0)
    {
        var _i = 0;
        
        repeat (array_length(__vertex_buffer_array))
        {
            var _vbuff = __vertex_buffer_array[_i][UnknownEnum.Value_0];
            vertex_end(_vbuff);
            
            if (arg0)
                vertex_freeze(_vbuff);
            
            _i++;
        }
    };
    
    static __flush = function()
    {
        var _i = 0;
        
        repeat (array_length(__vertex_buffer_array))
        {
            var _vbuff = __vertex_buffer_array[_i][UnknownEnum.Value_0];
            vertex_delete_buffer(_vbuff);
            __scribble_gc_remove_vbuff(_vbuff);
            _i++;
        }
        
        __texture_to_vertex_buffer_dict = {};
        array_resize(__vertex_buffer_array, 0);
    };
    
    static __submit = function(arg0, arg1)
    {
        var _shader = undefined;
        var _i = 0;
        
        repeat (array_length(__vertex_buffer_array))
        {
            var _data = __vertex_buffer_array[_i];
            
            if (_data[UnknownEnum.Value_5] != _shader)
            {
                _shader = _data[UnknownEnum.Value_5];
                shader_set_track(_shader);
            }
            
            if (_shader == __shd_scribble_msdf)
            {
                var _old_tex_filter = gpu_get_tex_filter();
                gpu_set_tex_filter(true);
                shader_set_uniform_f(global.__scribble_msdf_u_vTexel, _data[UnknownEnum.Value_3], _data[UnknownEnum.Value_4]);
                shader_set_uniform_f(global.__scribble_msdf_u_fMSDFRange, arg0.msdf_feather_thickness * _data[UnknownEnum.Value_2]);
                vertex_submit(_data[UnknownEnum.Value_0], pr_trianglelist, _data[UnknownEnum.Value_1]);
                
                if (arg1)
                {
                    shader_set_uniform_f(global.__scribble_msdf_u_fSecondDraw, 1);
                    vertex_submit(_data[UnknownEnum.Value_0], pr_trianglelist, _data[UnknownEnum.Value_1]);
                    shader_set_uniform_f(global.__scribble_msdf_u_fSecondDraw, 0);
                }
                
                gpu_set_tex_filter(_old_tex_filter);
            }
            else
            {
                vertex_submit(_data[UnknownEnum.Value_0], pr_trianglelist, _data[UnknownEnum.Value_1]);
            }
            
            _i++;
        }
        
        shader_reset_track();
    };
    
    __text = "";
    __character_count = 0;
    __glyph_start = undefined;
    __glyph_end = undefined;
    __vertex_buffer_array = [];
    __texture_to_vertex_buffer_dict = {};
    __events = {};
}
