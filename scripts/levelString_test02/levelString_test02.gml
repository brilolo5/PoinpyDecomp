function levelString_test02()
{
    _gimmickA = 259;
    _gimmickB = 259;
    _gimmickC = 259;
    ds_list_add(enemyList[1], 244);
    ds_list_add(enemyList[2], 233, 239);
    
    switch (irandom(3))
    {
        case 0:
            return "\r\n\to         o\r\n\to       . o\r\n\to .      2o\r\n\to         o\r\n\to--       o\r\n\to      AAAo\r\n\to.     oooo\r\n\to 2 .     o\r\n\to         o";
        
        case 1:
            return "\r\n\to         o\r\n\to    2   .o\r\n\to  .      o\r\n\to         o\r\n\to   oo    o\r\n\to       2 o\r\n\to    .    o\r\n\to         o";
        
        case 2:
            return "\r\n\to         o\r\n\to        .o\r\n\to  .      o\r\n\to         o\r\n\to   oo    o\r\n\to   AA    o\r\n\to    .    o\r\n\to 2       o";
        
        case 3:
            return "\r\n\toA        o\r\n\toA       .o\r\n\to  .      o\r\n\to        1o\r\n\to     ooooo\r\n\to      2  o\r\n\to    .    o\r\n\to         o";
    }
}
