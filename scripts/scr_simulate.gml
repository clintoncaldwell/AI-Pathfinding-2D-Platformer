///scr_simulate(dataBin type);
/*
Get all movement speeds in terms of tiles. 
For example, if the tile size is 16px divide by 16.

    Simulate movement frame by frame using a reasonable 
    delta time (1/60 will do the trick when targeting 60 fps)
    
Each time we simulate movement check to see if we have travelled 1 tile 
in any direction (up, down, left or right). If so, record that data point.

    Keep doing this until we reach some predefined maximum fall height
*/

// dataBin: stores the delta tile movements of the simulation
// vSpeed: max fall speed of the agent
// gravitySpeed: agent gravity acceleration * deltaTime to get a velocity
// velocity: starting velocity of the agent
// motion: accumulates frame-by-frame movement

// keep track of our fallHeight so that we stop when we reach maxFallHeight
if (argument0 == dataBinJ)
    fallHeight = -2
else
    fallHeight = 0;
    
var dataBin = argument0;

var A = curActor;
//motionX = 0
//motionY = 0
var b = blockSize;
//var gravityspeed = oAstar.grav * deltaTime;
//show_debug_message("scr_simulate on")
while( fallHeight < A.maxFallHeight ){
//for (var f = 0; fallHeight <= A.maxFallHeight; f++){
    // simulate movement until we travel 1 tile in either the x or y direction. Y can go up
    // or down so we use abs whereas x can only increment.
    while (motionX < b && abs(motionY) < b ) {
        //motionY = approach( vspd, A.maxFallSpeed, gravitySpeed )
        if (velocityY < A.maxFallSpeed/blockSize)
            velocityY += (oAstar.grav * global.delta) / blockSize;
            
        motionX += velocityX * global.delta* blockSize//*1.5;
        motionY += velocityY * global.delta* blockSize;
        // moving vertically down - gravity working with vspd
        //if (motionY > b)
            //motionY += (A.vspd + oAstar.grav) * deltaTime;
        
        // moving vertically up - gravity is working against vspd
        //else if (motionY < b)
            //motionY += (A.jspd - oAstar.grav) * deltaTime;
          //  motionY += (A.vspd) * deltaTime;
        
        /*
        while( motionX < b && abs(motionY) < b ) {
        velocityY = (velocityY + oAstar.grav) //A.maxFallSpeed
        
        motionX += A.spd * deltaTime;
        motionY += velocityY * deltaTime;
        */
    }
    /*while( motionX < b && abs( motionY ) < b ){
        //motionY = approach( vspd, A.maxFallSpeed, gravitySpeed )
        motionX += A.hspd * deltaTime;
        motionY += A.vspd * deltaTime;
    }
    */
    // did we move a tile in the x direction?
    if( motionX >= b ){
        // bookkeeping. Increment motion and keep the remainder
        //truncate motion and keep the value cut off in the dataBin
        var xIncr = floor(motionX);
        motionX -= xIncr;
        /*
        if (xIncr != b)
            xIncr = b;
        */
        // no data recorded previously
        if (array_length_2d(dataBin,0) == 1 && dataBin[0,0] == noone){
            dataBin[@ 0 , 0 ] = xIncr
            dataBin[@ 1 , 0 ] = 0;   // y = 0
        }
        else{
            dataBin[@ 0, array_length_2d(dataBin,0) ] = xIncr;
            dataBin[@ 1, array_length_2d(dataBin,0)-1 ] = 0;   // y = 0
        }
            //show_debug_message("databin added")            
            
    
    }
    // did we move a tile in the y direction?
    if( abs( motionY ) >= b ){
        //show_debug_message("motionY > b")
        //truncate motion and keep the value cut off in the dataBin
        var yIncr = floor(motionY); //*blockSize
        motionY -= yIncr;
        
        // no data recorded previously
        if (array_length_2d(dataBin,1) == 1 && dataBin[1,0] == noone){
            dataBin[@ 0 , 0 ] = 0;   // x = 0;
            dataBin[@ 1 , 0 ] = yIncr;
        }
        else{
            dataBin[@ 0 , array_length_2d(dataBin,0) ] = 0;  // x = 0;
            dataBin[@ 1 , array_length_2d(dataBin,0)-1 ] = yIncr;
        }
            
        // only increment our fallHeight when we are falling
        if( yIncr > 0 ){
            fallHeight++;
        }
        //continue;
    }          
}

for(var z=0; z<array_height_2d(dataBin);z++){
    for(var f=0; f<array_length_2d(dataBin,0);f++){
        // any value in dataBin is converted to the size of blockSize
        if (dataBin[@ z,f] > 0)
            dataBin[@ z,f] = b;
        else if (dataBin[@ z,f] < 0 && dataBin[@ z,f] != noone)
             dataBin[@ z,f] = -b;
        else if (dataBin[@ z,f] == noone)
            dataBin[@ z,f] = 0;
    }
    
}
exit;
    /*    
    if (f = 4)
        dataBin[1,f] = -32
    */
    // checks for any values that are the opposite signs than their neighbors and changes them
    // dont check first or last values, wont work - checks array indexes that don't exist
    /*
    if (f > 0 && f < array_length_2d(dataBin,0) -1){
        if (sign(dataBin[0,f-1]) == sign(dataBin[0,f+1])){
            if (sign(dataBin[0,f]) != sign(dataBin[0,f-1]))
                dataBin[0,f] *= -1;
            
        }
    }
    */

// RUN OFF CONNECTIONS - - - - - - - - - - - - - - 
/*
loop through our Nodes and find any ledge Nodes
ensure that we have clearance and no solid tiles in the way of our starting Node
    "playback" our simulated data step-by-step
    check directly below for a solid tile to land on. Add an Edge and bail out if we hit ground.
we didn't land yet so check further down up to our maximum fall 
height for a Node to land on. Add an Edge if we find one.
*/


/*


}

// alter jumpSpeed to simulate different jump heights
velocity = new Vector2( horizontalSpeed, jumpSpeed / 2 )  
// call our simulate method as defined in part 3

velocity = new Vector2( horizontalSpeed, jumpSpeed / 4 )  
// call our simulate method as defined in part 3

//-----------------------------

// figure out the maximum number of tiles we can jump up
jumpHeight = calculateMaxJumpHeightInTiles( jumpVelocity )

// add data for each tile
for i in range( 0, jumpHeight ):  
    jumpUpAndOverData.add( new Point( 0, -1 ) );

// add in the run-off data we already calculated
jumpUpAndOverData.addRange( runoffData );  

*/

