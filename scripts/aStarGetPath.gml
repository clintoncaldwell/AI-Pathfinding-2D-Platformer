//creates a path from (startX,startY) to (endX,endY)
// param0 = startX : starting x position
// param1 = startY : starting y position
// param2 = endX : ending x position
// param3 = endY : ending y position

//NOTE : Inputs are in terms of room positions. 
//       All other positions will be in terms of grid

var startRoomX=argument0;
var startRoomY=argument1;
var endRoomX=argument2;
var endRoomY=argument3;

//_____PRE-ALGOR____
//convert vars into grid
startX=startRoomX div oAStar.blockSize;
startY=startRoomY div oAStar.blockSize;
endX=endRoomX div oAStar.blockSize;
endY=endRoomY div oAStar.blockSize;

//create datastructures
G=ds_map_create();
H=ds_map_create();
F=ds_priority_create();
P=ds_map_create();
C=ds_list_create();

//init first G value
ds_map_add(G,getKey(startX,startY),0);

//_____ALGOR____
searching=true;
found=false;
curX=startX;
curY=startY;
while(searching){
    scr_processCurrentNode();
}

var path=-1;
if(found){
    path=path_add();
    var curNode=getKey(endX,endY);
    while(curNode!=getKey(startX,startY)){
        path_add_point(path,getKeyX(curNode)*oAStar.blockSize,
            getKeyY(curNode)*oAStar.blockSize,100);
        curNode=ds_map_find_value(P,curNode);
    }
    path_add_point(path,startX*oAStar.blockSize,startY*oAStar.blockSize,100);
    path_reverse(path);
    path_set_closed(path,false);
}

//_____POST-ALGOR____
//destroy datastructures
ds_map_destroy(G);
ds_map_destroy(H);
ds_priority_destroy(F);
ds_map_destroy(P);
ds_list_destroy(C);

//return our result
return path;
