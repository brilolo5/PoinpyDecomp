global.__savedata_ticket_dict = ds_map_create();

function savedataAsyncEventHandler()
{
    var _id = async_load[? "id"];
    var _status = async_load[? "status"];
    var _ticket = global.__savedata_ticket_dict[? _id];
    
    if (is_struct(_ticket))
    {
        trace("Save/Load: Async event received for \"", _ticket.filename, "\", operation=", _ticket.operation);
        ds_map_delete(global.__savedata_ticket_dict, _id);
        
        if (os_type == os_switch && _ticket.operation == "save")
            switch_save_data_commit();
        
        _ticket.callback(_status);
    }
}
