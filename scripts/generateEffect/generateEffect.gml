function generateEffect(arg0, arg1, arg2, arg3)
{
    switch (arg2)
    {
        case "template":
            var _blinkAfter = 12;
            var _destroyAfter = 24;
            var _pieces;
            
            for (var i = 0; i < 2; i += 1)
            {
                _pieces[i] = instance_create_depth(arg0, arg1, depth, effectGeneral);
                
                with (_pieces[i])
                {
                    grav = 0.1;
                    gravityEnabled = 1;
                    maxFallSpeed = 4;
                    startBlinkingAfter = _blinkAfter;
                    destroyAfter = _destroyAfter;
                    xShrink = 1;
                    yShrink = 1;
                    xscaleBase = 1;
                    yscaleBase = 1;
                    xDirection = 1;
                    yDirection = 1;
                    xscale = xShrink * xDirection * xscaleBase;
                    yscale = yShrink * yDirection * yscaleBase;
                    sprite_index = sEnPot;
                    mask_index = sprite_index;
                    image_speed = 0;
                    collideWithWall = 1;
                }
            }
            
            with (_pieces[0])
            {
                launchSpeed = random_range(1, 1.5);
                var _launchRandomAngle = 15;
                _launchRandomAngle = random_range(-_launchRandomAngle, _launchRandomAngle) + 135;
                launchDirection = _launchRandomAngle;
                xsp = lengthdir_x(launchSpeed, launchDirection);
                ysp = lengthdir_y(launchSpeed, launchDirection);
                image_index = 1;
            }
            
            with (_pieces[1])
            {
                launchSpeed = random_range(1, 1.5);
                var _launchRandomAngle = 15;
                _launchRandomAngle = random_range(-_launchRandomAngle, _launchRandomAngle) + 45;
                launchDirection = _launchRandomAngle;
                xsp = lengthdir_x(launchSpeed, launchDirection);
                ysp = lengthdir_y(launchSpeed, launchDirection);
                image_index = 2;
            }
            
            break;
        
        case "pot full animation":
            _blinkAfter = 120;
            _destroyAfter = 120;
            _effect = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_effect)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 0;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                animationSpeed = 0.35;
                destroyAfterAnimation = 1;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = 0.1;
                yscaleBase = 0.1;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                mask_index = sprite_index;
                sprite_index = sPotFullAnimation00;
                image_speed = 0;
                collideWithWall = 0;
                xsp = 0;
                ysp = 0;
                image_index = 3;
            }
            
            break;
        
        case "pot pieces":
            _blinkAfter = 12;
            _destroyAfter = 24;
            
            for (var i = 0; i < 2; i += 1)
            {
                _pieces[i] = instance_create_depth(arg0, arg1, depth, effectGeneral);
                
                with (_pieces[i])
                {
                    grav = 0.1;
                    gravityEnabled = 1;
                    maxFallSpeed = 4;
                    startBlinkingAfter = _blinkAfter;
                    destroyAfter = _destroyAfter;
                    xShrink = 1;
                    yShrink = 1;
                    xscaleBase = 0.1;
                    yscaleBase = 0.1;
                    xDirection = 1;
                    yDirection = 1;
                    xscale = xShrink * xDirection * xscaleBase;
                    yscale = yShrink * yDirection * yscaleBase;
                    mask_index = mask_8x8;
                    sprite_index = sPot00;
                    image_speed = 0;
                    collideWithWall = 1;
                }
            }
            
            with (_pieces[0])
            {
                launchSpeed = random_range(2, 3);
                var _launchRandomAngle = 15;
                _launchRandomAngle = random_range(-_launchRandomAngle, _launchRandomAngle) + 135;
                launchDirection = _launchRandomAngle;
                xsp = lengthdir_x(launchSpeed, launchDirection);
                ysp = lengthdir_y(launchSpeed, launchDirection);
                image_index = choose(1, 3, 5, 7, 9);
            }
            
            with (_pieces[1])
            {
                launchSpeed = random_range(2, 3);
                var _launchRandomAngle = 15;
                _launchRandomAngle = random_range(-_launchRandomAngle, _launchRandomAngle) + 45;
                launchDirection = _launchRandomAngle;
                xsp = lengthdir_x(launchSpeed, launchDirection);
                ysp = lengthdir_y(launchSpeed, launchDirection);
                image_index = choose(2, 4, 6, 8);
            }
            
            break;
        
        case "bird feathers":
            _blinkAfter = 36;
            _destroyAfter = 48;
            var _pieceAmount = 2;
            
            for (var i = 0; i < _pieceAmount; i += 1)
            {
                _pieces[i] = instance_create_depth(arg0, arg1, depth, effectGeneral);
                
                with (_pieces[i])
                {
                    grav = -0.02;
                    gravityEnabled = 1;
                    maxFallSpeed = 4;
                    fric = 0.02;
                    imageAngle = -45;
                    spinSpeed = 3;
                    spinFriction = 0.1;
                    startBlinkingAfter = _blinkAfter;
                    destroyAfter = _destroyAfter;
                    xShrink = 1;
                    yShrink = 1;
                    xscaleBase = 0.1;
                    yscaleBase = 0.1;
                    xDirection = 1;
                    yDirection = 1;
                    xscale = xShrink * xDirection * xscaleBase;
                    yscale = yShrink * yDirection * yscaleBase;
                    sprite_index = sEnemyRedBird_feather;
                    mask_index = sFxFeathersTest;
                    image_speed = 0;
                    image_index = choose(0, 1);
                    collideWithWall = 1;
                }
            }
            
            var _halfAmount = round(_pieceAmount / 2);
            
            for (var i = 0; i < _halfAmount; i += 1)
            {
                with (_pieces[i])
                {
                    launchSpeed = random_range(0.5, 1.5);
                    var _launchRandomAngle = 15;
                    _launchRandomAngle = random_range(-_launchRandomAngle, _launchRandomAngle) + 315;
                    launchDirection = _launchRandomAngle;
                    xsp = lengthdir_x(launchSpeed, launchDirection);
                    ysp = lengthdir_y(launchSpeed, launchDirection);
                    image_index = 1;
                }
            }
            
            for (var i = _halfAmount; i < _pieceAmount; i += 1)
            {
                with (_pieces[i])
                {
                    launchSpeed = random_range(0.5, 1.5);
                    var _launchRandomAngle = 15;
                    _launchRandomAngle = random_range(-_launchRandomAngle, _launchRandomAngle) + 225;
                    launchDirection = _launchRandomAngle;
                    xsp = lengthdir_x(launchSpeed, launchDirection);
                    ysp = lengthdir_y(launchSpeed, launchDirection);
                    image_index = 2;
                    xDirection = -1;
                }
            }
            
            break;
        
        case "tento shells":
            _blinkAfter = 18;
            _destroyAfter = _blinkAfter;
            _pieceAmount = 5;
            
            for (var i = 0; i < _pieceAmount; i += 1)
            {
                _pieces[i] = instance_create_depth(arg0, arg1, depth, effectGeneral);
                
                with (_pieces[i])
                {
                    grav = 0.25;
                    gravityEnabled = 1;
                    maxFallSpeed = 1;
                    fric = 0.1;
                    launchSpeed = 2;
                    var _launchAngleStart = 90;
                    var _launchAngleUnit = -(360 / _pieceAmount);
                    launchDirection = _launchAngleStart + (_launchAngleUnit * i);
                    xsp = lengthdir_x(launchSpeed, launchDirection);
                    ysp = lengthdir_y(launchSpeed, launchDirection);
                    imageAngle = 0;
                    spinSpeed = 0;
                    spinFriction = 0;
                    startBlinkingAfter = _blinkAfter;
                    destroyAfter = _destroyAfter;
                    xShrink = 1;
                    yShrink = 1;
                    xscaleBase = 0.1;
                    yscaleBase = 0.1;
                    xDirection = 1;
                    yDirection = 1;
                    xscale = xShrink * xDirection * xscaleBase;
                    yscale = yShrink * yDirection * yscaleBase;
                    sprite_index = sTentoBall_DeadShellParts1;
                    mask_index = sFxFeathersTest;
                    image_speed = 0;
                    image_index = i;
                    collideWithWall = 1;
                }
            }
            
            break;
        
        case "fruit plate flying":
            _blinkAfter = 36;
            _destroyAfter = 48;
            
            with (instance_create_depth(arg0, arg1, depth, effectGeneral))
            {
                grav = 0.075;
                gravityEnabled = 1;
                maxFallSpeed = 4;
                launchSpeed = 2;
                var _launchRandomAngle = 5;
                _launchRandomAngle = (random_range(-_launchRandomAngle, _launchRandomAngle) + 90) - (20 * arg3);
                launchDirection = _launchRandomAngle;
                xsp = lengthdir_x(launchSpeed, launchDirection);
                ysp = lengthdir_y(launchSpeed, launchDirection);
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                spinSpeed = 15;
                spinFriction = 0.1;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = 0.1;
                yscaleBase = 0.1;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sEnFruitHandlerHand;
                mask_index = mask_8x8;
                image_speed = 0;
                image_index = 1;
                collideWithWall = 0;
            }
            
            break;
        
        case "HP loss":
            _blinkAfter = 18;
            _destroyAfter = 36;
            var _piece = instance_create_depth(arg0, arg1, depth, effectGeneralGUI);
            
            with (_piece)
            {
                grav = 0.1;
                gravityEnabled = 1;
                maxFallSpeed = 4;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = 0.1;
                yscaleBase = 0.1;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                imageAngle = 20;
                sprite_index = sUIheart;
                image_index = 0;
                mask_index = sprite_index;
                image_speed = 0;
                color = make_color_rgb(69, 80, 97);
                collideWithWall = 0;
                launchSpeed = 1;
                var _launchRandomAngle = 15;
                _launchRandomAngle = random_range(-_launchRandomAngle, _launchRandomAngle) + 135;
                launchDirection = 80;
                xsp = lengthdir_x(launchSpeed, launchDirection);
                ysp = lengthdir_y(launchSpeed, launchDirection);
            }
            
            break;
        
        case "jump pad bomb":
            _blinkAfter = 60;
            _destroyAfter = 60;
            var _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 0;
                xsp = 0;
                ysp = 0;
                y -= 4;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                sprite_index = sFxExplosion;
                mask_index = sprite_index;
                scale = 60 / sprite_get_width(sprite_index);
                xShrink = 1;
                yShrink = 1;
                xscaleBase = scale;
                yscaleBase = scale;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                screenShake(8, 5);
                sleep(3);
                animationSpeed = 0.5;
                destroyAfterAnimation = 1;
                collideWithWall = 0;
            }
            
            break;
        
        case "temp white flash":
            _blinkAfter = 60;
            _destroyAfter = 60;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 0;
                xsp = 0;
                ysp = 0;
                disregardTimescale = 1;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = 0.08333333333333333;
                yscaleBase = 0.08333333333333333;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sFlashCircle24;
                mask_index = sprite_index;
                animationSpeed = 0.5;
                destroyAfterAnimation = 1;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "temp white flash in timescale":
            _blinkAfter = 60;
            _destroyAfter = 60;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 0;
                xsp = 0;
                ysp = 0;
                disregardTimescale = 0;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = 0.08333333333333333;
                yscaleBase = 0.08333333333333333;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sFlashCircle24;
                mask_index = sprite_index;
                animationSpeed = 0.5;
                destroyAfterAnimation = 1;
                collideWithWall = 0;
            }
            
            generateEffect(oPlayer.x, oPlayer.bbox_bottom, "enemy death smoke", 0);
            generateEffect(oPlayer.x, oPlayer.bbox_bottom, "stomp impact flash", 0);
            return _fx;
        
        case "temp juice splash":
            _blinkAfter = 60;
            _destroyAfter = 60;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0.2;
                gravityEnabled = 1;
                maxFallSpeed = 0;
                var _randDir = 90;
                _randDir += random_range(-45, 45);
                var _randSp = random_range(2.5, 3);
                fric = 0.01;
                xsp = lengthdir_x(_randSp, _randDir);
                ysp = lengthdir_y(_randSp, _randDir);
                imageAngle = _randDir;
                setColor = choose(make_color_rgb(248, 45, 97), make_color_rgb(36, 145, 249), make_color_rgb(65, 231, 125), make_color_rgb(225, 223, 1));
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                var _randBaseScale = 0.3076923076923077;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = _randBaseScale;
                yscaleBase = _randBaseScale;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = choose(sSplashEffectTest00, sSplashEffectTest01, sSplashEffectTest02);
                mask_index = sprite_index;
                animationSpeed = random_range(0.15, 0.35);
                destroyAfterAnimation = 1;
                disregardTimescale = true;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "general smoke":
            _blinkAfter = 60;
            _destroyAfter = 60;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0.2;
                gravityEnabled = 1;
                maxFallSpeed = 0;
                var _randDir = arg3;
                _randDir += 0;
                var _randSp = 2.5;
                fric = 0.125;
                xsp = lengthdir_x(_randSp, _randDir);
                ysp = lengthdir_y(_randSp, _randDir);
                imageAngle = 0;
                setColor = make_color_rgb(255, 255, 255);
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                var _randBaseScale = 0.23529411764705882;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = _randBaseScale;
                yscaleBase = _randBaseScale;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sSplashEffectTest00;
                mask_index = sprite_index;
                animationSpeed = 0.2;
                destroyAfterAnimation = 1;
                disregardTimescale = true;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "slam land":
            var __y = arg1 + 3;
            generateEffect(arg0, __y, "general smoke", 0);
            generateEffect(arg0, __y, "general smoke", 180);
            break;
        
        case "soft wall contact":
            _blinkAfter = 60;
            _destroyAfter = 60;
            
            repeat (1)
            {
                _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
                
                with (_fx)
                {
                    grav = 0;
                    gravityEnabled = 0;
                    maxFallSpeed = 0;
                    var _randDir = arg3;
                    _randDir += random_range(-90, 90);
                    var _randSp = 0;
                    fric = 0.075;
                    xsp = lengthdir_x(_randSp, _randDir);
                    ysp = lengthdir_y(_randSp, _randDir);
                    imageAngle = random(360);
                    setColor = make_color_rgb(255, 255, 255);
                    startBlinkingAfter = _blinkAfter;
                    destroyAfter = _destroyAfter;
                    var _randBaseScale = 0.25;
                    xShrink = 1;
                    yShrink = 1;
                    xscaleBase = _randBaseScale;
                    yscaleBase = _randBaseScale;
                    xDirection = 1;
                    yDirection = 1;
                    xscale = xShrink * xDirection * xscaleBase;
                    yscale = yShrink * yDirection * yscaleBase;
                    sprite_index = sSplashEffectTest00;
                    mask_index = sprite_index;
                    animationSpeed = 0.2;
                    destroyAfterAnimation = 1;
                    disregardTimescale = true;
                    collideWithWall = 0;
                }
            }
            
            return _fx;
        
        case "enemy death smoke":
            repeat (6)
            {
                var _dir = choose(0, 180);
                _dir += random_range(-60, 60);
                
                with (generateEffect(x, y, "general smoke", _dir))
                {
                    sprite_index = sSplashEffectTest00;
                    var _randSp = random_range(2.75, 3.25);
                    setColor = choose(make_color_rgb(255, 255, 255), make_color_rgb(176, 183, 195), make_color_rgb(245, 246, 247));
                    fric = 0.15;
                    grav = 0.2;
                    xsp = lengthdir_x(_randSp, _dir);
                    ysp = lengthdir_y(_randSp, _dir);
                    animationSpeed = random_range(0.15, 0.2);
                    var _randBaseScale = random_range(0.125, 0.25);
                    xShrink = 1;
                    yShrink = 1;
                    xscaleBase = _randBaseScale;
                    yscaleBase = _randBaseScale;
                    xDirection = 1;
                    yDirection = 1;
                    xscale = xShrink * xDirection * xscaleBase;
                    yscale = yShrink * yDirection * yscaleBase;
                }
            }
            
            break;
        
        case "stomp impact flash":
            _blinkAfter = 60;
            _destroyAfter = 60;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 0;
                xsp = 0;
                ysp = 0;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                xShrink = 1;
                yShrink = 1;
                var _baseScale = 0.6;
                xscaleBase = _baseScale;
                yscaleBase = _baseScale;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sFxImpactStar;
                mask_index = sprite_index;
                animationSpeed = 0.5;
                destroyAfterAnimation = 1;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "fruit get":
            _blinkAfter = 60;
            _destroyAfter = 60;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 0;
                xsp = 0;
                ysp = 0;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                imageAngle = arg3;
                xShrink = 1;
                yShrink = 1;
                var _scale = 0.18000000000000002;
                xscaleBase = _scale;
                yscaleBase = _scale;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sFxFruitGetFlash;
                mask_index = sprite_index;
                animationSpeed = 1;
                destroyAfterAnimation = 1;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "launch seq twinkle star":
            _blinkAfter = 999;
            _destroyAfter = 999;
            arg0 = roomXToGui(arg0);
            arg1 = roomYToGui(arg1);
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneralGUI);
            
            with (_fx)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 10;
                var _randDir = 90;
                _randDir += random_range(-45, 45);
                var _randSp = 3;
                fric = 0;
                xsp = 0;
                ysp = 2.5;
                imageAngle = 0;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                var _scale = 0.1;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = _scale;
                yscaleBase = _scale;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sStarFruit_00;
                mask_index = sprite_index;
                animationSpeed = 0;
                destroyAfterAnimation = 0;
                disregardTimescale = false;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "launch seq light trail":
            _blinkAfter = 999;
            _destroyAfter = 999;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 999;
                var _randDir = 90;
                _randDir += random_range(-45, 45);
                var _randSp = 3;
                fric = 0;
                xsp = 0;
                ysp = 30;
                imageAngle = 90;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                var _scale = 0.1;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = _scale * 3;
                yscaleBase = _scale;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sTrajectoryDash;
                mask_index = sprite_index;
                animationSpeed = 0;
                destroyAfterAnimation = 0;
                disregardTimescale = false;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "magma flare":
            _blinkAfter = 120;
            _destroyAfter = 120;
            arg0 = roomXToGui(arg0);
            arg1 = roomYToGui(arg1);
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneralGUI);
            
            with (_fx)
            {
                grav = 0.2;
                gravityEnabled = 1;
                maxFallSpeed = 10;
                var _randDir = 90;
                _randDir += random_range(-45, 45);
                var _randSp = 3;
                fric = 0;
                xsp = lengthdir_x(_randSp, arg3);
                ysp = lengthdir_y(_randSp, arg3);
                imageAngle = 0;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                var _scale = 0.1;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = _scale;
                yscaleBase = _scale;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = sMagmaFlareHead;
                sprite_index = sMagmaFlareTail;
                mask_index = sprite_index;
                animationSpeed = 0.1;
                destroyAfterAnimation = 1;
                disregardTimescale = false;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "glass shard":
            _piece = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_piece)
            {
                grav = 0.1;
                gravityEnabled = 1;
                maxFallSpeed = 4;
                var _sp = 2;
                xsp = lengthdir_x(_sp, arg3);
                ysp = lengthdir_y(_sp, arg3);
                startBlinkingAfter = 30;
                destroyAfter = startBlinkingAfter + 10;
                var _randScale = 0.1;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = _randScale;
                yscaleBase = _randScale;
                xDirection = choose(-1, 1);
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                imageAngle = random(360);
                sprite_index = sGlassShard;
                mask_index = mask_8x8;
                image_index = irandom(sprite_get_number(sGlassShard));
                collideWithWall = 1;
            }
            
            return _piece;
        
        case "glass shard dramatic":
            _piece = generateEffect(arg0, arg1, "glass shard", arg3);
            
            with (_piece)
            {
                var _sp = random_range(3, 6);
                xsp = lengthdir_x(_sp, arg3);
                ysp = lengthdir_y(_sp, arg3);
                startBlinkingAfter = irandom_range(80, 120);
                destroyAfter = startBlinkingAfter + 20;
            }
            
            return _piece;
        
        case "logo sparkle":
            _blinkAfter = 60;
            _destroyAfter = 60;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 0;
                xsp = 0;
                ysp = random_range(-0.1, -0.02);
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = 0.08000000000000002;
                yscaleBase = xscaleBase;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = choose(sBeastPart_FxSparkle00, sBeastPart_FxSparkle01);
                mask_index = sprite_index;
                animationSpeed = random_range(0.15, 0.2);
                destroyAfterAnimation = 1;
                collideWithWall = 0;
            }
            
            return _fx;
        
        case "lobby sparkle":
            var _color = arg3;
            var _sprite = choose(sLobbySparkleA, sLobbySparkleB, sLobbySparkleC, sLobbySparkleD);
            _blinkAfter = 60;
            _destroyAfter = 60;
            _fx = instance_create_depth(arg0, arg1, depth, effectGeneral);
            
            with (_fx)
            {
                setColor = _color;
                grav = 0;
                gravityEnabled = 0;
                maxFallSpeed = 0;
                xsp = 0;
                ysp = 0;
                startBlinkingAfter = _blinkAfter;
                destroyAfter = _destroyAfter;
                xShrink = 1;
                yShrink = 1;
                xscaleBase = 0.1;
                yscaleBase = xscaleBase;
                xDirection = 1;
                yDirection = 1;
                xscale = xShrink * xDirection * xscaleBase;
                yscale = yShrink * yDirection * yscaleBase;
                sprite_index = _sprite;
                mask_index = sprite_index;
                animationSpeed = 0.15;
                destroyAfterAnimation = 1;
                collideWithWall = 0;
            }
            
            return _fx;
    }
}
