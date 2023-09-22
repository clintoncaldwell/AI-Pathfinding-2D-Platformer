///NM_set_SpotLight( light id, x, y, color, intensity, radius, lightTargetX, lightTargetY, cutoffAngle);

// SPOTLIGHT
/*
    Spotlights radiate light restricted to a cone shape due to a 
    surface/element that restricts where the light can shine. Ex: A flashlight  */

//If the pixel is outside of the cone, then we set the color to black 

var i = argument0;
var xx = argument1;    // x and y vals are where the light starts emitting. The smallest part.
var yy = argument2; 
var color = argument3;  // use - make_color_rgb( __ ,__ ,__ ) when calling script
var intensity = clamp(argument4, 0, 1.0);
var radius = argument5;
var lightTargetX = argument6;
var lightTargetY = argument7;
var cutoff = clamp(argument8, 0, 1);


var spot = oLight.NMlights;
var n = oLight.numLightProperties;

//spot[@ i*n] = i+1;
spot[@ i*n] = 2;

spot[@ i*n+1] = xx;
spot[@ i*n+2] = yy;

spot[@ i*n+3] = colour_get_red(color)/255;
spot[@ i*n+4] = colour_get_green(color)/255;
spot[@ i*n+5] = colour_get_blue(color)/255;

spot[@ i*n+6] = intensity;
spot[@ i*n+7] = radius;


spot[@ i*n+8] = lightTargetX;
spot[@ i*n+9] = lightTargetY;
spot[@ i*n+10] = cutoff * 3.15;   // 3.15 makes a full circle



