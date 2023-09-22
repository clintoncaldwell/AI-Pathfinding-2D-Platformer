///NM_set_DirLight( light id, x, y, color, intensity, lightTargetX, lightTargetY);

// DIRECTIONAL LIGHT
/*
    */

var i = argument0;
var xx = argument1;    // x and y vals are where the light starts emitting. The smallest part.
var yy = argument2; 
var color = argument3;  // use - make_color_rgb( __ ,__ ,__ ) when calling script
var intensity = clamp(argument4, 0, 1.0);
var lightTargetX = argument5;
var lightTargetY = argument6;


var dir = oLight.NMlights;
var n = oLight.numLightProperties;

dir[@ i*n] = 3;

dir[@ i*n+1] = colour_get_red(color)/255;
dir[@ i*n+2] = colour_get_green(color)/255;
dir[@ i*n+3] = colour_get_blue(color)/255;

dir[@ i*n+4] = intensity;

dir[@ i*n+5] = lightTargetX - xx;
dir[@ i*n+6] = lightTargetY - yy;



