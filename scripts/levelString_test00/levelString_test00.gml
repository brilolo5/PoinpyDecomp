function levelString_test00()
{
    _gimmickA = 253;
    _gimmickB = 259;
    _gimmickC = 259;
    ds_list_add(enemyList[1], 237, 212);
    ds_list_add(enemyList[2], 234, 209);
    ds_list_add(enemyList[3], 237, 234, 209);
    ds_list_add(enemyList[4], 212, -4);
    
    switch (irandom(5))
    {
        case 0:
            return "\r\n\to         A\r\n\to-- 2     A\r\n\to       . A\r\n\to .       A\r\n\to      2  A\r\n\too        A\r\n\too        A\r\n\too.    ---o\r\n\to   .     o\r\n\to         o";
        
        case 1:
            return "\r\n\to         o\r\n\to        .o\r\n\tA   2     o\r\n\tA.        o\r\n\tA     . ooo\r\n\tA ---   ooo\r\n\tA      .  o\r\n\tA         o";
        
        case 2:
            return "\r\n\to         A\r\n\to        .A\r\n\to1  .     A\r\n\tooo       A\r\n\tooo---    A\r\n\too   .    A\r\n\to         o\r\n\to         o";
        
        case 3:
            return "\r\n\to        oo\r\n\to   .    Ao\r\n\to        Ao\r\n\to--  2   Ao\r\n\to        Ao\r\n\to        Ao\r\n\to  --- . Ao\r\n\to        oo\r\n\to .   2   o\r\n\to         o";
        
        case 4:
            return "\r\n\tA         o\r\n\tA   .     o\r\n\tA     --ooo\r\n\tA       ooo\r\n\tA    2   oo\r\n\tA        oo\r\n\tA      . oo\r\n\tA        oo\r\n\tA .   2   o\r\n\tA         o";
        
        case 5:
            return "\r\n\to         o\r\n\to-        A\r\n\to    2  . A\r\n\to .       A\r\n\to         A\r\n\tooo--     A\r\n\tooo    .  A\r\n\to         A\r\n\to   .     A\r\n\to         A";
    }
}
