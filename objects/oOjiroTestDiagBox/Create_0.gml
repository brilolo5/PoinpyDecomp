diagbox = diagboxCreate();
diagboxSetKnobTarget(diagbox, roomXToGui(x) + 10, roomYToGui(y) + 24);
diagboxSetLimits(diagbox, global.windowLeft + 15, global.windowTop + 20, global.windowRight - 15, global.windowBottom - 15);
diagboxSetText(diagbox, "MAAA", 1/3);
diagboxSnapToTargetPos(diagbox);
diagboxSetSize(diagbox, 0, 0);
