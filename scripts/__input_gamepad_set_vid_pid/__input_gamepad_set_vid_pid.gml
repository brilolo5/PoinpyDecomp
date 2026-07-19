function __input_gamepad_set_vid_pid(arg0)
{
    with (arg0)
    {
        if (os_type == os_windows)
        {
            var _result = __input_gamepad_guid_parse(guid, true);
            vendor = _result.vendor;
            product = _result.product;
            xinput = index < 4;
        }
        else if (os_type == os_macosx || os_type == os_linux || os_type == os_ios || os_type == os_android)
        {
            var _result = __input_gamepad_guid_parse(guid, false);
            vendor = _result.vendor;
            product = _result.product;
            xinput = undefined;
        }
        else
        {
            vendor = "";
            product = "";
            xinput = undefined;
        }
    }
}
