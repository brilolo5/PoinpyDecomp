ysp += doDelta(grav);

if (ysp > 2)
    grav += doDelta(0.02);

x += doDelta(xsp);
guix += doDelta(xsp);

if (initialBoostFrames)
{
    y += doDelta(ysp * 3);
    guiy += doDelta(ysp * 3);
    initialBoostFrames -= doDelta(1);
}
else
{
    y += doDelta(ysp);
    guiy += doDelta(ysp);
}
