///scr_getPath(startNode,endNode)
//creates a path from (startX,startY) to (endX,endY)
// param0 = startX : starting x position
// param1 = startY : starting y position
// param2 = endX : ending x position
// param3 = endY : ending y position

//NOTE : Inputs are in terms of room positions. 
//       All other positions will be in terms of grid
var startNode = argument0
curNode = argument0;
var endNode = argument1

var startRoomX=argument0.x;
var startRoomY=argument0.y;
var endRoomX=argument1.x;
var endRoomY=argument1.y;
path = 0;
path[0]=0;

//_____PRE-ALGOR____
//convert vars into grid
startX=startRoomX div blockSize;
startY=startRoomY div blockSize;
endX=endRoomX div blockSize;
endY=endRoomY div blockSize;

//create datastructures
G=ds_map_create();      // G score with a key mapped to position
H=ds_map_create();      // Heuristic
F=ds_priority_create(); // F score
P=ds_map_create();      // parents
C=ds_list_create();     // closed list

//init first G value
ds_map_add(G,startNode,0);

//_____ALGOR____
searching=true;
found=false;
curX=startX;
curY=startY;
curNode = startNode   // already stated at the beginning
while(searching){
    scr_processCurrentNode();
}

if(found){
    // transfer P ds list to path array for curActor to use
    path[0] = curNode;
    for(var z=1;z<=ds_map_size(P);z++){
    
        curNode = ds_map_find_value(P,curNode);
        if (is_undefined(curNode))
            continue;
        path[z] = curNode;
        
      }
   
    // Simplifies path array by deleting chains of platform nodes and 
    // instead keeps beginning and ending platform nodes in the chain.
    
    /***************
    var tempPath = 0;
    //curNode = startNode;
    //path[@ 0] = startNode;
    tempPath[0] = curNode;
        //while(curNode != endNode || z < ds_map_size(P)){
        //for(var z=ds_map_size(P);z;z--){
    for(var z=1;z<=ds_map_size(P);z++){
        curNode = ds_map_find_value(P,curNode);
        if (is_undefined(curNode))
            continue;
        tempPath[z] = curNode;
    }
    
    // Cleans Up Path for unnecessary nodes not needed - - - - - - - - - - - - - - - - 
    var v = 0;
    // we can skip the first node when cleaning the path since we are already there
    for (var i=0; i < array_length_1d(tempPath); i++){  
        // ignore any Walkways that are adjacent to other Walkways and the final Node.
        // We need the final Node just in case it happens to be a Walkway.
        if (i < array_length_1d(tempPath) - 1 && i > 0 && tempPath[i].type == NodeType.Walkway){
            if (tempPath[i].y div blockSize == tempPath[i-1].y div blockSize &&
                tempPath[i].x div blockSize + 1 == tempPath[i+1].x div blockSize ||
                tempPath[i].x div blockSize - 1 == tempPath[i+1].x div blockSize){
                // checks the array instance in the slot above it (i+1) 
                // since the path list is backwards. Endnode -> StartNode
                    continue       
            }
        }
        path[v] = tempPath[i];
        v++;
    }
    
    ****************/
    
}

//_____POST-ALGOR____
//destroy datastructures
ds_map_destroy(G);
ds_map_destroy(H);
ds_priority_destroy(F);
ds_map_destroy(P);
ds_list_destroy(C);

//return our result
return found;
