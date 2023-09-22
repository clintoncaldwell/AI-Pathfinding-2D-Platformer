/// Collision with stage------------------------------------

var h = hspd * global.timeMultiplier *global.delta;
var v = vspd * global.timeMultiplier *global.delta;
var sign_h = sign(hspd) ;
var sign_v = sign(vspd) ;

// init variables for each coordinate and put them conditionals 
// where they dynamically change according to where the player is moving
var c_left = bbox_left;
var c_right = bbox_right;
var c_top = bbox_top;
var c_bot = bbox_bottom;

    // Horizontal Collsion
    
// moving right collision starts at left of sprite + moves to the right
if (hspd > 0){
    c_left = bbox_left;
    c_right = bbox_right + h;
}
//moving left - collision starts at right of sprite + moves to the left
else if (hspd < 0){
    c_left = bbox_left + h;
    c_right = bbox_right ;
// hspd is 0 - collison's horizontal at rest
}else{  
    c_left = bbox_left;
    c_right = bbox_right;
}

    // Vertical Collision
    
// moving downwards - collision starts at top of sprite + moves to down
if (vspd > 0){
    c_top = bbox_top;
    c_bot = bbox_bottom + v;
}
//moving upwards - collision starts at bottom of sprite + moves to the up
else if (vspd < 0){
    c_top = bbox_top + v;
    c_bot = bbox_bottom;
//vspd is 0 - collison's vertical at rest
}else{
    c_top = bbox_top;
    c_bot = bbox_bottom;
}

// create collision box
var collisionBox = collision_rectangle(c_left ,c_top, c_right , c_bot, oSolid, 0, true);

// if any collision takes place
if (collisionBox){

    // Horizontal Collision
    if (collision_rectangle(c_left ,bbox_top, c_right , bbox_bottom, oSolid, 0, true)){ 
        var Xincr = 0;
        while/*if */( !collision_rectangle(bbox_left + sign_h + Xincr,bbox_top, bbox_right + sign_h + Xincr, bbox_bottom, oSolid, 0, true))
        {
            x += sign_h;
            //Xincr += sign_h;
        }
        //x += Xincr;
        hspd = 0;
        Xincr = 0;
    }
    
    //Vertical Collision
    if (collision_rectangle(bbox_left ,c_top, bbox_right , c_bot, oSolid, 0, true)){
        var Yincr = 0;
        while/*if */( !collision_rectangle(bbox_left,bbox_top + sign_v + Yincr, bbox_right, bbox_bottom + sign_v + Yincr, oSolid, 0, true))
        {
            y += sign_v;
            //Yincr += sign_v;
        }
        //y += Yincr;
        vspd = 0;
        Yincr = 0;
    }
    
}
/*
// if caught in a solid
while (place_meeting(x,y, oSolid)){
    y -= 1;
}
*/
/*
//var hor_collision = collision_line(x,y, x + hspd, y,oSolid, 0, true);
//var ver_collision = collision_line(x,y, x, y + vspd, oSolid, 0, true);

// Setup Collisions
var hor_collision_left  = collision_rectangle(bbox_left + h,bbox_top, bbox_right , bbox_bottom,oSolid, 0, true);
var hor_collision_right = collision_rectangle(bbox_left,bbox_top, bbox_right + h, bbox_bottom,oSolid, 0, true);

var ver_collision_top = collision_rectangle(bbox_left,bbox_top + v, bbox_right, bbox_bottom, oSolid, 0, true);
var ver_collision_bot = collision_rectangle(bbox_left,bbox_top, bbox_right, bbox_bottom + v, oSolid, 0, true);

// - - - - - - - - - - - - - - -

var sign_h = sign(hspd) ;
var sign_v = sign(vspd) ;

//Horizontal Collision
if (hor_collision_left || hor_collision_right){ 
// Left Collision
    if (hor_collision_left){ 
        while ( !collision_rectangle(bbox_left + sign_h,bbox_top, bbox_right, bbox_bottom, oSolid, 0, true))
        {
            x += sign_h //*global.delta;
        }
    }
    // Right Collision
    else if (hor_collision_right){
        while ( !collision_rectangle(bbox_left,bbox_top, bbox_right + sign(hspd) *global.delta, bbox_bottom, oSolid, 0, true))
        {
            x += sign_h //*global.delta;
        }
    }
    hspd = 0;
}

// - - - - -

//Vertical Collision
if (ver_collision_top || ver_collision_bot){
    // Ceiling Collision
    if (ver_collision_top){ 
        while ( !collision_rectangle(bbox_left,bbox_top + sign_v, bbox_right, bbox_bottom, oSolid, 0, true))
        {
            y+= sign_v //*global.delta;
        }
    }
    // Ground Collision
    else if (ver_collision_bot){
        while ( !collision_rectangle(bbox_left,bbox_top, bbox_right, bbox_bottom + sign_v, oSolid, 0, true))
        {
            y+= sign_v// *global.delta;
        }
    }
    vspd = 0;
}

// - - - - - - - - - - - - - - -
*/

/*
if (hor_collision)
    x = min(x + hspd*global.delta, oSolid.x)
if (ver_collision)
    y = min(y + vspd*global.delta, oSolid.y)
*/


/*
//Horizontal Collision
//if (place_meeting(x + hspd, y , oSolid))

if (hor_collision){
    while (!collision_line(x,y, x + sign(hspd) *global.delta, y,oSolid, 0, true))
    {
        x += sign(hspd) * global.delta;
    }
    hspd = 0;
}

//Vertical Collision
//if (place_meeting(x, y + vspd , oSolid))
if (ver_collision){
    while (!collision_line(x,y, x, y + sign(vspd) *global.delta, oSolid, 0, true))
    {
        y+= sign(vspd) * global.delta;
    }
    vspd = 0;
}
*/
// ------------------------------------------

/*

//Horizontal Collision
if (hor_collision){
    while ( !collision_rectangle(bbox_left,bbox_top, bbox_right + sign(hspd) *global.delta, bbox_bottom, oSolid, 0, true))
    {
        x += sign(hspd) * global.delta;
    }
    hspd = 0;
}

//Vertical Collision


// if vspd is negative check above head for collision
if (ver_collision){

    while ( !collision_rectangle(bbox_left,bbox_top, bbox_right, bbox_bottom + sign(vspd) *global.delta, oSolid, 0, true))
    {
        y+= sign(vspd) * global.delta;
    }
    vspd = 0;
}
*/
