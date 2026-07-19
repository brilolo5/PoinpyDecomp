function playerBubbleVisual()
{
    switch (stateBeforeBubble)
    {
        case "spin jump":
            sprite_index = sPlayerSpin16;
            image_index += (bubbleVisualScaler * 1.5);
            image_speed = 0;
            bubbleVisualScaler = lerp(bubbleVisualScaler, 0.05, 0.025);
            break;
        
        case "invincible spin jump":
            sprite_index = sPlayerSpin16;
            image_index += (1 * global.timeScale);
            whiteFlash = 1;
            image_speed = 0;
            bubbleVisualScaler = lerp(bubbleVisualScaler, 0.05, 0.025);
            break;
        
        case "slamming - invincible":
            sprite_index = sPlayerSlam;
            image_index = 1;
            whiteFlash = 1;
            image_speed = 0;
            bubbleVisualScaler = lerp(bubbleVisualScaler, 0.05, 0.05);
            break;
        
        case "slamming":
            sprite_index = sPlayerSlam;
            image_index = 1;
            image_speed = 0;
            bubbleVisualScaler = lerp(bubbleVisualScaler, 0.05, 0.05);
            break;
        
        case "free - after spin":
            sprite_index = sPlayerSpin16;
            image_index += (bubbleVisualScaler * (spinSpeed / 12));
            image_speed = 0;
            bubbleVisualScaler = lerp(bubbleVisualScaler, 0.01, 0.1);
            break;
        
        default:
            image_speed = 0;
            break;
    }
}
