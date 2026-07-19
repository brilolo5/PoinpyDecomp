function saveDebugReset()
{
    var _buffer = buffer_create(1024, buffer_fixed, 1);
    buffer_save(_buffer, "default\\" + global.gameSaveFileName);
    buffer_delete(_buffer);
    show_debug_message("Savedata reset");
}
