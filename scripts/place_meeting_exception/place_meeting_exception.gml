global.__place_meeting_exception_list = ds_list_create();

function place_meeting_exception(arg0, arg1, arg2, arg3)
{
    ds_list_clear(global.__place_meeting_exception_list);
    var _count = instance_place_list(arg0, arg1, arg2, global.__place_meeting_exception_list, false);
    
    if (_count == 0)
        return false;
    
    if (_count > 1)
        return false;
    
    return global.__place_meeting_exception_list[| 0] != arg3;
}
