__TexanTrace("Welcome to Texan by @jujuadams! This is version ", "2.0.0", ", ", "2021-03-31");
texture_debug_messages(2);
global.__texanFlush = ds_list_create();
global.__texanFetch = ds_list_create();
global.__texanAlwaysFetch = ds_list_create();
global.__texanTextureGroups = ds_list_create();
global.__texanSpriteToTextureGroup = ds_map_create();
var _array = ["Default", "UI_AbilityEquip", "EndingCutscene", "Backgrounds", "BeastInGame", "Details", "FinalArea", "Fonts", "Tutorial", "ResultsScreen", "UI_Gacha", "UI_Puzzle", "UI_Trophy", "Lobby", "dev", "unused", "netflixSplash", "langJapanese", "langKorean", "langArabic", "langChinese", "Abilities", "Player", "Enemies"];
var _i = 0;

repeat (array_length(_array))
{
    var _texture_group = _array[_i];
    
    if (ds_list_find_index(global.__texanTextureGroups, _texture_group) < 0)
    {
        __TexanTrace("Adding texture group \"", _texture_group, "\"");
        ds_list_add(global.__texanTextureGroups, _texture_group);
        var _sprites = texturegroup_get_sprites(_texture_group);
        var _s = 0;
        
        repeat (array_length(_sprites))
        {
            var _sprite = _sprites[_s];
            global.__texanSpriteToTextureGroup[? _sprite] = _texture_group;
            _s++;
        }
    }
    
    _i++;
}

_array = ["Fonts", "Player"];
_i = 0;

repeat (array_length(_array))
{
    var _texture_group = _array[_i];
    
    if (ds_list_find_index(global.__texanAlwaysFetch, _texture_group) < 0)
    {
        ds_list_add(global.__texanAlwaysFetch, _texture_group);
        TexanFetch(_texture_group);
    }
    
    _i++;
}

function __TexanTrace()
{
    var _string = "";
    var _i = 0;
    
    repeat (argument_count)
    {
        _string += string(argument[_i]);
        _i++;
    }
    
    show_debug_message("Texan: " + _string);
    return _string;
}
