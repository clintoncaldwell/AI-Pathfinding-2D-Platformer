///NM_start(width,height)
//globalvar NMlights,NMcolor,NMamb,NMdif,NMnorm,NMspec,uspec,unorm,uamb,ulights,ucolor,uangle;

maxLights = 8;
// WHEN CHANGING PROPERTIES, CHANGE IT ALSO IN SHDR_NORMAL AT THE TOP
numLightProperties = 11;   // number of properties each light has (radius, xpos, yscale, etc)
NMlights[maxLights*numLightProperties] = 0;

for(var m=0;m<maxLights*numLightProperties;m++){
    NMlights[m] = 0;
}

NMamb = c_black;

NMdif = surface_create(argument0,argument1);
NMnorm = surface_create(argument0,argument1);
NMspec = surface_create(argument0,argument1);

uspec = shader_get_sampler_index(shdr_normal,"spec");
unorm = shader_get_sampler_index(shdr_normal,"norm");
uamb = shader_get_uniform(shdr_normal,"ambiance");

ulights = shader_get_uniform(shdr_normal,"PointLights");
ucolor = shader_get_uniform(shdr_normal,"lcolor");
uangle = shader_get_uniform(shdr_rotate,"angle");
// ------------------
//ulight = shader_get_uniform(shdr_normal,"light");

// If the max number changes here, change it in 
// the shdr_normal shader too under the variable LN.



