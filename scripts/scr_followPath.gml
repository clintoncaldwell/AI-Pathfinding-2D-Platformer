///scr_followPath();

// Have Actor follow the path

/*  1. Set currentNode to be the next Node in the path
    2. Check edgetype of the next path instance, in relation to nextNode
    3. Depending on edgetype, perform different functions
    4. CurNode changes each cycle
*/
    
var A = curActor;
var dir = 0;

// Ensure that current actor along with startNode and endNode exist inGame
if (instance_exists(A) && instance_exists(startNode) && instance_exists(endNode)){
    // If there are more than two nodes in the path to follow
    if (array_length_1d(path) >= 2 && startNode != endNode){
        // find the edgetype for the nextNode, in relation to startNode
        for(var n=0; n< array_length_2d(startNode.edges,0);n++){
            var edge_id = startNode.edges[0,n]
            var edge_type = startNode.edges[1,n]
            var nextNode = path[array_length_1d(path)-2];//nextNode is the node after the start node
            //dir = sign(nextNode.x - startNode.x); 
            dir = sign(nextNode.x - A.x); 
            
            if (edge_id == nextNode){
            // Platform Connection  ---------------
                if (edge_type == 'EdgeType.Platform'){
                    if (array_length_1d(path) > 2)
                        A.hspd = A.spd * dir;
                }
                // For bigger sprites I need the inner edge to be able to leave the platform and drop below on a ledge
                
            // Jump + Runoff + StepDown Conncections     ---------------
                else if (edge_type == 'EdgeType.Jump' || edge_type == 'EdgeType.RunOff' || 
                        edge_type == 'EdgeType.StepDown'){
                    var nx = 0 + nextNode.x
                    var sx = 0 + startNode.x
                    // edge of Actor opposite to the direction moving in path
                    var AEdge = A.x - (A.width/2 * sign(nx - sx)); 
                    // edge of Nextnode in path opposite the direction Actor is moving
                    var nextEdge = nx - (blockSize/2 * sign(nx - sx)); 
                    //
                    var edgeDir = sign(nextEdge - AEdge);
                    
                    if ((AEdge - nextEdge + A.hspd * global.timeMultiplier *global.delta) * edgeDir >= 0){
                        A.x = nextEdge + A.width/2 * sign(nx - sx);
                        
                        A.hspd = 0;
                    }else{    
                        A.hspd = A.spd * edgeDir;
                    }
                    
                    
                    if (edge_type == 'EdgeType.Jump'){
    
                        // set JumpOffset 
                        if ((nextNode.x - startNode.x) * sign(A.hspd) > blockSize*2){   
                            jumpOffset = blockSize/2; 
                            
                        }else{
                            jumpOffset = 0;
                            // if a block is above actor's head, increase jumpOffset to edge to avoid bumping head above
                            with(A){
                                for (var k=0; k<5; k++){
                                    if (place_meeting(
                                    oAstar.startNode.x, oAstar.startNode.y - oAstar.blockSize*k, oSolid)){
                                        oAstar.jumpOffset = oAstar.blockSize/2; 
                                    }
                                }
                            }
                        }
                        
                        /* Actor can jump when they reach/surpass jumpOffset OR if a solid object 
                        stops them from reaching the jumpOffset point   */
                        if (A.x * sign(A.hspd) >= (startNode.x * sign(A.hspd)) + jumpOffset ||
                        place_meeting(A.x + sign(A.hspd), A.y, oSolid) ||
                        place_meeting(A.x + dir, A.y, oSolid)){
                            
                            // Jump with Actor only if they are touching a ground surface
                            with (A){
                                if (place_meeting(x, y + 1, oSolid)){
                                    vspd = -jspd;  
                                }
                            } 
                        }
                    }
                }
                    
                    /*
                        // Attempt at Smoothing Jump Arcs *
                    // Ease Out of the startNode for two blocks
                    if (abs(A.x - (startNode.x)) <= blockSize * 2 && abs(A.x - (startNode.x)) > 0)
                        A.hspd = A.spd * ( clamp(abs(A.x - nextNode.x),0, blockSize *2)/2  / blockSize ) * dir;
                    // Ease In when two blocks near the nextNode
                    else if (abs(A.x - (nextNode.x)) <= blockSize * 2 && abs(A.x - (nextNode.x)) > 0)
                        A.hspd = A.spd * (abs(A.x - nextNode.x) / blockSize) * dir;
                    // Stop hspd when above next nextNode
                    else if (abs(A.x - (nextNode.x)) == 0)
                        A.hspd = 0;
                    else
                        A.hspd += A.spd * dir;
                    */
                    /*
                        // Jump straight up and wait until at top of arc to move horizontally
                    if (A.vspd >= -A.jspd/2)
                        A.hspd = A.spd * dir;
                    else
                        A.hspd = 0;
                    */   
                
                else if(edge_type == 'EdgeType.StepUp'){
                    with (A){
                        var nextNode = oAstar.path[array_length_1d(oAstar.path)-2];
                        var d = sign(nextNode.x - x);
                        
                        // Actor moves horizontally until they hit the wall
                        if (!place_meeting(x + d*3, y, oSolid))
                            hspd = spd * d; 
                        // if Actor has not yet fully climbed up, keep climbing
                        else{
                            //if (y + height/2 > nextNode.y + oAstar.blockSize/2){
                                vspd = -jspd/5;
                            //}
                        }
                    }
                }
                /*   
                else if(edge_type == 'EdgeType.JumpDownOneWay'){
                    
                }*/  
                
            }
        }
    }
}
    
// if path is 2 or less nodes
if (array_length_1d(path) <= 2){ 
    
    // path only has startNode and endNode
    if (array_length_1d(path) == 2){
        for(var n=0; n< array_length_2d(startNode.edges,0);n++){
            var edge_id = startNode.edges[0,n];
            var edge_type = startNode.edges[1,n];
            var nextNode = path[array_length_1d(path)-2];
            if (edge_id == nextNode){
                // enables Actor to have minimum space needed to step down off current block 
                if (edge_type == 'EdgeType.RunOff' || edge_type == 'EdgeType.StepDown'){
                    var stepDir = sign(endNode.x - startNode.x);
                    var ndOffset = 0;
                    
                    /* tempEndNodeOffset :average + smaller Actors that can reposition once they step down
                    endNodeOffset :bigger Actors that cannot reposition due to size */
                    if(A.width <= blockSize)
                        ndOffset = tempEndNodeOffset;
                    else
                        ndOffset = endNodeOffset;
                        
                    ndOffset = (A.width/2 *stepDir) + (blockSize/2 * stepDir*-1)
                    
                    // recalculate pathEndX using newly acquired endNodeOffset
                    if (instance_exists(endNode)){
                        //endNodeOffset = tempEndNodeOffset;
                        pathEndX = endNode.x + ndOffset;
                    }
                }
            }
        }
    }
    
    // Set pathEndX for last movements
    if (array_length_1d(path) < 2 && instance_exists(endNode)){
        if (place_meeting(A.x, A.y + 1, oSolid)){
            pathEndX = endNode.x + endNodeOffset;
        }
    }
    
    // Use pathEndX to move to the precise pixel destination of path
    var d = sign(pathEndX - A.x);
    var endMarginOfError = 1;
    
    if ((pathEndX - A.x) * d > endMarginOfError ){
        if ((pathEndX - A.x) * d >= A.spd){
            A.hspd = A.spd * d;
        }else{
            A.hspd = 0;
            while ((pathEndX - A.x) * d > endMarginOfError){
                A.x += d;
            }
        }
    }else{
        // destroy path & stop Actor's movement
        A.hspd = 0;
        path = 0;
    }
}




