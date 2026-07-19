depth = -10000;
offset_y = 4;
host = self;
next_rope = instance_create_depth(x, y + offset_y, depth, oRope);
attach = physics_joint_distance_create(host, next_rope, host.x, host.y, next_rope.x, next_rope.y, false);
physics_joint_set_value(attach, 17, 1);
physics_joint_set_value(attach, 18, 5);

with (next_rope)
    parent = other.id;

repeat (10)
{
    offset_y += 16;
    last_rope = next_rope;
    next_rope = instance_create_depth(x, y + offset_y, depth, oRope);
    link = physics_joint_distance_create(last_rope, next_rope, last_rope.x, last_rope.y, next_rope.x, next_rope.y, false);
    physics_joint_set_value(link, 17, 1);
    physics_joint_set_value(link, 18, 20);
    
    with (next_rope)
        parent = other.last_rope;
}

physics_joint_set_value(link, 17, 1);
physics_joint_set_value(link, 18, 20);
mylastRope = next_rope;
