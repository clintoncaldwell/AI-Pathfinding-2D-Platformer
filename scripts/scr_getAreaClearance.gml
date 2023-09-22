///scr_getClearanceForTile(x, y);
var xx = argument0 
var yy = argument1

var c = 0;  // number of blocks
//var z = 0;  

while (c < oAstar.fieldHeight && //z == 0 &&
    !position_meeting(xx, yy - (c * oAstar.blockSize), oSolid) &&
    (yy div oAstar.blockSize) - c >= 0){
        c++;
}




//z = 1;
/*
for (clearance = 1; clearance < oAstar.fieldHeight; clearance++){
    if (place_meeting(x,y - clearance * oAstar.blockSize, oSolid) ||
        y div oAstar.blockSize - (clearance) < 0)
        break;
    //clearance = clearance * oAstar.blockSize;
}
*/
//c *= oAstar.blockSize;
return c * oAstar.blockSize;
