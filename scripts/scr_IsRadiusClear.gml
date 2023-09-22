///scr_IsRadiusClear(x, y, width, height);
var b = oAstar.blockSize;

var xx = argument0 div b *b;
var yy = argument1 div b *b;
var xR = argument2 /b -1;;
var yR = argument3 /b -1;;
var isRadiusClear = 1;

var A = oAstar.curActor;

if (instance_exists(A)){
// check nodes in a square. 
//Add funtionality for circle? (cutting outer corner edges) Maybe later..idk.. if I need it
    for (var i=-xR; i <= xR; i++){    // -1:left  0:middle    1:right
        for (var j=-yR; j <= yR; j++){
            // there is a solid 
            if (instance_position( (xx+b/2) + (i *b), (yy+b/2) + (j *b), oSolid)){
                isRadiusClear = 0;
                return isRadiusClear;
            }
            
        }
    }
}

return isRadiusClear;

/*
for (var i=-xR; i <= xR; i++){    // -1:left  0:middle    1:right
    for (var j=-yR; j <= yR; j++){
        draw_circle((x+16) div oAstar.blockSize*oAstar.blockSize+ (i *oAstar.blockSize), 
            (y+16) div oAstar.blockSize*oAstar.blockSize + (j *oAstar.blockSize), 
            3, 1)
    }
}
*/


