function initializeAbilityUpgrades()
{
    global.upgrade = ds_list_create();
    
    for (var i = 0; i < UnknownEnum.Value_29; i += 1)
        global.upgrade[| i] = 0;
    
    global.upgradeIcon = ds_list_create();
    global.upgradeIcon[| UnknownEnum.Value_0] = sItem_damage_jump_recover;
    global.upgradeIcon[| UnknownEnum.Value_1] = sItem_slam_fruit_suction;
    global.upgradeIcon[| UnknownEnum.Value_2] = sItem_wallkick_fruit_suction;
    global.upgradeIcon[| UnknownEnum.Value_3] = sItem_spin_fruit_suction;
    global.upgradeIcon[| UnknownEnum.Value_4] = sItem_aim_focus_extend;
    global.upgradeIcon[| UnknownEnum.Value_5] = sItem_wall_jump_higher;
    global.upgradeIcon[| UnknownEnum.Value_6] = sItem_juice_resurrection;
    global.upgradeIcon[| UnknownEnum.Value_7] = sItem_extra_jump_orb;
    global.upgradeIcon[| UnknownEnum.Value_8] = sItem_money_pot;
    global.upgradeIcon[| UnknownEnum.Value_9] = sItem_higher_entity_bounce;
    global.upgradeIcon[| UnknownEnum.Value_10] = sItem_instant_money;
    global.upgradeIcon[| UnknownEnum.Value_11] = sItem_focus_time_freeze;
    global.upgradeIcon[| UnknownEnum.Value_12] = sItem_spin_wall_jump;
    global.upgradeIcon[| UnknownEnum.Value_13] = sItem_final_screw_attack;
    global.upgradeIcon[| UnknownEnum.Value_14] = sItem_fruit_twin;
    global.upgradeIcon[| UnknownEnum.Value_15] = sItem_slam_bounce_angled;
    global.upgradeIcon[| UnknownEnum.Value_16] = sItem_slam_start_fruit_suction;
    global.upgradeIcon[| UnknownEnum.Value_17] = sItem_fruit_pot;
    global.upgradeIcon[| UnknownEnum.Value_18] = sItem_more_pot;
    global.upgradeIcon[| UnknownEnum.Value_19] = sItem_enemy_to_fruit;
    global.upgradeIcon[| UnknownEnum.Value_20] = sItem_fruit_handler_dual_wield;
    global.upgradeIcon[| UnknownEnum.Value_21] = sItem_more_fruit_handler;
    global.upgradeIcon[| UnknownEnum.Value_22] = sItem_endless_mode;
    global.upgradeIcon[| UnknownEnum.Value_23] = sItem_pajama1;
    global.upgradeIcon[| UnknownEnum.Value_24] = sItem_pajama2;
    global.upgradeIcon[| UnknownEnum.Value_25] = sItem_pajama3;
    global.upgradeIcon[| UnknownEnum.Value_26] = sItem_pajama4;
    global.upgradeIcon[| UnknownEnum.Value_27] = sItem_increase_jump_power;
    global.upgradeIcon[| UnknownEnum.Value_28] = sItem_jump_fruit_suction;
}
