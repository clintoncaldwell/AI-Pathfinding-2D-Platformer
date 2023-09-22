///NM_set_PointLight( light id, x, y, color, intensity, radius);

// POINT LIGHT -
/*    
    Point lights radiate light outwards in all directions 
    from a single point, much like a candle.    */

var i = argument0;
var xx = argument1;    
var yy = argument2; 
var color = argument3;  // use - make_color_rgb( __ ,__ ,__ ) when calling script
var intensity = clamp(argument4, 0, 1.0);
var radius = argument5;


var point = oLight.NMlights;
var n = oLight.numLightProperties;

//point[@ i*n] = i+1;
point[@ i*n] = 1;

point[@ i*n+1] = xx;
point[@ i*n+2] = yy;

point[@ i*n+3] = colour_get_red(color)/255;
point[@ i*n+4] = colour_get_green(color)/255;
point[@ i*n+5] = colour_get_blue(color)/255;

point[@ i*n+6] = intensity;
point[@ i*n+7] = radius;

