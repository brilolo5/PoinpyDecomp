function TexanCommit()
{
    if (os_type == os_switch)
        switch_set_cpu_boost_mode(1);
    
    while (!TexanCommitStep())
    {
    }
    
    if (os_type == os_switch)
        switch_set_cpu_boost_mode(0);
    
    return true;
}

function TexanYeehaw()
{
    TexanCommit();
    return true;
}
