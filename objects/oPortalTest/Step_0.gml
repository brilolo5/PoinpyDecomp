set = 1;

if (collision_circle(x, y, portalSize - 4, oPlayer, 1, 0))
{
    var _playerPosyDif = portalEndPosy - y;
    oPlayer.y += _playerPosyDif;
    oCamera.camGoalPosy = y;
    oCamera.camLock = 1;
    playerIn = 1;
    view_visible[1] = 1;
}

if (playerIn)
{
    var _portalLeftEdge = -160;
    var _portalRightEdge = 320;
    var _portalSpaceWidth = _portalRightEdge + abs(_portalLeftEdge);
    var _portalCamSpaceWidth = _portalSpaceWidth - global.viewWidth;
    var _portalCamx = (((oPlayer.x + 160) / _portalSpaceWidth) * _portalCamSpaceWidth) - global.viewWidth;
    camera_set_view_pos(global.portalCam, _portalCamx, portalEndPosy - (global.viewHeight / 2));
    
    if (point_distance(oPlayer.x, portalEndPosy, oPlayer.x, oPlayer.y) > (portalSizeMax - 8))
    {
        playerIn = 0;
        oPlayer.y += (portalPosy - portalEndPosy);
        oPlayer.x -= camera_get_view_x(global.portalCam);
        oCamera.camLock = false;
        view_visible[1] = 0;
    }
}

if (y > (getViewy(global.cam) + global.viewHeight + 128))
    instance_destroy();
