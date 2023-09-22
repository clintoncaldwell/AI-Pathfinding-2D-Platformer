///scr_checkForStepUpConnections(node id, direction in terms of blockSize);

var node = argument0;
var dir = argument1;
var targetNode = noone;

var xx = node.x + dir;
var yy = node.y - blockSize;


// if we go out of bounds / off the screen
if (xx < 0 || xx > room_width || yy < 0 || yy > room_height)
    return 0;
    
// If a node is 1 block up + to the left/right it can be a StepUp Connection
if (instance_position(xx,yy,oNode)){
    // ensure we have clearance
    if (scr_getClearanceForTile(node.x,node.y) >= agentHeight*2 && 
        scr_getClearanceForTile(xx,yy) >= agentHeight ){
        
    
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
                        node.edges[1,0] = 'EdgeType.StepUp';
                    }  
                    else{   // edges are already placed in the edges array
                        node.edges[0, array_length_2d(node.edges,0)] = targetNode;
                        node.edges[1, array_length_2d(node.edges,0)-1] = 'EdgeType.StepUp';
                    }
                }
            }
        }
    }
}

return 5;
