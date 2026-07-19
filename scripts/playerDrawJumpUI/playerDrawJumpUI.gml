function playerDrawJumpUI(arg0, arg1)
{
    var _checkMbHeld = (mbHeld && slingLength >= 2) ? 1 : 0 && readyToJump && !mouse_check_button_released(mb_left);
    
    if (currentState != "dead")
    {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        var _drawx = arg0;
        var _drawy = arg1;
        var jumpTimesAmount = clamp(global.jumpTimes - _checkMbHeld, 0, 99999);
        var _jumpTimesMax = jumpTimesMaxWithAbility;
        
        if (jumpTimesAmount > 0)
        {
            var jumpTimesOrbDrawSpaceInbetween = 7;
            var jumpTimesOrbDrawPosxLeft = (jumpTimesAmount - 1) * (jumpTimesOrbDrawSpaceInbetween / 2);
            jumpTimesOrbDrawPosxLeftTween = lerp(jumpTimesOrbDrawPosxLeftTween, jumpTimesOrbDrawPosxLeft, 0.5);
            var _posyTweenMax = 16;
            jumpTimesOrbDrawPosyTween = approach(jumpTimesOrbDrawPosyTween, 0, _posyTweenMax / 8);
            jumpTimesOrbSprite = sJumpCounts00;
            var jumpTimesOrbWidth = sprite_get_width(jumpTimesOrbSprite);
            var jumpTimesOrbWidthScale = 0.1;
            var jumpTimesOrbHeight = sprite_get_height(jumpTimesOrbSprite);
            var jumpTimesOrbHeightScale = 0.1;
            var jumpTimesOrbImageIndex = (currentState == "slamming") ? 1 : 0;
            var i = 0;
            
            if (jumpTimesAmount > 4)
            {
                var fakeJumpTimes = 1;
                jumpTimesOrbDrawPosxLeft = (fakeJumpTimes - 1 - 1) * (jumpTimesOrbDrawSpaceInbetween / 2);
                jumpTimesOrbDrawPosxLeftTween = jumpTimesOrbDrawPosxLeft;
                
                repeat (fakeJumpTimes)
                {
                    if (i >= (fakeJumpTimes - 1))
                    {
                        jumpTimesOrbWidthScale = 0.1;
                        jumpTimesOrbHeightScale = jumpTimesOrbWidthScale;
                    }
                    
                    var jumpTimesOrbDrawPosx = (_drawx + jumpTimesOrbDrawPosxLeftTween) - (i * jumpTimesOrbDrawSpaceInbetween) - 2;
                    var jumpTimesOrbDrawPosy = (_drawy - 16 - 6) + abs((_drawx - jumpTimesOrbDrawPosx) / 4) + jumpTimesOrbDrawPosyTween;
                    draw_sprite_ext(jumpTimesOrbSprite, jumpTimesOrbImageIndex, jumpTimesOrbDrawPosx, jumpTimesOrbDrawPosy, jumpTimesOrbWidthScale, jumpTimesOrbHeightScale, 0, c_white, 1);
                    i += 1;
                }
                
                var jumpTimesTextPosy = (_drawy - 19 - 2) + jumpTimesOrbDrawPosyTween;
                drawSetAlign(0, 1);
                drawTextOutlined((_drawx + 1) - 2, jumpTimesTextPosy, locGetNumFont(true) + string(jumpTimesAmount), make_color_rgb(255, 255, 255), make_color_rgb(46, 50, 59), 0, 1);
                jumpRefillOrbEffect = 0;
            }
            else
            {
                i = approach(i, _jumpTimesMax, jumpRefillSequence);
                var _extraAndGoodboyBothEquipped = -1;
                
                if (abilityCheck(UnknownEnum.Value_7))
                {
                    jumpTimesOrbSprite = sJumpCounts01;
                    _extraAndGoodboyBothEquipped += 1;
                }
                
                if (abilityCheck(UnknownEnum.Value_13))
                {
                    jumpTimesOrbSprite = sJumpCounts02;
                    _extraAndGoodboyBothEquipped += 1;
                }
                
                while (i < jumpTimesAmount)
                {
                    var jumpTimesOrbDrawPosx = (_drawx + jumpTimesOrbDrawPosxLeftTween) - (i * jumpTimesOrbDrawSpaceInbetween);
                    var jumpTimesOrbDrawPosy = (_drawy - 16 - 6) + abs((_drawx - jumpTimesOrbDrawPosx) / 4);
                    draw_sprite_ext(jumpTimesOrbSprite, jumpTimesOrbImageIndex, jumpTimesOrbDrawPosx, jumpTimesOrbDrawPosy, jumpTimesOrbWidthScale, jumpTimesOrbHeightScale, 0, c_white, 1);
                    jumpTimesOrbSprite = sJumpCounts00;
                    
                    if (_extraAndGoodboyBothEquipped)
                    {
                        jumpTimesOrbSprite = sJumpCounts01;
                        _extraAndGoodboyBothEquipped = 0;
                    }
                    
                    i += 1;
                }
                
                jumpTimesOrbSprite = sJumpCounts00;
                
                if (jumpRefillSequence > 0)
                {
                    var _effectOrbScale = jumpTimesOrbWidthScale + (jumpTimesOrbWidthScale * jumpRefillOrbEffect * 0.5);
                    i = 0;
                    var _partialRefillOrNo = jumpRefillSequence < _jumpTimesMax;
                    jumpRefillSequence = clamp(jumpRefillSequence, 0, 4);
                    
                    repeat (jumpRefillSequence)
                    {
                        var jumpTimesOrbDrawPosx = (_drawx + jumpTimesOrbDrawPosxLeftTween) - (i * jumpTimesOrbDrawSpaceInbetween);
                        
                        if (_partialRefillOrNo)
                            jumpTimesOrbDrawPosx = lerp(jumpTimesOrbDrawPosx, _drawx, jumpTimesOrbDrawPosyTween / _posyTweenMax);
                        
                        var jumpTimesOrbDrawPosy = (_drawy - 16 - 6) + abs((_drawx - jumpTimesOrbDrawPosx) / 4) + jumpTimesOrbDrawPosyTween;
                        draw_sprite_ext(jumpTimesOrbSprite, jumpTimesOrbImageIndex, jumpTimesOrbDrawPosx, jumpTimesOrbDrawPosy, _effectOrbScale, _effectOrbScale, 0, c_white, 1);
                        i += 1;
                    }
                    
                    jumpRefillOrbEffect = approach(jumpRefillOrbEffect, 0, 0.125);
                    
                    if (jumpTimesOrbDrawPosyTween <= 0)
                    {
                        jumpRefillSequence = 0;
                        jumpRefillOrbEffect = 1;
                    }
                }
            }
        }
    }
    
    swipeJumporbx = x;
    swipeJumporby = y - 24;
}
