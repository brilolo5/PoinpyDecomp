function switchEnsureAccount()
{
    var _id = -1;
    var _i = 0;
    
    repeat (switch_accounts_get_accounts())
    {
        if (switch_accounts_is_user_open(_i))
        {
            _id = _i;
            break;
        }
        
        _i++;
    }
    
    while (_id < 0)
        _id = switch_accounts_select_account(true, false, false);
    
    return _id;
}
