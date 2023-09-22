///scr_assessJump(curActor, startNode, nestNode);

// CURRENTLY NOT USING THIS SCRIPT -------------

/* having an idea of the next jump node connection, determine the which jump is necessary
to reach the next node. Early - Middle - Late Jumps.    */

var A = argument0;
var startNode = argument1;
var nextNode = argument2;

velocityX = curActor.spd / blockSize    // Original in scr_checkForJumpConnections
velocityY = -curActor.jspd/ blockSize;  // Original in scr_checkForJumpConnections
var motionX = 0;
var motionY = 0;

var dir = sign(nextNode.x - startNode.x); 
var f = 0;
var failMid = 0;
var failEarly = 0;
var failLate = 0;

/* returns one of the strings:
    'Early': Jump starts on the beginning edge of the node in whichever direction
        May be useful for when travelling on a walkway and a early jump makes sense for the fastest way
    'Mid': Jump starts in the middle of the node
        Standard Jump
    'Late': Jump starts on the ending edge of the node in whichever direction
    Mid will be tested first and if it is not possible, try early, then late. If all fails, 
*/
/**/
//fallheight = -2;

//while( f < A.maxFallHeight && nextNode.x - (startNode.x + motionX) > 0 ){
if (failMid == 0){
    while( f < A.maxFallHeight && nextNode.x - (startNode.x + motionX) > 0 &&
        // Moving Right before reaching the nextNode
        ((A.x + motionX) - nextNode.x < 0 && startNode.x - nextNode.x < 0) &&
        // Moving Left before reaching the nextNode
        ((A.x + motionX) - nextNode.x > 0 && startNode.x - nextNode.x > 0) 
        
    ){
        
    //for (var f = 0; fallHeight <= A.maxFallHeight; f++){
        // simulate movement until we travel 1 tile in either the x or y direction. Y can go up
        // or down so we use abs whereas x can only increment.
        if (velocityY < A.maxFallSpeed/blockSize)
                velocityY += (oAstar.grav * deltaTime) / blockSize;
                
            motionX += velocityX * deltaTime* blockSize * dir//*1.5;
            motionY += velocityY * deltaTime* blockSize;
            /*
            // Moving Right but then passes the nextNode
            if ((A.x + motionX) - nextNode.x > 0 && startNode.x - nextNode.x < 0)
                A.hspd = A.spd;
            // Moving Left but then passes the nextNode
            else if ((A.x + motionX) - nextNode.x < 0 && startNode.x - nextNode.x > 0)
                A.hspd = -A.spd;
            // Stop Moving if reached or passed destination node
            else
                A.hspd = 0;
            */
        
        if ( place_meeting(startNode.x + motionX, A.y + motionY, oSolid) ){
            failMid = true;
        }
        else{
        // Look for the x because the y is not easily determined. The Actor could jump and reach the nextNode
        // ahead of time and need to drop down. So if it's x is equal or above the nextNode, success.
            //if (startNode.x + motionX == nextNode.x){
            // Moving Right but then passes the nextNode
            if ( (A.x + motionX) - nextNode.x > 0 && startNode.x - nextNode.x < 0 ||
            // Moving Left but then passes the nextNode
            (A.x + motionX) - nextNode.x < 0 && startNode.x - nextNode.x > 0 )
                return 'Mid';
            
        }
        
        f = -2 + (motionY div blockSize);
    }
}

if (failMid){

return 'Early';
}

else if (failEarly){

return 'Late';
}
else{
// Find some way to reconfigure the path. This may involve putting this script elsewhere?....

}

//return 'Mid';

