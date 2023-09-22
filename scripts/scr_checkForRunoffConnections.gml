///scr_checkForRunoffConnections(node id, direction in terms of blockSize);
var node = argument0;
var dir = argument1;
var targetNode = noone;
var height = 0;
var h = 0;

var xx = node.x + dir;
var yy = node.y;

if (node.type == NodeType.Walkway){
    return 1;
}

    velocityX = curActor.spd / blockSize
    velocityY = 0;
    if (array_length_2d(dataBinR,1) <= curActor.maxFallHeight)
        scr_simulate(dataBinR);


for(var p=0; p < array_length_2d(dataBinR,1); p++){
    targetNode = noone;
    h = 0
    
    xx += dataBinR[0,p] * sign(dir);
    yy += dataBinR[1,p];
    
    if (dataBinR[1,p] > 0)
        height++;
    else if (dataBinR[1,p] < 0 && dataBinR[1,p] != noone)
        height--; 


    // if we go out of bounds / off the screen
    if (xx < 0 || xx > room_width || yy < 0 || yy > room_height)
        return 1;
    /*
    else{
    if (!instance_position(xx+16,yy+16,oMarker))
        instance_create(xx,yy,oMarker);
    }
    */
    
    
    
    // see if we hit a wall or if we dont have clearance
    if (instance_position(xx,yy,oSolid) || scr_getClearanceForTile(xx,yy) < agentHeight){
        return 1;
    }
    // check if actor can actually travel through
    if (scr_IsRadiusClear(xx, yy, curActor.width, curActor.height))
        return 1;
        
    // check below to see if we have a tile to land on
    if (xx div blockSize < fieldWidth && yy div blockSize < fieldHeight){
        if (instance_position(xx,yy+blockSize,oSolid)){
            targetNode = instance_position(xx,yy,oNode);
            // check if target Node already in edges array
            // exclude runoff connection for nodes 2 blocks away horizontally 
            
                for (var n=0; n<array_length_2d(node.edges,0); n++){
                    if (targetNode == node.edges[0,n])
                    // stop runoff from passing through other runoff conections on a stairway
                        targetNode = noone;
                    
                    
                }
                if (targetNode != noone && targetNode !=node.id && targetNode.y != node.y){
                    if (array_length_2d(node.edges,0) == 1 && node.edges[0,0] == noone){
                        node.edges[0,0] = targetNode;
                        node.edges[1,0] = 'EdgeType.RunOff';
                    }  
                    else{   // edges are already placed in the edges array
                        node.edges[0, array_length_2d(node.edges,0)] = targetNode;
                        node.edges[1, array_length_2d(node.edges,0)-1] = 'EdgeType.RunOff';
                    }
                
                
            }
        }
    }
    // No longer needed to check first space. First space is taken care of by scr_checkForStepDownConnections
     /* checks first block that connection skips - at beginning of code where xx = node.x + dir,
        it moves horizontally one space and then code at beginning of for loop skips another block 
        before it gets the chance. SO this makes up for it*/
    /*
    if (p== 0){
        var xx0 = xx - (dataBinR[0,0] * sign(dir));
        var yy0 = yy - dataBinR[1,0];
        
        while (height + h <= curActor.maxFallHeight && !instance_position(xx0,yy0 + (oAstar.blockSize * h),oSolid)){
                
            targetNode = instance_position(xx0,yy0 + (oAstar.blockSize * h),oNode);
            
            // check if targetNode already in edges array
            for (var k=0; k<array_length_2d(node.edges,0); k++){
                if (targetNode == node.edges[0,k])
                    targetNode = noone;
                
                if (instance_exists(node.edges[0,k]) && instance_exists(targetNode)){
                    if (targetNode.x == node.edges[0,k].x + (dir) && targetNode.y == node.edges[0,k].y + blockSize)
                        targetNode = noone;
                }
            }
            if (targetNode !=noone && targetNode !=node.id){
                // adding node to edges array
                if (array_length_2d(node.edges,0) == 1 && node.edges[0,0] == noone){
                    node.edges[0,0] = targetNode;
                    node.edges[1,0] = 'EdgeType.RunOff';
                }
                    
                else{// edges are already placed in the edges array
                    node.edges[0, array_length_2d(node.edges,0)] = targetNode;
                    node.edges[1, array_length_2d(node.edges,0)-1] = 'EdgeType.RunOff';
                }
            }
            h++;
        }
    }
    */
    // we did not land yet based on our fall trajectory. If we have ground below we can
    // still fall to it so check for ground below - if block in the way, stop the loop
    h = 0;
 
    while (height + h <= curActor.maxFallHeight && !instance_position(xx,yy + (oAstar.blockSize * h),oSolid)){
            
        // check if actor can actually travel through
        //if (scr_IsRadiusClear(xx, yy + (oAstar.blockSize * h), curActor.width, curActor.height))
        //    return 1;
        
        targetNode = instance_position(xx,yy + (oAstar.blockSize * h),oNode);
        
        // check if targetNode already in edges array
        for (var o=0; o<array_length_2d(node.edges,0); o++){
            if (node.edges[0,o] == targetNode)
                targetNode = noone;
                
            if (instance_exists(node.edges[0,o]) && instance_exists(targetNode)){
                if (targetNode.x == node.edges[0,o].x + (dir) && targetNode.y == node.edges[0,o].y + blockSize)
                    targetNode = noone;
            }
        }
        if (targetNode !=noone && targetNode !=node.id && targetNode.y != node.y){
            // adding node to edges array
            if (array_length_2d(node.edges,0) == 1 && node.edges[0,0] == noone){
                node.edges[0,0] = targetNode;
                node.edges[1,0] = 'EdgeType.RunOff';
            }
                
            else{// edges are already placed in the edges array
                node.edges[0, array_length_2d(node.edges,0)] = targetNode;
                node.edges[1, array_length_2d(node.edges,0)-1] = 'EdgeType.RunOff';
            }
        }
        h++;
    }
    
   
}
// check if staircase - I want actor to stop at each step
// go through every node edge
for (var c=0; c<array_length_2d(node.edges,0); c++){
    // check relationship of this node edge to every other edge
    if (instance_exists(node.edges[0,c]) && instance_exists(targetNode)){
        for (var d=0; d<array_length_2d(node.edges,0); d++){
        // check if runoff onto a step before and if so delete self from the array
            if (node.edges[0,c].x == node.edges[0,d].x + (dir) ||
                node.edges[0,c].x == node.edges[0,d].x - (dir) && 
             node.edges[0,c].y == node.edges[0,d].y + blockSize){
                //delete and move up array items after it
                node.edges[0,c] = 0
                node.edges[1,c] = 0
            }
        }
    }
}
return 1;
