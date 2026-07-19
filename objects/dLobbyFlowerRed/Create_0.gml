image_speed = 0;
imageIndex = irandom(sprite_get_number(spriteIndex) - 1);
image_xscale = 1;

if (ds_list_find_index(global.areaUnlockedList, UnknownEnum.Value_4) == -1)
    spriteIndex = sDetailLobbyBud;
