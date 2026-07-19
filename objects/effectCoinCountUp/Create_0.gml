vspeed = -1;
friction = 0.1;
alarm[0] = 45;
textSize = 0.2;
textSizeMax = 1.25;
textSizeExpansionRate = 0.25;
_totalFruits = ds_grid_get_sum(global.comboGrid, UnknownEnum.Value_1, 0, UnknownEnum.Value_1, ds_grid_height(global.comboGrid));
text = _totalFruits;
