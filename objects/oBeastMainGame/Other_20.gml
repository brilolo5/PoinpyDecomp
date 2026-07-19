switch (faceState)
{
    case "end glug delicious":
        if (beastFaceStateInitialize())
            playSoundEndingBeastDeliciousSparkle();
        
        var _tension = 0.4;
        var _dampening = 0.25;
        var _displacement = 1 - springWobbleValue;
        springWobbleSpeed += ((_displacement * _tension) - (_dampening * springWobbleSpeed));
        springWobbleValue += springWobbleSpeed;
        shrinkScaleOffset = (1 - springWobbleValue) * 0.1;
        beastFaceSpriteSet(sBeastPart_FaceGlug_Delicious);
        drawBeastFace(0);
        
        if (beastFaceStateTimer(165))
        {
            beastFaceStateChange("end charge up");
            beastChargeScaleAnim = 0;
        }
        
        break;
    
    case "end charge up":
        if (beastFaceStateInitialize())
            playSoundEndingInhale();
        
        beastChargeScaleAnim = approach(beastChargeScaleAnim, 1, doDelta(0.0033333333333333335));
        beastFaceSpriteSet(sTransBeastFace_Delicious);
        var _beastChargeScaleAnim = animcurveGetValueAtPos_combine2(curveExpo, "curve1", curveExpoInv, "curve1", 0.5, beastChargeScaleAnim);
        shrinkScaleOffset = 0.075 * _beastChargeScaleAnim;
        beastShake(1, beastChargeScaleAnim * 0.5);
        
        if (drawBeastFace_AnimLoopEnd(0.15, 1))
        {
            beastFaceStateChange("end transcended");
            
            with (oEndingSequence)
                nextSequence("beam - appear");
            
            shrinkScaleOffset = 0.1;
            var _sparkSpeed = 0.8;
            beastEffect(sTransBeast_AuraSparkFx, 0, 0, _sparkSpeed, 0.1 * (1 + shrinkScaleOffset) * 2, 0, 0);
            beastEffect(sTransBeast_AuraSparkFx, 0, 0, _sparkSpeed, 0.1 * (1 + shrinkScaleOffset) * 2, 0, 0, -1);
        }
        
        break;
    
    case "end transcended":
        if (beastFaceStateInitialize())
            playSoundEndingLaser();
        
        beastFaceSpriteSet(sTransBeastFace_Transcended);
        beastScaling();
        beastPositioning();
        drawBeastBody(sTransBeast_Body);
        drawSetInterpolation(false);
        draw_sprite_ext(sTransBeast_Ear, 0, beastBasex, beastDrawy, beastXscale, beastYscale, image_angle, c_white, image_alpha);
        draw_sprite_ext(sTranBeast_ThirdEyeLight, 0, beastBasex, beastDrawy - 16 - 5 - 2, beastXscale, beastYscale, image_angle, c_white, image_alpha);
        draw_sprite_ext(sTransBeast_EyeLight, current_time / 100, beastBasex - 14 - 2, beastDrawy - 8 - 2, beastXscale, beastYscale, image_angle, c_white, image_alpha);
        draw_sprite_ext(sTransBeast_EyeLight, current_time / 100, beastBasex + 14, beastDrawy - 8 - 2, -beastXscale, beastYscale, image_angle, c_white, image_alpha);
        drawSetInterpolation(true);
        draw_sprite_ext(sTransBeastFace_Transcended, 0, faceDrawx, faceDrawy, faceXscale, faceYscale, image_angle, c_white, image_alpha);
        break;
    
    default:
        break;
}
