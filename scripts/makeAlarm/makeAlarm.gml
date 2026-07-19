function makeAlarm(arg0, arg1) constructor
{
    static tick = function()
    {
        if (alarmTimer > 0)
        {
            alarmTimer -= global.deltaTimeRate;
            
            if (alarmTimer <= 0)
                alarmEvent();
        }
    };
    
    static setTimer = function(arg0)
    {
        alarmTimer = arg0;
    };
    
    static addToTimer = function(arg0)
    {
        alarmTimer += arg0;
    };
    
    static timerLeft = function()
    {
        return alarmTimer;
    };
    
    alarmTimerDefault = arg0;
    alarmTimer = arg0;
    
    alarmEvent = function()
    {
        show_debug_message("no alarm event set");
    };
    
    alarmEvent = arg1;
}
