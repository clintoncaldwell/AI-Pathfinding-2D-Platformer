///NM_set_AreaLight( light id, x1, y1, x2, y2, color, falloffDistance, intensity);

// AREA LIGHT -
/*    
    area lights radiate light from a box, 
        much like a panel light in schools   */

var i = argument0;
var xx1 = argument1;    
var yy1 = argument2; 
var xx2 = argument3;
var yy2 = argument4;
var color = argument5;  // use - make_color_rgb( __ ,__ ,__ ) when calling script
var falloff = argument6;
var var_intensity = clamp(argument7, 0, 1.0);



var area = oLight.NMlights;
var n = oLight.numLightProperties;

//area[@ i*n] = i+1;
area[@ i*n] = 4;

area[@ i*n+1] = xx1;
area[@ i*n+2] = yy1;
area[@ i*n+3] = xx2;
area[@ i*n+4] = yy2;

area[@ i*n+5] = colour_get_red(color)/255;
area[@ i*n+6] = colour_get_green(color)/255;
area[@ i*n+7] = colour_get_blue(color)/255;

area[@ i*n+8] = falloff;
area[@ i*n+9] = var_intensity;


