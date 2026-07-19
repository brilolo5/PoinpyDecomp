var _drawBreath = cos(breath);
var _yscale = 0.1 + (0.002 * _drawBreath);
var _xscale = 0.1 + (0.002 * _drawBreath);
var _beasty = (y + cy) - 8;
draw_sprite_ext(sBeastPart_Body, 0, x + cx, _beasty, _xscale, _yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sBeastPart_Body, 0, x + cx, _beasty, -_xscale, _yscale, image_angle, c_white, image_alpha);
drawSetInterpolation(false);
draw_sprite_ext(sBeastPart_Body, 1, x + cx, _beasty, _xscale, _yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sBeastPart_Body, 1, x + cx, _beasty, -_xscale, _yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sBeastPart_Body, 1, x + cx, _beasty + 12, _xscale, _yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sBeastPart_Body, 1, x + cx, _beasty + 12, -_xscale, _yscale, image_angle, c_white, image_alpha);
var _faceIndex = global.timeScaledTime / 10;
var _faceSpriteIndex = sBeastPart_FaceAsleep_BreatheIn;

if (ysp > 0)
    _faceSpriteIndex = sBeastPart_FaceAsleep_BreatheOut;

var _breatheAnimSpeed = global.timeScale * (1/15);
var _MumbleAnimSpeed = global.timeScale * 0.1;
var _breatheSwitchDelayRate = global.timeScale * (1/30);
var _faceOffsety = 0;
faceOffsety = 0;

switch (breathState)
{
    case "breathe in":
        if (breathStateInit)
        {
            playSoundBeastInhale();
            breathStateInit = 0;
        }
        
        beastFaceSprite = sBeastPart_FaceAsleep_BreatheIn;
        var _spriteNum = sprite_get_number(beastFaceSprite) - 1;
        beastFaceIndex = approach(beastFaceIndex, _spriteNum, _breatheAnimSpeed);
        
        if (sin(breath) > 0)
        {
            breathStateSwitchDelayTimer += _breatheSwitchDelayRate;
            
            if (breathStateSwitchDelayTimer >= 1)
            {
                beastFaceSprite = sBeastPart_FaceAsleep_BreatheOut;
                beastFaceIndex = 0;
                breathStateSwitchDelayTimer = 0;
                breathState = "breathe out";
                breathStateInit = 1;
            }
        }
        
        break;
    
    case "breathe out":
        if (breathStateInit)
        {
            playSoundBeastExhale();
            breathStateInit = 0;
        }
        
        _spriteNum = sprite_get_number(beastFaceSprite) - 1;
        beastFaceIndex = approach(beastFaceIndex, _spriteNum, _breatheAnimSpeed);
        beastFaceSprite = sBeastPart_FaceAsleep_BreatheOut;
        
        if (sin(breath) < 0)
        {
            breathStateSwitchDelayTimer += _breatheSwitchDelayRate;
            
            if (breathStateSwitchDelayTimer >= 1)
            {
                beastFaceSprite = sBeastPart_FaceAsleep_BreatheIn;
                beastFaceIndex = 0;
                breathStateSwitchDelayTimer = 0;
                breathState = "breathe in";
                beastBreatheCount += 1;
                breathStateInit = 1;
                
                if (beastBreatheCount >= 2)
                {
                    beastFaceSprite = sBeastPart_FaceAsleep_MumbleStart;
                    breathState = "mumble";
                    breathStop = 1;
                    beastBreatheCount = 0;
                }
            }
        }
        
        break;
    
    case "mumble":
        if (beastFaceIndex >= (sprite_get_number(beastFaceSprite) - 1))
        {
            if (audioVarBeastMumble == 0)
                playSoundBeastMumble();
            
            beastMumbleLoopCount += 1;
            beastFaceIndex -= (sprite_get_number(beastFaceSprite) - 1);
            beastFaceSprite = sBeastPart_FaceAsleep_MumbleLoop;
            audioVarBeastMumble = 1;
        }
        
        var _imageNumber = sprite_get_number(beastFaceSprite) - 1;
        beastFaceIndex += 0.1;
        
        if (beastMumbleLoopCount >= 4)
        {
            beastFaceSprite = sBeastPart_FaceAsleep_BreatheIn;
            beastFaceIndex = 0;
            breathStateSwitchDelayTimer = 0;
            breathState = "breathe in";
            beastMumbleLoopCount = 0;
            breathStop = 0;
            audioVarBeastMumble = 0;
            breathStateInit = 1;
        }
        
        break;
    
    case "bonked":
        briefBounce = 0;
        faceOffsety = 10;
        beastFaceSprite = sBeastPart_FaceSurpriseBonked;
        _imageNumber = sprite_get_number(beastFaceSprite) - 1;
        beastFaceIndex = approach(beastFaceIndex, _imageNumber, 0.1);
        breathStateSwitchDelayTimer += (0.023809523809523808 * global.deltaTimeRate);
        
        if (breathStateSwitchDelayTimer >= 1)
        {
            breathState = "look up";
            beastFaceIndex = 0;
            beastFaceSprite = sBeastPart_BonkLookUp;
            breathStateSwitchDelayTimer = 0;
            
            if (global.tutorialOver < 2)
            {
                breathState = "look around";
                beastFaceSprite = sBeastPart_FaceFirstEverBonked;
            }
        }
        
        if (inRange(oPlayer.x, x + 36, 16))
        {
            rightEarIndex = 5;
            rightEarOffsety = 8;
        }
        
        if (inRange(oPlayer.x, x - 36, 16))
        {
            leftEarIndex = 5;
            leftEarOffsety = 8;
        }
        
        break;
    
    case "look around":
        beastFaceSprite = sBeastPart_FaceFirstEverBonked;
        _imageNumber = sprite_get_number(beastFaceSprite) - 1;
        beastFaceIndex = approach(beastFaceIndex, _imageNumber, 0.2 * global.deltaTimeRate);
        
        if (beastFaceIndex >= _imageNumber)
        {
            breathStateSwitchDelayTimer += (0.023809523809523808 * global.deltaTimeRate);
            
            if (breathStateSwitchDelayTimer >= 1)
            {
                breathState = "look up";
                beastFaceIndex = 0;
                beastFaceSprite = sBeastPart_BonkLookUp;
            }
        }
        
        break;
    
    case "look up":
        beastFaceSprite = sBeastPart_BonkLookUp;
        _imageNumber = sprite_get_number(beastFaceSprite) - 1;
        beastFaceIndex = approach(beastFaceIndex, _imageNumber, 0.25 * global.deltaTimeRate);
        
        if (beastFaceIndex >= _imageNumber)
        {
            rightEarIndex = 0;
            rightEarOffsety = 0;
            leftEarIndex = 0;
            leftEarOffsety = 0;
        }
        
        break;
}

if (briefBounce)
{
    beastFaceSprite = sBeastPart_FaceAsleep_MumbleLoop;
    var _imageNumber = sprite_get_number(beastFaceSprite) - 1;
    beastFaceIndex += (global.timeScale * 0.1);
}

draw_sprite_ext(sBeastPart_Ear, rightEarIndex, x + cx, _beasty + (faceOffsety / 2) + rightEarOffsety, _xscale, _yscale, image_angle, c_white, image_alpha);
draw_sprite_ext(sBeastPart_Ear, leftEarIndex, x + cx, _beasty + (faceOffsety / 2) + leftEarOffsety, -_xscale, _yscale, image_angle, c_white, image_alpha);
drawSetInterpolation(true);
draw_sprite_ext(beastFaceSprite, beastFaceIndex, x + cx, _beasty + faceOffsety, _xscale, _yscale, image_angle, c_white, image_alpha);
_yscale = 0.1 + (0.004 * _drawBreath);
_xscale = 0.1 + (0.004 * _drawBreath);
draw_sprite_ext(sDetailLobbyLeaves, image_index, x + cx, 136, _xscale, _yscale, image_angle, c_white, image_alpha);
