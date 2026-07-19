function room_pack_store_instances(arg0)
{
    global.room_pack_raw_store_instances = arg0;
}

function room_pack_store_tilemaps(arg0, arg1 = false)
{
    global.room_pack_raw_store_tilemaps = arg0;
    global.room_pack_raw_store_tilemaps_ext = arg1;
}

function room_pack_store_backgrounds(arg0)
{
    global.room_pack_raw_store_backgrounds = arg0;
}

function room_pack_store_sprites(arg0)
{
    global.room_pack_raw_store_sprites = arg0;
}

function room_pack_include_layer(arg0)
{
    global.room_pack_raw_include_layers_on = true;
    global.room_pack_raw_include_layers[? arg0] = true;
}

function room_pack_exclude_layer(arg0)
{
    global.room_pack_raw_exclude_layers[? arg0] = true;
}

function room_pack_load_map(arg0, arg1 = 0, arg2 = 0, arg3 = 46)
{
    global.room_pack_raw_apply_settings = (arg3 & 1) != 0;
    global.room_pack_raw_apply_instances = (arg3 & 2) != 0;
    global.room_pack_raw_apply_backgrounds = (arg3 & 4) != 0;
    global.room_pack_raw_apply_tiles = (arg3 & 8) != 0;
    global.room_pack_raw_apply_views = (arg3 & 16) != 0;
    global.room_pack_raw_room_x = arg1;
    global.room_pack_raw_room_y = arg2;
    global.room_pack_raw_apply_sprites = (arg3 & 32) != 0;
    room_pack_raw_run_impl2(arg0);
    global.room_pack_raw_store_tilemaps = undefined;
    global.room_pack_raw_store_backgrounds = undefined;
    global.room_pack_raw_store_sprites = undefined;
    ds_map_clear(global.room_pack_raw_include_layers);
    global.room_pack_raw_include_layers_on = false;
    ds_map_clear(global.room_pack_raw_exclude_layers);
    global.room_pack_raw_store_instances = undefined;
}

function room_pack_load_string(arg0, arg1 = 0, arg2 = 0, arg3 = 46)
{
    var l_raw1 = json_decode(arg0);
    
    if (l_raw1 == -1)
        return false;
    
    room_pack_load_map(l_raw1, arg1, arg2, arg3);
    ds_map_destroy(l_raw1);
    return true;
}

function room_pack_load_file(arg0, arg1 = 0, arg2 = 0, arg3 = 46)
{
    if (file_exists(arg0))
    {
        var l_buf = buffer_load(arg0);
        
        if (l_buf == -1)
            return false;
        
        var l_z = room_pack_load_string(buffer_read(l_buf, buffer_string), arg1, arg2, arg3);
        buffer_delete(l_buf);
        return l_z;
    }
    else
    {
        return false;
    }
}

function room_pack_raw_run_cc(arg0, arg1)
{
    global.room_pack_eval_script(arg0, arg1);
}

function room_pack_raw_init_physics(arg0)
{
    if (arg0 == undefined)
        return 0;
    
    if (arg0[? "PhysicsWorld"])
    {
        global.room_pack_raw_use_physics = true;
        physics_world_create(arg0[? "PhysicsWorldPixToMeters"]);
        physics_world_gravity(arg0[? "PhysicsWorldGravityX"], arg0[? "PhysicsWorldGravityY"]);
    }
    else
    {
        global.room_pack_raw_use_physics = false;
    }
}

function room_pack_raw_anim_speed(arg0, arg1)
{
    if (arg1 == "0")
        return arg0 / room_speed;
    else
        return arg0;
}

function room_pack_raw_run_yy_inst_cc(arg0, arg1)
{
    with (arg0)
    {
        var l_rname = arg1[? "name"];
        event_perform(ev_pre_create, 0);
        var l_rcc = arg1[? "propertyCode"];
        
        if (l_rcc != undefined && l_rcc != "")
            room_pack_raw_run_cc(l_rcc, l_rname + ":Properties");
        
        event_perform(ev_create, 0);
        l_rcc = arg1[? "creationCode"];
        
        if (l_rcc != undefined && l_rcc != "")
            room_pack_raw_run_cc(l_rcc, l_rname + ":CreationCode");
    }
}

function room_pack_raw_add_layer(arg0)
{
    var l_ql_depth = arg0[? "depth"];
    var l_ql_name = arg0[? "name"];
    
    if (global.room_pack_raw_include_layers_on && !ds_map_exists(global.room_pack_raw_include_layers, l_ql_name))
        return 0;
    
    if (ds_map_exists(global.room_pack_raw_exclude_layers, l_ql_name))
        return 0;
    
    switch (arg0[? "modelName"])
    {
        case "GMRLayer":
            var l_rl = layer_get_id(l_ql_name);
            
            if (l_rl == -1)
            {
                l_rl = layer_create(l_ql_depth, l_ql_name);
                
                if (arg0[? "visible"] != undefined)
                    layer_set_visible(l_rl, arg0[? "visible"]);
            }
            
            var l_sublayers = arg0[? "layers"];
            var l_i = ds_list_size(l_sublayers);
            
            while (--l_i >= 0)
                room_pack_raw_add_layer(l_sublayers[| l_i]);
            
            break;
        
        case "GMRBackgroundLayer":
            if (global.room_pack_raw_apply_backgrounds)
            {
                var l_rl = layer_get_id(l_ql_name);
                
                if (l_rl == -1)
                {
                    l_rl = layer_create(l_ql_depth, l_ql_name);
                    
                    if (arg0[? "visible"] != undefined)
                        layer_set_visible(l_rl, arg0[? "visible"]);
                }
                
                var l_qb = arg0;
                var l_s = l_qb[? "sprite"];
                var l_rb = layer_background_create(l_rl, (l_s != undefined) ? asset_get_index(l_s) : -1);
                var l_aval = l_qb[? "color"];
                
                if (l_aval != undefined)
                {
                    layer_background_blend(l_rb, l_aval & c_white);
                    layer_background_alpha(l_rb, (l_aval >> 24) / 255);
                }
                
                l_aval = l_qb[? "htiled"];
                
                if (l_aval != undefined)
                    layer_background_htiled(l_rb, l_aval);
                else
                    layer_background_htiled(l_rb, true);
                
                l_aval = l_qb[? "vtiled"];
                
                if (l_aval != undefined)
                    layer_background_vtiled(l_rb, l_aval);
                else
                    layer_background_vtiled(l_rb, true);
                
                l_aval = l_qb[? "stretch"];
                
                if (l_aval != undefined)
                    layer_background_stretch(l_rb, l_aval);
                else
                    layer_background_stretch(l_rb, false);
                
                l_aval = l_qb[? "animationFPS"];
                
                if (l_aval != undefined)
                    layer_background_speed(l_rb, room_pack_raw_anim_speed(l_aval, l_qb[? "animationSpeedType"]));
                
                l_aval = l_qb[? "x"];
                
                if (l_aval == undefined)
                    l_aval = 0;
                
                layer_x(l_rl, global.room_pack_raw_room_x + l_aval);
                l_aval = l_qb[? "y"];
                
                if (l_aval == undefined)
                    l_aval = 0;
                
                layer_y(l_rl, global.room_pack_raw_room_y + l_aval);
                var l_list = global.room_pack_raw_store_backgrounds;
                
                if (l_list != undefined)
                    ds_list_add(l_list, l_rb);
            }
            
            break;
        
        case "GMRTileLayer":
            if (global.room_pack_raw_apply_tiles)
            {
                var l_rl = layer_get_id(l_ql_name);
                
                if (l_rl == -1)
                {
                    l_rl = layer_create(l_ql_depth, l_ql_name);
                    
                    if (arg0[? "visible"] != undefined)
                        layer_set_visible(l_rl, arg0[? "visible"]);
                }
                
                var l_qt = arg0;
                var l_qtt = l_qt[? "tiles"];
                var l_qtw = l_qtt[? "SerialiseWidth"];
                var l_qth = l_qtt[? "SerialiseHeight"];
                var l_rt = layer_tilemap_create(l_rl, global.room_pack_raw_room_x + l_qt[? "x"], global.room_pack_raw_room_y + l_qt[? "y"], asset_get_index(l_qt[? "tileset"]), l_qtw, l_qth);
                var l_qtd = l_qtt[? "TileSerialiseData"];
                var l_qti = 0;
                var l_y = 0;
                var l__g1 = l_qth;
                
                while (l_y < l__g1)
                {
                    var l_x = 0;
                    var l__g3 = l_qtw;
                    
                    while (l_x < l__g3)
                    {
                        tilemap_set(l_rt, l_qtd[| l_qti++], l_x, l_y);
                        l_x++;
                    }
                    
                    l_y++;
                }
                
                var l_tms = global.room_pack_raw_store_tilemaps;
                
                if (l_tms != undefined)
                {
                    if (global.room_pack_raw_store_tilemaps_ext)
                        ds_list_add(l_tms, [l_rt, l_rl]);
                    else
                        ds_list_add(l_tms, l_rt);
                }
            }
            
            break;
        
        case "GMRInstanceLayer":
            if (global.room_pack_raw_apply_instances)
            {
                var l_rl = layer_get_id(l_ql_name);
                
                if (l_rl == -1)
                {
                    l_rl = layer_create(l_ql_depth, l_ql_name);
                    
                    if (arg0[? "visible"] != undefined)
                        layer_set_visible(l_rl, arg0[? "visible"]);
                }
                
                var l_qi = arg0;
                var l_rx = global.room_pack_raw_room_x;
                var l_ry = global.room_pack_raw_room_y;
                var l_instances = l_qi[? "instances"];
                var l_n = ds_list_size(l_instances);
                var l_base = global.room_pack_blank_object;
                
                if (l_n != 0)
                {
                    if (!object_exists(l_base))
                        throw "Please add a blank object and set room_pack_blank_object to point at it prior to loading.";
                }
                
                var l_lco = global.room_pack_raw_object_cache;
                var l_i = -1;
                
                while (++l_i < l_n)
                {
                    var l_qinst = l_instances[| l_i];
                    var l_rnext = instance_create_layer(l_rx + l_qinst[? "x"], l_ry + l_qinst[? "y"], l_rl, l_base);
                    var l_qid = l_qinst[? "name"];
                    global.room_pack_raw_inst_map_yy[? l_qid] = l_qinst;
                    global.room_pack_raw_inst_map_gml[? l_qid] = l_rnext;
                    
                    with (l_rnext)
                    {
                        global.room_pack_const_script(l_qinst[? "name"], self);
                        var l_aval = l_qinst[? "rotation"];
                        
                        if (l_aval != undefined)
                            image_angle = l_aval;
                        
                        l_aval = l_qinst[? "scaleX"];
                        
                        if (l_aval != undefined)
                            image_xscale = l_aval;
                        
                        l_aval = l_qinst[? "scaleY"];
                        
                        if (l_aval != undefined)
                            image_yscale = l_aval;
                        
                        l_aval = l_qinst[? "imageIndex"];
                        
                        if (l_aval != undefined)
                            image_index = l_aval;
                        
                        l_aval = l_qinst[? "imageSpeed"];
                        
                        if (l_aval != undefined)
                            image_speed = l_aval;
                        
                        var l_f = l_qinst[? "color"];
                        
                        if (l_f != undefined)
                        {
                            image_blend = l_f & c_white;
                            image_alpha = (l_f >> 24) / 255;
                        }
                        
                        var l_s = l_qinst[? "obj"];
                        var l_id = l_lco[? l_s];
                        
                        if (l_id == undefined)
                        {
                            l_id = asset_get_index(l_s);
                            l_lco[? l_s] = l_id;
                        }
                        
                        instance_change(l_id, false);
                        room_pack_raw_run_yy_inst_cc(self, l_qinst);
                        var l_list = global.room_pack_raw_store_instances;
                        
                        if (l_list != undefined)
                            ds_list_add(l_list, self);
                    }
                }
            }
            
            break;
        
        case "GMRAssetLayer":
            if (global.room_pack_raw_apply_sprites)
            {
                var l_rl = layer_get_id(l_ql_name);
                
                if (l_rl == -1)
                {
                    l_rl = layer_create(l_ql_depth, l_ql_name);
                    
                    if (arg0[? "visible"] != undefined)
                        layer_set_visible(l_rl, arg0[? "visible"]);
                }
                
                var l_sprites = arg0[? "assets"];
                var l_n = ds_list_size(l_sprites);
                var l_lcs = global.room_pack_raw_sprite_cache;
                var l_rx = global.room_pack_raw_room_x;
                var l_ry = global.room_pack_raw_room_y;
                var l_i = -1;
                
                while (++l_i < l_n)
                {
                    var l_qspr = l_sprites[| l_i];
                    var l_s = l_qspr[? "sprite"];
                    var l_rspr = l_rx + l_qspr[? "x"];
                    var l_rspr1 = l_ry + l_qspr[? "y"];
                    var l_id = l_lcs[? l_s];
                    
                    if (l_id == undefined)
                    {
                        l_id = asset_get_index(l_s);
                        l_lcs[? l_s] = l_id;
                    }
                    
                    var l_rspr2 = layer_sprite_create(l_rl, l_rspr, l_rspr1, l_id);
                    var l_aval = l_qspr[? "frameIndex"];
                    
                    if (l_aval != undefined)
                        layer_sprite_index(l_rspr2, l_aval);
                    
                    l_aval = l_qspr[? "scaleX"];
                    
                    if (l_aval != undefined)
                        layer_sprite_xscale(l_rspr2, l_aval);
                    
                    l_aval = l_qspr[? "scaleY"];
                    
                    if (l_aval != undefined)
                        layer_sprite_yscale(l_rspr2, l_aval);
                    
                    l_aval = l_qspr[? "rotation"];
                    
                    if (l_aval != undefined)
                        layer_sprite_angle(l_rspr2, l_aval);
                    
                    var l_f = l_qspr[? "color"];
                    
                    if (l_f != undefined)
                    {
                        layer_sprite_blend(l_rspr2, l_f & 16777215);
                        layer_sprite_alpha(l_rspr2, (l_f >> 24) / 255);
                    }
                    
                    if (l_qspr[? "userdefined_animFPS"])
                        layer_sprite_speed(l_rspr2, room_pack_raw_anim_speed(l_qspr[? "animationFPS"], l_qspr[? "animationSpeedType"]));
                    
                    var l_list = global.room_pack_raw_store_sprites;
                    
                    if (l_list != undefined)
                        ds_list_add(l_list, l_rspr2);
                }
            }
            
            break;
    }
}

function room_pack_raw_run_impl2(arg0)
{
    if (global.room_pack_raw_apply_settings)
    {
        room_width = ds_map_find_value(arg0, "roomSettings")[? "Width"];
        room_height = ds_map_find_value(arg0, "roomSettings")[? "Height"];
        room_pack_raw_init_physics(arg0[? "physicsSettings"]);
    }
    
    var l_lrs = arg0[? "layers"];
    var l_lrk = ds_list_size(l_lrs);
    
    while (--l_lrk >= 0)
        room_pack_raw_add_layer(l_lrs[| l_lrk]);
    
    if (global.room_pack_raw_apply_views)
    {
        var l_aval = ds_map_find_value(arg0, "viewSettings")[? "enableViews"];
        
        if (l_aval != undefined)
            view_enabled = l_aval;
        else
            view_enabled = false;
        
        var l_qvs = arg0[? "views"];
        
        if (l_qvs != undefined)
        {
            var l_i = 0;
            var l__g1 = ds_list_size(l_qvs);
            
            while (l_i < l__g1)
            {
                var l_qv = l_qvs[| l_i];
                
                if (l_qv == undefined)
                {
                }
                else
                {
                    var l_rv = l_i;
                    l_aval = l_qv[? "visible"];
                    
                    if (l_aval != undefined)
                        view_visible[l_rv] = l_aval;
                    else
                        view_visible[l_rv] = false;
                    
                    l_aval = l_qv[? "xport"];
                    
                    if (l_aval != undefined)
                        view_xport[l_rv] = l_aval;
                    else
                        view_xport[l_rv] = 0;
                    
                    l_aval = l_qv[? "yport"];
                    
                    if (l_aval != undefined)
                        view_yport[l_rv] = l_aval;
                    else
                        view_yport[l_rv] = 0;
                    
                    l_aval = l_qv[? "wport"];
                    
                    if (l_aval != undefined)
                        view_wport[l_rv] = l_aval;
                    else
                        view_wport[l_rv] = 1024;
                    
                    l_aval = l_qv[? "hport"];
                    
                    if (l_aval != undefined)
                        view_hport[l_rv] = l_aval;
                    else
                        view_hport[l_rv] = 768;
                    
                    var l_rc = view_camera[l_rv];
                    var l_vx = l_qv[? "xview"];
                    
                    if (l_vx == undefined)
                        l_vx = 0;
                    
                    var l_vy = l_qv[? "yview"];
                    
                    if (l_vy == undefined)
                        l_vy = 0;
                    
                    camera_set_view_pos(l_rc, global.room_pack_raw_room_x + l_vx, global.room_pack_raw_room_y + l_vy);
                    l_vx = l_qv[? "wview"];
                    
                    if (l_vx == undefined)
                        l_vx = 1024;
                    
                    l_vy = l_qv[? "hview"];
                    
                    if (l_vy == undefined)
                        l_vy = 768;
                    
                    camera_set_view_size(l_rc, l_vx, l_vy);
                    l_aval = l_qv[? "obj"];
                    
                    if (l_aval != undefined)
                        camera_set_view_target(l_rc, asset_get_index(l_aval));
                    
                    l_vx = l_qv[? "hspeed"];
                    
                    if (l_vx == undefined)
                        l_vx = -1;
                    
                    l_vy = l_qv[? "vspeed"];
                    
                    if (l_vy == undefined)
                        l_vy = -1;
                    
                    camera_set_view_speed(l_rc, l_vx, l_vy);
                    l_vx = l_qv[? "hborder"];
                    
                    if (l_vx == undefined)
                        l_vx = 32;
                    
                    l_vy = l_qv[? "vborder"];
                    
                    if (l_vy == undefined)
                        l_vy = 32;
                    
                    camera_set_view_border(l_rc, l_vx, l_vy);
                }
                
                l_i++;
            }
        }
    }
    
    var l_s = arg0[? "creationCode"];
    
    if (l_s != undefined && l_s != "")
        room_pack_raw_run_cc(l_s, arg0[? "name"] + ":CreationCode");
}

global.room_pack_flag_settings = 1;
global.room_pack_flag_instances = 2;
global.room_pack_flag_backgrounds = 4;
global.room_pack_flag_tiles = 8;
global.room_pack_flag_views = 16;
global.room_pack_flag_sprites = 32;
global.room_pack_flag_all = 255;
global.room_pack_blank_object = -1;

global.room_pack_eval_script = function(arg0, arg1)
{
    show_debug_message("Can't execute code for " + arg1 + " - please assign an evaluator script to room_pack_eval_script (see doc)");
};

global.room_pack_const_script = function(arg0, arg1)
{
};

global.room_pack_raw_object_cache = ds_map_create();
global.room_pack_raw_sprite_cache = ds_map_create();
global.room_pack_raw_use_physics = false;
global.room_pack_raw_room_x = 0;
global.room_pack_raw_room_y = 0;
global.room_pack_raw_apply_backgrounds = true;
global.room_pack_raw_apply_instances = true;
global.room_pack_raw_apply_tiles = true;
global.room_pack_raw_apply_views = true;
global.room_pack_raw_apply_settings = true;
global.room_pack_raw_apply_sprites = true;
global.room_pack_raw_store_instances = undefined;
global.room_pack_raw_store_backgrounds = undefined;
global.room_pack_raw_store_sprites = undefined;
global.room_pack_raw_store_tilemaps = undefined;
global.room_pack_raw_store_tilemaps_ext = false;
global.room_pack_raw_include_layers = ds_map_create();
global.room_pack_raw_include_layers_on = false;
global.room_pack_raw_exclude_layers = ds_map_create();
global.room_pack_raw_inst_map_gml = ds_map_create();
global.room_pack_raw_inst_map_yy = ds_map_create();
