///SearchForLightId();


var lights = oLight.NMlights;
var n = oLight.numLightProperties;


if (lightIdFound = 0){
    for(var i=0; i<oLight.maxLights; i++){
        
        if (lights[i*n] == 0){
            light_id = i;
            lightIdFound = 1;
            break;
        }
        
    }
}


return light_id;
