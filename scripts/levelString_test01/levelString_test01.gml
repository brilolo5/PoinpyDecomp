function levelString_test01()
{
    _gimmickA = 254;
    _gimmickB = 252;
    _gimmickC = 259;
    ds_list_add(enemyList[1], 238, -4);
    ds_list_add(enemyList[2], 242);
    ds_list_add(enemyList[3], 245);
    
    switch (irandom(6))
    {
        case 0:
            return "\r\n\to  .      o\r\n\to     1   o\r\n\to    ooo  o\r\n\to  A ooo  o\r\n\too        o\r\n\too        o\r\n\too  .  .  o\r\n\too---     o\r\n\too        o\r\n\too.     3 o\r\n\to      ---o\r\n\to   .     o\r\n\to         o";
        
        case 1:
            return "\r\n\to         o\r\n\too   .   .o\r\n\too     1  o\r\n\too    ooooo\r\n\too  A ooooo\r\n\to         o\r\n\to.        o\r\n\to 2  ---  o\r\n\to      .  o\r\n\to         o";
        
        case 2:
            return "\r\n\to        .o\r\n\to2        o\r\n\to  .     oo\r\n\to    1   oo\r\n\to   oo A oo\r\n\to-  oo   oo\r\n\to         o\r\n\to  .   .  o";
        
        case 3:
            return "\r\n\to      .  o\r\n\to  1      o\r\n\tooooo     o\r\n\tooooo     o\r\n\to       --o\r\n\to    A   .o\r\n\to         o\r\n\to   .     o\r\n\to      3  o\r\n\to  .  ooooo\r\n\to         o\r\n\to 2  .    o\r\n\to         o";
        
        case 4:
            return "\r\n\to  1      o\r\n\tooooo     o\r\n\too      . o\r\n\to         o\r\n\to .  A    o\r\n\to        .o\r\n\to         o\r\n\to      3  o\r\n\to      ---o\r\n\to    .    o\r\n\to         o";
        
        case 5:
            return "\r\n\to  .     2o\r\n\to         o\r\n\to       . o\r\n\to  .  3   o\r\n\to    ---  o\r\n\to         o\r\n\to       A o\r\n\to    .    o\r\n\to         o";
        
        case 6:
            return "\r\n\to  .   .  o\r\n\to    1    o\r\n\to   BBB   o\r\n\to A BBB   o\r\n\to   BBB   o\r\n\to   BBB   o\r\n\to         o\r\n\to         o\r\n\to .       o\r\n\to      .  o\r\n\to         o\r\n\to  A   3  o\r\n\to    . ---o\r\n\to       . o";
    }
}
