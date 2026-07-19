function loadGame()
{
    var _force_sync = (argument_count > 0 && argument[0] != undefined) ? argument[0] : false;
    var _filename = global.gameSaveFileName;
    var _buffer = buffer_create(1024, buffer_grow, 1);
    var _ticket = 
    {
        id: undefined,
        operation: "load",
        filename: _filename,
        buffer: _buffer,
        
        callback: function(arg0)
        {
            if (arg0)
            {
                trace("Load: Loaded successfully");
                var _json_string = buffer_read(buffer, buffer_string);
                savedataDeserialise(_json_string);
                var _expected_hmac = hmac_sha1("’Twas brillig, and the slithy toves\nDid gyre and gimble in the wabe", _json_string);
                var _found_hmac;
                
                if (buffer_tell(buffer) >= buffer_get_size(buffer))
                {
                    _found_hmac = "";
                    trace("Savedata has no fingerprint");
                }
                else
                {
                    _found_hmac = buffer_read(buffer, buffer_string);
                }
                
                if (_expected_hmac != _found_hmac)
                {
                    trace("Savedata fingerprint failed");
                    global.savedataFingerprintFailed = true;
                }
                else
                {
                    global.savedataFingerprintFailed = false;
                }
            }
            else
            {
                trace("Warning! Failed to load game data!");
            }
            
            buffer_delete(buffer);
            
            with (oInitialize)
                loaded = true;
        }
    };
    
    if (_force_sync)
    {
        trace("Load: Forcing synchronous loading");
        buffer_load_ext(_buffer, "default\\" + global.gameSaveFileName, 0);
        _ticket.callback(true);
    }
    else
    {
        trace("Load: Loading asynchronously");
        var _id = buffer_load_async(_buffer, _filename, 0, -1);
        _ticket.id = _id;
        global.__savedata_ticket_dict[? _id] = _ticket;
    }
}
