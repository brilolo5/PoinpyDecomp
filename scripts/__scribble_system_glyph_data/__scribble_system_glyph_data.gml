function __scribble_system_glyph_data()
{
    global.__scribble_glyph_data = 
    {
        bidi_map: ds_map_create(),
        mirror_map: ds_map_create(),
        arabic_isolated_map: ds_map_create(),
        arabic_initial_map: ds_map_create(),
        arabic_medial_map: ds_map_create(),
        arabic_final_map: ds_map_create(),
        arabic_join_prev_map: ds_map_create(),
        arabic_join_next_map: ds_map_create(),
        thai_base_map: ds_map_create(),
        thai_base_descender_map: ds_map_create(),
        thai_base_ascender_map: ds_map_create(),
        thai_top_map: ds_map_create(),
        thai_lower_map: ds_map_create(),
        thai_upper_map: ds_map_create()
    };
    var _map = global.__scribble_glyph_data.bidi_map;
    _map[? -1] = UnknownEnum.Value_1;
    _map[? -2] = UnknownEnum.Value_1;
    
    for (_i = 0; _i <= 9; _i++)
        _map[? _i] = UnknownEnum.Value_1;
    
    _map[? 10] = UnknownEnum.Value_2;
    _map[? 11] = UnknownEnum.Value_1;
    _map[? 12] = UnknownEnum.Value_1;
    _map[? 13] = UnknownEnum.Value_1;
    _map[? 32] = UnknownEnum.Value_0;
    _map[? 33] = UnknownEnum.Value_1;
    _map[? 34] = UnknownEnum.Value_1;
    _map[? 38] = UnknownEnum.Value_1;
    _map[? 39] = UnknownEnum.Value_1;
    _map[? 40] = UnknownEnum.Value_1;
    _map[? 41] = UnknownEnum.Value_1;
    _map[? 42] = UnknownEnum.Value_1;
    _map[? 59] = UnknownEnum.Value_1;
    _map[? 60] = UnknownEnum.Value_1;
    _map[? 61] = UnknownEnum.Value_1;
    _map[? 62] = UnknownEnum.Value_1;
    _map[? 63] = UnknownEnum.Value_1;
    _map[? 64] = UnknownEnum.Value_1;
    _map[? 91] = UnknownEnum.Value_1;
    _map[? 92] = UnknownEnum.Value_1;
    _map[? 93] = UnknownEnum.Value_1;
    _map[? 94] = UnknownEnum.Value_1;
    _map[? 95] = UnknownEnum.Value_1;
    _map[? 96] = UnknownEnum.Value_1;
    _map[? 123] = UnknownEnum.Value_1;
    _map[? 124] = UnknownEnum.Value_1;
    _map[? 125] = UnknownEnum.Value_1;
    _map[? 126] = UnknownEnum.Value_1;
    _map[? 44] = UnknownEnum.Value_1;
    _map[? 46] = UnknownEnum.Value_1;
    _map[? 47] = UnknownEnum.Value_1;
    _map[? 58] = UnknownEnum.Value_1;
    _map[? 8203] = UnknownEnum.Value_0;
    _map[? 8294] = UnknownEnum.Value_0;
    _map[? 8295] = UnknownEnum.Value_0;
    _map[? 8296] = UnknownEnum.Value_0;
    _map[? 8297] = UnknownEnum.Value_0;
    _map[? 8234] = UnknownEnum.Value_0;
    _map[? 8235] = UnknownEnum.Value_0;
    _map[? 8236] = UnknownEnum.Value_0;
    _map[? 8237] = UnknownEnum.Value_0;
    _map[? 8238] = UnknownEnum.Value_0;
    _map[? 160] = UnknownEnum.Value_1;
    _map[? 1548] = UnknownEnum.Value_1;
    _map[? 1643] = UnknownEnum.Value_4;
    _map[? 1644] = UnknownEnum.Value_4;
    
    for (_i = 1536; _i <= 1791; _i++)
        _map[? _i] = UnknownEnum.Value_4;
    
    for (_i = 64336; _i <= 65023; _i++)
        _map[? _i] = UnknownEnum.Value_4;
    
    for (_i = 65136; _i <= 65279; _i++)
        _map[? _i] = UnknownEnum.Value_4;
    
    _map = global.__scribble_glyph_data.mirror_map;
    _map[? 40] = 41;
    _map[? 41] = 40;
    _map[? 60] = 62;
    _map[? 62] = 60;
    _map[? 91] = 93;
    _map[? 93] = 91;
    _map[? 123] = 125;
    _map[? 125] = 123;
    var _map_i = global.__scribble_glyph_data.arabic_isolated_map;
    var _map_a = global.__scribble_glyph_data.arabic_initial_map;
    var _map_b = global.__scribble_glyph_data.arabic_medial_map;
    var _map_c = global.__scribble_glyph_data.arabic_final_map;
    _map_i[? 1570] = 65153;
    _map_c[? 1570] = 65154;
    _map_b[? 1570] = 65154;
    _map_a[? 1570] = 65153;
    _map_i[? 1571] = 65155;
    _map_c[? 1571] = 65156;
    _map_b[? 1571] = 65156;
    _map_a[? 1571] = 65155;
    _map_i[? 1572] = 65157;
    _map_c[? 1572] = 65158;
    _map_b[? 1572] = 65158;
    _map_a[? 1572] = 65157;
    _map_i[? 1573] = 65159;
    _map_c[? 1573] = 65160;
    _map_b[? 1573] = 65160;
    _map_a[? 1573] = 65159;
    _map_i[? 1574] = 65161;
    _map_c[? 1574] = 65162;
    _map_b[? 1574] = 65164;
    _map_a[? 1574] = 65163;
    _map_i[? 1575] = 65165;
    _map_c[? 1575] = 65166;
    _map_b[? 1575] = 65166;
    _map_a[? 1575] = 65165;
    _map_i[? 1576] = 65167;
    _map_c[? 1576] = 65168;
    _map_b[? 1576] = 65170;
    _map_a[? 1576] = 65169;
    _map_i[? 1577] = 65171;
    _map_c[? 1577] = 65172;
    _map_b[? 1577] = 65172;
    _map_a[? 1577] = 65171;
    _map_i[? 1578] = 65173;
    _map_c[? 1578] = 65174;
    _map_b[? 1578] = 65176;
    _map_a[? 1578] = 65175;
    _map_i[? 1579] = 65177;
    _map_c[? 1579] = 65178;
    _map_b[? 1579] = 65180;
    _map_a[? 1579] = 65179;
    _map_i[? 1580] = 65181;
    _map_c[? 1580] = 65182;
    _map_b[? 1580] = 65184;
    _map_a[? 1580] = 65183;
    _map_i[? 1581] = 65185;
    _map_c[? 1581] = 65186;
    _map_b[? 1581] = 65188;
    _map_a[? 1581] = 65187;
    _map_i[? 1582] = 65189;
    _map_c[? 1582] = 65190;
    _map_b[? 1582] = 65192;
    _map_a[? 1582] = 65191;
    _map_i[? 1583] = 65193;
    _map_c[? 1583] = 65194;
    _map_b[? 1583] = 65194;
    _map_a[? 1583] = 65193;
    _map_i[? 1584] = 65195;
    _map_c[? 1584] = 65196;
    _map_b[? 1584] = 65196;
    _map_a[? 1584] = 65195;
    _map_i[? 1585] = 65197;
    _map_c[? 1585] = 65198;
    _map_b[? 1585] = 65198;
    _map_a[? 1585] = 65197;
    _map_i[? 1586] = 65199;
    _map_c[? 1586] = 65200;
    _map_b[? 1586] = 65200;
    _map_a[? 1586] = 65199;
    _map_i[? 1587] = 65201;
    _map_c[? 1587] = 65202;
    _map_b[? 1587] = 65204;
    _map_a[? 1587] = 65203;
    _map_i[? 1588] = 65205;
    _map_c[? 1588] = 65206;
    _map_b[? 1588] = 65208;
    _map_a[? 1588] = 65207;
    _map_i[? 1589] = 65209;
    _map_c[? 1589] = 65210;
    _map_b[? 1589] = 65212;
    _map_a[? 1589] = 65211;
    _map_i[? 1590] = 65213;
    _map_c[? 1590] = 65214;
    _map_b[? 1590] = 65216;
    _map_a[? 1590] = 65215;
    _map_i[? 1591] = 65217;
    _map_c[? 1591] = 65218;
    _map_b[? 1591] = 65220;
    _map_a[? 1591] = 65219;
    _map_i[? 1592] = 65221;
    _map_c[? 1592] = 65222;
    _map_b[? 1592] = 65224;
    _map_a[? 1592] = 65223;
    _map_i[? 1593] = 65225;
    _map_c[? 1593] = 65226;
    _map_b[? 1593] = 65228;
    _map_a[? 1593] = 65227;
    _map_i[? 1594] = 65229;
    _map_c[? 1594] = 65230;
    _map_b[? 1594] = 65232;
    _map_a[? 1594] = 65231;
    _map_i[? 1601] = 65233;
    _map_c[? 1601] = 65234;
    _map_b[? 1601] = 65236;
    _map_a[? 1601] = 65235;
    _map_i[? 1602] = 65237;
    _map_c[? 1602] = 65238;
    _map_b[? 1602] = 65240;
    _map_a[? 1602] = 65239;
    _map_i[? 1603] = 65241;
    _map_c[? 1603] = 65242;
    _map_b[? 1603] = 65244;
    _map_a[? 1603] = 65243;
    _map_i[? 1604] = 65245;
    _map_c[? 1604] = 65246;
    _map_b[? 1604] = 65248;
    _map_a[? 1604] = 65247;
    _map_i[? 1605] = 65249;
    _map_c[? 1605] = 65250;
    _map_b[? 1605] = 65252;
    _map_a[? 1605] = 65251;
    _map_i[? 1606] = 65253;
    _map_c[? 1606] = 65254;
    _map_b[? 1606] = 65256;
    _map_a[? 1606] = 65255;
    _map_i[? 1607] = 65257;
    _map_c[? 1607] = 65258;
    _map_b[? 1607] = 65260;
    _map_a[? 1607] = 65259;
    _map_i[? 1608] = 65261;
    _map_c[? 1608] = 65262;
    _map_b[? 1608] = 65262;
    _map_a[? 1608] = 65261;
    _map_i[? 1609] = 65263;
    _map_c[? 1609] = 65264;
    _map_b[? 1609] = 65264;
    _map_a[? 1609] = 65263;
    _map_i[? 1610] = 65265;
    _map_c[? 1610] = 65266;
    _map_b[? 1610] = 65268;
    _map_a[? 1610] = 65267;
    _map_i[? 65269] = 65269;
    _map_c[? 65269] = 65270;
    _map_b[? 65269] = 65270;
    _map_a[? 65269] = 65269;
    _map_i[? 65270] = 65269;
    _map_c[? 65270] = 65270;
    _map_b[? 65270] = 65270;
    _map_a[? 65270] = 65269;
    _map_i[? 65271] = 65271;
    _map_c[? 65271] = 65272;
    _map_b[? 65271] = 65272;
    _map_a[? 65271] = 65271;
    _map_i[? 65271] = 65271;
    _map_c[? 65271] = 65272;
    _map_b[? 65271] = 65272;
    _map_a[? 65271] = 65271;
    _map_i[? 65273] = 65273;
    _map_c[? 65273] = 65274;
    _map_b[? 65273] = 65274;
    _map_a[? 65273] = 65273;
    _map_i[? 65274] = 65273;
    _map_c[? 65274] = 65274;
    _map_b[? 65274] = 65274;
    _map_a[? 65274] = 65273;
    _map_i[? 65275] = 65275;
    _map_c[? 65275] = 65276;
    _map_b[? 65275] = 65276;
    _map_a[? 65275] = 65275;
    _map_i[? 65276] = 65275;
    _map_c[? 65276] = 65276;
    _map_b[? 65276] = 65276;
    _map_a[? 65276] = 65275;
    var _map_prev = global.__scribble_glyph_data.arabic_join_prev_map;
    var _map_next = global.__scribble_glyph_data.arabic_join_next_map;
    _map_i = global.__scribble_glyph_data.arabic_isolated_map;
    _map_a = global.__scribble_glyph_data.arabic_initial_map;
    _map_b = global.__scribble_glyph_data.arabic_medial_map;
    _map_c = global.__scribble_glyph_data.arabic_final_map;
    var _arabic_array = ds_map_keys_to_array(_map_i);
    var _i = 0;
    
    repeat (array_length(_arabic_array))
    {
        var _glyph = _arabic_array[_i];
        _map_prev[? _glyph] = _map_a[? _glyph] != _map_b[? _glyph];
        _map_next[? _glyph] = _map_a[? _glyph] != _map_i[? _glyph];
        _i++;
    }
    
    _map = global.__scribble_glyph_data.thai_base_map;
    
    for (_i = 3585; _i <= 3631; _i++)
        _map[? _i] = true;
    
    _map[? 3632] = true;
    _map[? 3648] = true;
    _map[? 3649] = true;
    _map = global.__scribble_glyph_data.thai_base_descender_map;
    _map[? 3598] = true;
    _map[? 3599] = true;
    _map = global.__scribble_glyph_data.thai_base_ascender_map;
    _map[? 3611] = true;
    _map[? 3613] = true;
    _map[? 3615] = true;
    _map[? 3628] = true;
    _map = global.__scribble_glyph_data.thai_top_map;
    _map[? 3656] = true;
    _map[? 3657] = true;
    _map[? 3658] = true;
    _map[? 3659] = true;
    _map[? 3660] = true;
    _map = global.__scribble_glyph_data.thai_lower_map;
    _map[? 3640] = true;
    _map[? 3641] = true;
    _map[? 3642] = true;
    _map = global.__scribble_glyph_data.thai_upper_map;
    _map[? 3633] = true;
    _map[? 3636] = true;
    _map[? 3637] = true;
    _map[? 3638] = true;
    _map[? 3639] = true;
    _map[? 3655] = true;
    _map[? 3661] = true;
}
