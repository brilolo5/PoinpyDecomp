if (global.juicerRankProgress > 0)
{
    var vwidth = global.viewWidth;
    var vheight = global.viewHeight;
    var rectWidth = 124;
    var rectHeight = 130;
    var rectCenterx = xstart;
    var rectCentery = vheight / 2;
    rectCentery = y;
    var rectLeft = rectCenterx - (rectWidth / 2);
    var rectRight = rectCenterx + (rectWidth / 2);
    var rectTop = rectCentery - (rectHeight / 2);
    var rectBottom = rectCentery + (rectHeight / 2);
    progressBarCenterx = rectCenterx;
    progressBarCentery = (ystart + 64) - 4;
    progressBarLengthMax = rectWidth * 0.5;
    progressBarHeight = 5;
    progressBarLeft = progressBarCenterx - (progressBarLengthMax / 2);
    progressBarRight = progressBarCenterx + (progressBarLengthMax / 2);
    progressBarTop = progressBarCentery - (progressBarHeight / 2);
    progressBarBottom = progressBarCentery + (progressBarHeight / 2);
    var pbbgw = 0.75;
    var progressBarBgLengthMax = progressBarLengthMax;
    var progressBarBgHeight = progressBarHeight;
    var progressBarBgLeft = progressBarCenterx - (progressBarBgLengthMax / 2) - pbbgw;
    var progressBarBgRight = progressBarCenterx + (progressBarBgLengthMax / 2) + pbbgw;
    var progressBarBgTop = progressBarCentery - (progressBarBgHeight / 2) - pbbgw;
    var progressBarBgBottom = progressBarCentery + (progressBarBgHeight / 2) + pbbgw;
    var _rewardIndex = global.juicerRankReward[global.juicerRank];
    var _nextIconx = progressBarBgRight + 8 + 2;
    var _nextIcony = progressBarCentery;
    var _juicerRank = 0;
    progressRemain = global.juicerRankProgress;
    
    for (var i = _juicerRank; i <= global.juicerRankMax; i += 1)
    {
        if (progressRemain >= global.juicerRankUpThreshold[i])
        {
            progressRemain -= global.juicerRankUpThreshold[i];
        }
        else
        {
            _juicerRank = i;
            break;
        }
    }
    
    if (!(global.juicerRank >= global.juicerRankMax))
    {
        var _barbg = make_color_rgb(46, 50, 59);
        draw_set_color(_barbg);
        draw_set_alpha(1);
        draw_roundrect_ext(progressBarBgLeft, progressBarBgTop, progressBarBgRight, progressBarBgBottom, 3, 3, 0);
        draw_set_color(_barbg);
        draw_set_color(make_color_rgb(218, 221, 226));
        draw_set_alpha(1);
        draw_roundrect_ext(progressBarLeft, progressBarTop, progressBarRight, progressBarBottom, 2, 2, 0);
        progressBarLength = progressBarLengthMax * (progressRemain / global.juicerRankUpThreshold[global.juicerRank]);
        progressBarLeft = progressBarCenterx - (progressBarLengthMax / 2);
        progressBarRight = progressBarLeft + progressBarLength;
        draw_set_color(make_color_rgb(36, 145, 249));
        draw_set_alpha(1);
        draw_roundrect_ext(progressBarLeft, progressBarTop, progressBarRight, progressBarBottom, 2, 2, 0);
    }
    else
    {
        var _barbg = make_color_rgb(46, 50, 59);
        draw_set_color(_barbg);
        draw_set_alpha(1);
        draw_roundrect_ext(progressBarBgLeft, progressBarBgTop, progressBarBgRight, progressBarBgBottom, 3, 3, 0);
        draw_set_color(_barbg);
        draw_set_color(make_color_rgb(255, 238, 96));
        draw_set_alpha(1);
        draw_roundrect_ext(progressBarLeft, progressBarTop, progressBarRight, progressBarBottom, 2, 2, 0);
        progressBarLength = progressBarLengthMax * (progressRemain / global.juicerRankUpThreshold[global.juicerRank]);
        progressBarLeft = progressBarCenterx - (progressBarLengthMax / 2);
        progressBarRight = progressBarLeft + progressBarLength;
        draw_set_color(make_color_rgb(255, 238, 96));
        draw_set_alpha(1);
        draw_roundrect_ext(progressBarLeft, progressBarTop, progressBarRight, progressBarBottom, 2, 2, 0);
    }
    
    drawSetAlign(1, 2);
    var _resultCurrencyText = loc("lobby UI juicer rank", locGetNumFont(true) + string(global.juicerRank) + "[/font]");
    var _resultCurrencyTextSize = 1;
    var _resultCurrencyTextWidth = stringWidth(_resultCurrencyText, _resultCurrencyTextSize);
    var _resultCurrencyTextPosx = progressBarCenterx;
    var _resultCurrencyTextPosy = progressBarBgTop + 1;
    drawTextOutlined(_resultCurrencyTextPosx, _resultCurrencyTextPosy, _resultCurrencyText, 16777215, make_color_rgb(46, 50, 59), 0, _resultCurrencyTextSize);
    drawSetAlign(1, 0);
}
