var viewy = getViewy(global.cam) + 32;
var middley = viewy + (global.viewHeight / 2);
var persepectivePoint = middley;
var perspectiveDepth = 30;
var perspectivePointx = getViewx(global.cam) + (global.viewWidth / 2);
draw_clear(make_color_rgb(218, 221, 226));

with (oGameBackground)
{
    texture_set_interpolation(false);
    event_user(0);
    texture_set_interpolation(true);
}

with (oEndingSequence)
    event_user(2);

with (parentBackgroundFront)
    event_user(0);

with (parentEnvironmentDetail_back)
    event_user(0);

with (oCamera)
    event_user(3);

with (oShootIntoSpace)
    event_user(2);

if (room == rmPlayableMainMenu)
{
    with (dLobbyBigRock)
        event_user(0);
    
    with (dLobbySideRockLeft)
        event_user(0);
    
    with (dLobbySideRockRight)
        event_user(0);
    
    gpu_set_blendmode_ext(bm_inv_dest_color, bm_dest_color);
    
    with (dLobbyShadowColorBurnBox)
        event_user(3);
    
    gpu_set_blendmode(bm_normal);
    
    with (dLobbyShadowColorBurnBoxCrop)
        event_user(3);
    
    with (dLobbyShadowColorBurnBoxCropBox)
        event_user(3);
    
    with (dLobbyShadowLighter)
        event_user(0);
    
    with (oBeastInLobby)
        event_user(3);
    
    with (oTunnelBackground_noAreaChange)
        event_user(0);
    
    with (dLobbyLowerBush)
        event_user(0);
    
    with (dLobbyLeaves)
        event_user(0);
    
    with (dLobbyBigBush)
        event_user(0);
    
    with (dLevel00_GroundGrass)
        event_user(0);
    
    with (dGachaRockCeiling)
        event_user(0);
    
    with (dGachaStreetLight)
        event_user(0);
    
    with (dGachaDetailTreeLeftA)
        event_user(0);
    
    with (dGachaDetailTreeLeftB)
        event_user(0);
    
    with (dGachaDetailTreeRightB)
        event_user(0);
    
    with (dGachaDetailTreeRightA)
        event_user(0);
    
    with (dPuzzleRock00)
        event_user(0);
    
    with (dPuzzleRock01)
        event_user(0);
    
    with (dPuzzleRock02)
        event_user(0);
    
    with (dPuzzleRock03)
        event_user(0);
    
    with (dPuzzleRock04)
        event_user(0);
    
    with (dPuzzleRock05)
        event_user(0);
    
    with (dPuzzleRock06)
        event_user(0);
    
    with (dPuzzleRock07)
        event_user(0);
    
    with (dPuzzleTreeBack00)
        event_user(0);
    
    with (dPuzzleTreeBack01)
        event_user(0);
    
    with (dPuzzleTreeBack02)
        event_user(0);
    
    with (dPuzzleTreeBack03)
        event_user(0);
    
    with (dPuzzleTreeBack04)
        event_user(0);
    
    with (dPuzzleTreeBack05)
        event_user(0);
    
    with (dPuzzleWallBack00)
        event_user(0);
    
    with (oNotificationRabbit_Gacha_Asleep)
        event_user(0);
    
    with (oNotificationRabbit_Gacha_Dancing)
        event_user(0);
    
    with (oNotificationRabbit_Puzzle_Dancing)
        event_user(0);
    
    with (oNotificationRabbit_Gacha)
        event_user(0);
    
    with (oCosmos)
        event_user(0);
}

var _outlineColor = 16777215;
var _fruitOutlineArea = UnknownEnum.Value_2;

if (instance_exists(oGameBackground))
    _fruitOutlineArea = oGameBackground.bgArea;

switch (_fruitOutlineArea)
{
    case UnknownEnum.Value_1:
        _outlineColor = 16777215;
        break;
    
    case UnknownEnum.Value_2:
        _outlineColor = make_color_rgb(176, 249, 110);
        break;
    
    case UnknownEnum.Value_3:
        _outlineColor = make_color_rgb(109, 184, 255);
        break;
    
    case UnknownEnum.Value_4:
        _outlineColor = make_color_rgb(230, 75, 102);
        break;
    
    case UnknownEnum.Value_5:
        _outlineColor = make_color_rgb(249, 221, 40);
        break;
    
    case UnknownEnum.Value_6:
        _outlineColor = make_color_rgb(13, 228, 219);
        break;
    
    default:
        _outlineColor = 16777215;
        break;
}

texture_set_interpolation(false);

with (oFruit)
    draw_sprite_ext(sprIndex, 3, x + cx, y + cy, fruitScale, fruitScale, imageAngle, _outlineColor, outlineAlpha);

texture_set_interpolation(true);

with (oBeastMainGame)
    event_user(0);

with (oEndingSequence)
    event_user(0);

with (effectTwinkleStarForBeast)
    event_user(0);

with (oJuiceHomingParticleEmitter)
    event_user(0);

with (oBeastMainGame)
    event_user(2);

with (oGimJumpPad)
    drawJumppad();

with (parentEnemy)
    event_user(2);

with (oOnewayPlatform)
    event_user(0);

with (oMovingWall)
    event_user(0);

var _viewy = getViewy();
var _viewTop = _viewy - 16;
var _viewBottom = _viewy + global.viewHeight + 16;

if (wallGlow > 0)
    finalAreaGlow(_viewTop, _viewBottom);

with (oWall)
    wallDrawFunction(_viewTop, _viewBottom);

with (oCogWall)
    drawFunction();

with (oShootIntoSpace)
    drawFakeSideWall();

with (dLobbyMushroomLeft)
    event_user(0);

with (dLobbyMushroomRight)
    event_user(0);

with (parentEnvironmentDetail_front)
    event_user(0);

with (oSoftWall)
    event_user(5);

with (oSoftWall)
    event_user(4);

with (oSoftWall)
    event_user(0);

with (dTutorialCloudShadow)
    event_user(0);

with (oCogWall)
    event_user(0);

with (oCogWall)
    event_user(2);

texture_set_interpolation(false);

with (oFruit)
    event_user(0);

texture_set_interpolation(true);

with (parentStompable)
    event_user(0);

with (oLockedThinkingChair)
    drawChairHangingRope();

with (oBouncySwitch_gacha)
    event_user(0);

with (parentBgObject)
    event_user(0);

with (oBeastMainGame)
    event_user(10);

with (oEndingSequence)
    event_user(8);

with (oPlayer)
    event_user(0);

with (parentEnemy)
    event_user(0);

with (parentHazard)
    event_user(0);

if (room == rmPlayableMainMenu)
{
    with (dPuzzleTreeFront00)
        event_user(0);
    
    with (dPuzzleTreeFront01)
        event_user(0);
}

with (oPlayer)
    event_user(2);

with (oOrderControl)
    event_user(0);

with (parentInteractibleGimmick)
    event_user(0);

with (parentInteractiveEffect)
    event_user(0);

texture_set_interpolation(false);

with (parentEffect)
    event_user(0);

texture_set_interpolation(true);

with (oBeastInLobby)
    event_user(0);

with (oBouncySwitch_gacha)
    event_user(2);

with (parentTutorial)
    event_user(0);

with (oControl)
    event_user(3);

with (oOrderControl)
    event_user(5);

if (global.debugHitbox)
{
    draw_set_color(make_color_rgb(248, 45, 97));
    draw_set_alpha(0.5);
    
    with (oPlayer)
    {
        draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, 0);
        draw_circle(x, y, fruitSuckInRadius, 0);
    }
    
    with (oFruit)
        draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, 0);
    
    with (parentEnemy)
        draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, 0);
    
    draw_set_alpha(1);
    
    with (oWall)
        draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, 1);
    
    draw_set_alpha(1);
    draw_set_color(c_white);
}
