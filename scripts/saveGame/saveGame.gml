function saveGame()
{
    var _force_sync = (argument_count > 0 && argument[0] != undefined) ? argument[0] : false;
    var _filename = global.gameSaveFileName;
    var _string = savedataSerialise();
    var _buffer = buffer_create(string_byte_length(_string) + 42, buffer_fixed, 1);
    buffer_write(_buffer, buffer_string, _string);
    buffer_write(_buffer, buffer_string, hmac_sha1("’Twas brillig, and the slithy toves\nDid gyre and gimble in the wabe", _string));
    var _ticket = 
    {
        id: undefined,
        operation: "save",
        filename: _filename,
        buffer: _buffer,
        
        callback: function(arg0)
        {
            if (arg0)
                trace("Save: Success");
            else
                trace("Warning! Failed to save game data!");
            
            buffer_delete(buffer);
        }
    };
    
    if (_force_sync)
    {
        trace("Save: Forcing synchronous saving");
        buffer_save_ext(_buffer, "default\\" + global.gameSaveFileName, 0, buffer_tell(_buffer));
        _ticket.callback(true);
    }
    else
    {
        trace("Save: Saving asynchronously");
        var _id = buffer_save_async(_buffer, _filename, 0, buffer_tell(_buffer));
        _ticket.id = _id;
        global.__savedata_ticket_dict[? _id] = _ticket;
    }
}
