function switchInit()
{
    if (os_type != os_switch)
        exit;
    
    trace("Initialising for Switch");
    switch_controller_support_set_defaults();
    switch_controller_support_set_permit_joycon_dual(false);
    switch_controller_set_default_joycon_assignment(1);
    switch_controller_set_supported_styles(31);
    switch_controller_joycon_set_holdtype(1);
    switch_controller_set_handheld_activation_mode(0);
    switch_controller_start_lr_assignment();
    global.switchAccount = switchEnsureAccount();
    switch_save_data_unmount();
    switch_save_data_mount(global.switchAccount);
    global.wideGame = true;
    TextureManagerForceFullSet(true);
}
