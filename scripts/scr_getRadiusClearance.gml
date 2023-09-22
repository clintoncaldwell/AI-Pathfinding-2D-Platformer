///scr_getRadiusClearance(x, y, x_radius, y_radius);
var b = oAstar.blockSize;

var xx = argument0 div b *b;
var yy = argument1 div b *b;
var xR = argument2;
var yR = argument3;
var isRadiusClear = 1;



// check nodes in a square. 
//Add funtionality for circle? (cutting outer corner edges) Maybe later..idk.. if I need it
for (var i=-xR; i <= xR; i++){    // -1:left  0:middle    1:right
    for (var j=-yR; j <= yR; j++){
        // there is a solid 
        if (instance_position(xx + (i *b), yy + (j *b), oSolid)){
            isRadiusClear = 0;
            return isRadiusClear;
        }
        
    }
}


return isRadiusClear;



