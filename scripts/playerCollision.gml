///playerCollision()
//Handles the player's collision code


var mySolid, mySpikeFloor, mySpikeWall, mySpikeCeiling;

//Spikes
mySpikeFloor = instance_place(x, y+global.yspeed+1, objSpike);
mySpikeWall = instance_place(x+global.xspeed, y, objSpike);
mySpikeCeiling = instance_place(x, y+global.yspeed-1, objSpike);
if (mySpikeFloor >= 0 || mySpikeWall >= 0 || mySpikeCeiling >= 0) && canHit == true
{
    global._health = 0;
    exit;
}


//Floor
mySolid = instance_place(x, y+global.yspeed, objSolid);
if mySolid >= 0 && global.yspeed > 0
{
    y = mySolid.y - (sprite_get_height(mask_index) - sprite_get_yoffset(mask_index));
    ground = true;
    global.yspeed = 0;
    
    if playLandSound == true
        playSFX(sfxLand);
    
    //Note: there used to be a system here that set MM's sprite to the walking sprite when landing
    //However, due to complications such as climbing up ladders, it was a lot of work for such a minor feature
    //Therefore, it has been removed
}


//Wall
mySolid = instance_place(x+global.xspeed, y, objSolid);
if mySolid >= 0 && global.xspeed != 0
{
    if global.xspeed < 0
        x = mySolid.x + 16 + sprite_get_xoffset(mask_index) - sprite_get_bbox_left(mask_index) + 1;
    else
        x = mySolid.x - (sprite_get_width(mask_index) - sprite_get_xoffset(mask_index)) + (sprite_get_width(mask_index) - sprite_get_bbox_right(mask_index)) - 1;
        
    global.xspeed = 0;
}


//Ceiling
mySolid = instance_place(x, y+global.yspeed, objSolid);
if mySolid >= 0 && global.yspeed < 0
{
    y = mySolid.y + 16 + sprite_get_yoffset(mask_index);
    global.yspeed = 0;
}


//Topsolids
mySolid = instance_place(x, y+global.yspeed, objTopSolid);
if mySolid >= 0 && global.yspeed > 0
{
    if !place_meeting(x, y, mySolid)
    {
        y = mySolid.y - (sprite_get_height(mask_index) - sprite_get_yoffset(mask_index));
        ground = true;
        global.yspeed = 0;
        
        if playLandSound == true
            playSFX(sfxLand);
    }
}
