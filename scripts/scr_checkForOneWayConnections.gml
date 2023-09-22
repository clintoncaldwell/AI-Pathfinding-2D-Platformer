///scr_checkForJumpDownOneWayConnections(node id, direction in terms of blockSize);

/// NOT COMPLETE - NOT READY FOR IMPLEMENTATION YET BRO


var node = argument0;
var dir = argument1;
var targetNode = noone;
var height = 0;
var h = 0;

var xx = node.x;
var yy = node.y;

//var init_data = 0;


    //velocityX = curActor.spd/1.3 / blockSize
    velocityX = curActor.spd / blockSize
    velocityY = 0;
    if (array_length_2d(dataBinJ,0) <= curActor.maxFallHeight)
        scr_simulate(dataBinJ);


for(var p=0; p < array_length_2d(dataBinJ,1); p++){
        
        targetNode = noone;
        h = 0
        
        xx += dataBinJ[0,p] * sign(dir);
        yy += dataBinJ[1,p];
        
        if (dataBinJ[1,p] > 0)
            height++;
        else if (dataBinJ[1,p] < 0)
            height--; 
            
    // if we go out of bounds / off the screen
    if (xx < 0 || xx > room_width || yy < 0 || yy > room_height)
        return 0;
    /*
    else{
    if (!instance_position(xx,yy+16,oMarker))
        instance_create(xx,yy,oMarker);
    }
    */
    
    // see if we hit a wall
    if (instance_position(xx,yy,oSolid))
        return 0;
    
    // ensure we have clearance
    if (scr_getClearanceForTile(xx,yy) < agentHeight){
        // if we were moving up and hit our head fast forward jump data until it is falling down
        if (dataBinJ[1,p] <= 0){
            //fastForwardDataToFall( jumpData )
            var f = 1;
            while(dataBinJ[1,p+f] <= 0){
                f++;
            }
            continue;
        // if we got here, we hit our head moving horizontally so we are done
        }
        return 0;
    }
    
    // check below to see if we have a tile to land on
    if (xx div blockSize < fieldWidth && yy div blockSize < fieldHeight){
        if (instance_position(xx,yy+blockSize,oSolid)){
            targetNode = instance_position(xx,yy,oNode);
            // check if target Node already in edges array
            
                for (var n=0; n<array_length_2d(node.edges,0); n++){
                    if (targetNode == node.edges[0,n])
                        targetNode = noone;
                }
                if (targetNode != noone && targetNode !=node.id){
                    if (array_length_2d(node.edges,0) == 1 && node.edges[0,0] == noone){
                        node.edges[0,0] = targetNode;
                        node.edges[1,0] = 'EdgeType.Jump';
                    }  
                    else{   // edges are already placed in the edges array
                        node.edges[0, array_length_2d(node.edges,0)] = targetNode;
                        node.edges[1, array_length_2d(node.edges,0)-1] = 'EdgeType.Jump';
                    }
                }
                return 0;
            }
    }
    
    
    // we did not land yet based on our fall trajectory. If we have ground below we can
    // still fall to it so check for ground below
    h = 0
        // if block in the way, stop the loop
    while (height + h <= curActor.maxFallHeight+1 && !instance_position(xx,yy + (oAstar.blockSize * h),oSolid)){
            
        targetNode = instance_position(xx,yy + (oAstar.blockSize * h),oNode);
        
        // check if targetNode already in edges array
        for (var o=0; o<array_length_2d(node.edges,0); o++){
            if (node.edges[0,o] == targetNode)
                targetNode = noone;
        }
        if (targetNode !=noone && targetNode !=node.id){
            // adding node to edges array
            if (array_length_2d(node.edges,0) == 1 && node.edges[0,0] == noone){
                node.edges[0,0] = targetNode;
                node.edges[1,0] = 'EdgeType.Jump';
            }
                
            else{// edges are already placed in the edges array
                node.edges[0, array_length_2d(node.edges,0)] = targetNode;
                node.edges[1, array_length_2d(node.edges,0)-1] = 'EdgeType.Jump';
            }
        }
        h++;
    }
    
    //p++;
}
return 0;
