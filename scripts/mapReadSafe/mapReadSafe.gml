function mapReadSafe(arg0, arg1, arg2)
{
    if (!ds_map_exists(arg0, arg1))
        return arg2;
    
    return arg0[? arg1];
}
