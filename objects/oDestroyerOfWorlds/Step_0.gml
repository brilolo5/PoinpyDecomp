var distance = 512;
y = clamp(round((oPlayer.y + distance) / 16) * 16, y - 64, y);
instance_activate_region(bbox_left, bbox_top, bbox_right - bbox_left, bbox_bottom - bbox_top, 1);
var foodInstanceList = ds_list_create();
var foodInstanceNumber = collision_rectangle_list(bbox_left, bbox_top, bbox_right, bbox_bottom, all, 0, 1, foodInstanceList, false);

if (foodInstanceNumber > 0)
{
    for (var i = 0; i < foodInstanceNumber; i += 1)
    {
        var object = foodInstanceList[| i].object_index;
        
        switch (object)
        {
            case parentControl:
            case oPlayer:
            case parentMenu:
            case oCamera:
                break;
            
            default:
                instance_destroy(foodInstanceList[| i]);
                break;
        }
    }
}

ds_list_destroy(foodInstanceList);
