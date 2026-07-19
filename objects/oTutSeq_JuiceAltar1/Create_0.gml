event_inherited();
oPlayer.xDirection = -1;
oPlayer.ysp = -4;
oPlayer.xsp = 0;
guide = 
{
    alpha: 0,
    messages: [loc("tutorial hey make juice"), loc("tutorial juice timer"), loc("tutorial go on now")],
    message_index: 0
};
instance_create_depth(x, y, 0, oOrderControl_Tutorial);
diagbox = diagboxCreate();
diagboxSetKnobTarget(diagbox, roomXToGui(oTutJuiceAltar.x) + 10, roomYToGui(oTutJuiceAltar.y) + 24);
diagboxSetLimits(diagbox, global.windowLeft + 20, global.windowTop + 20, global.windowRight - 20, global.windowBottom - 15);
diagboxSetText(diagbox, guide.messages[guide.message_index], 1/3);
diagboxSnapToTargetPos(diagbox);
diagboxSetSize(diagbox, 0, 0);
