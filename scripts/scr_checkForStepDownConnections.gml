///scr_checkForStepDownConnections(node id, direction in terms of blockSize);

var node = argument0;
var dir = argument1;
var targetNode = noone;
var h = 0;

var xx = node.x + dir;
var yy = node.y// + blockSize;

if (node.type == NodeType.Walkway){
    return 1;
}

// if we go out of bounds / off the screen
if (xx < 0 || xx > room_width || yy < 0 || yy > room_height)
    return 0;
    
    
// keep looking for a block below until found or until maxFallHeight is reached
while (h <= curActor.maxFallHeight && !instance_position(xx,yy + (oAstar.blockSize * h),oSolid)){
    // check below to see if we have a tile to land on
    if (xx div blockSize < fieldWidth && (yy + (oAstar.blockSize * h)) div blockSize < fieldHeight){
    
        
    
        targetNode = instance_position(xx,yy + (oAstar.blockSize * h),oNode);
        // check if target Node already in edges array
        
        for (var n=0; n<array_length_2d(node.edges,0); n++){
            if (targetNode == node.edges[0,n])
                targetNode = noone;
        }
        if (targetNode != noone && targetNode !=node.id){
            if (array_length_2d(node.edges,0) == 1 && node.edges[0,0] == noone){
                node.edges[0,0] = targetNode;
                node.edges[1,0] = 'EdgeType.StepDown';
            }  
            else{   // edges are already placed in the edges array
                node.edges[0, array_length_2d(node.edges,0)] = targetNode;
                node.edges[1, array_length_2d(node.edges,0)-1] = 'EdgeType.StepDown';
            }
        }
    
       
    } 
    h++;
}

return 5;
