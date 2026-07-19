function meanFromList(arg0, arg1)
{
    var i = 0;
    var total = 0;
    
    repeat (arg1)
    {
        total += arg0[| i];
        i += 1;
    }
    
    return total / arg1;
}
