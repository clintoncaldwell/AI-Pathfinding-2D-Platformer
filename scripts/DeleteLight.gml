///DeleteLight( light id );

var light_id = argument0;

var lights = oLight.NMlights;
var n = oLight.numLightProperties;


for(var i=0; i<n; i++){
    //lights[@ light[0] * n + i] = 0;
    lights[@ light_id * n + i] = 0;
}

