attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vPosition = (gm_Matrices[MATRIX_WORLD] * object_space_pos).xy;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~


varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;
//#pragma glsl
// If the max number changes here, change it in the NM_start script too
#define LN 8 //Number of Lights
#define N 11  // spaces for each light - 11 spaces currently


uniform sampler2D spec;//specular map
uniform sampler2D norm;//normal map

uniform float PointLights[LN*N];
uniform vec3 ambiance;//r,g,b
 
// POINT LIGHT
vec3 point(float spec,vec3 norm,vec3 dif,vec2 pos,vec4 light,vec3 col, float type)
{   
    // light.x = xpos   .y = yos    .z = intensity     .w = radius
    vec3 Nm = vec3(normalize(pos-light.xy),0.0);
    float A = max(1.0-length(vec2(pos)-light.xy)/light.w,0.0);
    return (pow(max(dot(norm,Nm),0.0)*4.0,spec*4.0)*0.25*A*dif.rgb*normalize(col)) * light.z   * float(equal(vec2(type), vec2(1.0)));// * ((-1.0 * mod(1.0, type)) +1.0);
}

// SPOT LIGHT
    // vec4 light = x, y ,intensity, radius
vec3 spot(float spec,vec3 norm,vec3 dif,vec2 pos,vec4 light,vec3 col, vec2 lightTarget,float cutoffAngle,float type)
{
    vec3 Nm = vec3(normalize(pos-light.xy),0.0);
    float A = max(1.0-length(vec2(pos)-light.xy)/light.w,0.0);
    
    vec2 toLight  = normalize(light.xy - pos);
    vec2 lightDirection = normalize(lightTarget.xy - light.xy);
    float angle = acos(dot(-toLight, lightDirection));
    
    vec3 Ang = vec3(max(vec3(0),vec3(cutoffAngle - angle)));
      return pow(max(dot(norm,Nm),0.0)*4.0,spec*4.0)*0.25*A*dif.rgb*normalize(col)   *Ang * vec3(light.z) * vec3(float(equal(vec2(type), vec2(2.0))));
      //return pow(max(dot(norm,Nm),0.3)*4.0,spec*4.0)*0.25*A*dif.rgb*normalize(col)   *Ang * vec3(light.z) * vec3(float(equal(vec2(type), vec2(2.0))));
      //return max(dot(norm,Nm),0.0)*4.0*spec*4.0*0.25*A*dif.rgb*normalize(col);
}

// DIRECTIONAL LIGHT
// light is vec2 instead of vec4 because x and y positions of the light are not needed for Dir. Light
vec3 dir(float spec,vec3 norm,vec3 dif,vec2 pos,float intensity,vec3 col, vec2 dir, float type)
{   
    vec2 Nm = (normalize(dir));
    //float A = max(1.0-length(vec2(pos)-light.xy),0.0);
    return pow(max(dot(norm*vec3(0.8),vec3(Nm,0.0)),0.0)*4.0,spec*4.0)*0.25*dif.rgb * normalize(col) * intensity * float(equal(vec2(type), vec2(3.0)));
    
    /* norm is multiplied by vec2(2.2) because I wanted to try making the subtle changees on the normal map
    more apparent. Ex: The forhead is orangeish while the arm and leg is yellow, recieving more light
    maybe leaving it how it is, is the best choice instead of chasing after sprite Illuminator's configuration. */ 
}

/*
total += area(Spec,Norm,Dif.rgb,v_vPosition,
        vec4(PointLights[i*N+1],PointLights[i*N+2],PointLights[i*N+3 ],PointLights[i*N+4]),
        vec2(PointLights[i*N+8],PointLights[i*N+9]),
        vec3(PointLights[i*N+5],PointLights[i*N+6],PointLights[i*N+7]), 
        PointLights[i*N]);
*/
// AREA LIGHT
    // Illuminates opposite side facing away from the light
vec3 areaVectorsIn(float spec,vec3 norm,vec3 dif,vec2 pos, vec4 lightPos, vec2 lightProp, vec3 col, float type)
{   
    // lightPos     .x = x Start     .y = y Start    .z = x End    .w = y End
    // lightProp    .x = lightFalloffDist   .y = intensity
    vec3 Nm = vec3(normalize((lightPos.xy+lightPos.zw)/2.0 -pos), 0.0);
    vec2 x1 = vec2 (lightPos.x - lightProp.x ,0.0);
    vec2 x2 = vec2 (lightPos.z + lightProp.x ,0.0);
    vec2 y1 = vec2 (lightPos.y - lightProp.x ,0.0);
    vec2 y2 = vec2 (lightPos.w + lightProp.x ,0.0);
    
    // Lit areas must be within the area specified
    float A = 
    float(greaterThanEqual(vec2(pos.x,0.0), x1)) * 
    float(greaterThanEqual(vec2(pos.y,0.0), y1)) * 
    float(lessThanEqual(vec2(pos.x,0.0), x2)) *
    float(lessThanEqual(vec2(pos.y,0.0), y2));
    
    // Light falloff zone: distance from area light edges to light's falloffDistance 
    float fallLeft =    max(1.0- (-pos.x + lightPos.x ) / lightProp.x, 0.0);
    float fallRight =   max(1.0- (pos.x - lightPos.z ) / lightProp.x, 0.0);
    float fallTop =     max(1.0- (-pos.y + lightPos.y ) / lightProp.x, 0.0);
    float fallBottom =  max(1.0- (pos.y - lightPos.w ) / lightProp.x, 0.0);
    
    return (pow(max(dot(norm,Nm),0.0)*4.0,spec*4.0)*0.25* A * fallLeft * fallRight * fallTop * fallBottom *dif.rgb*normalize(col)) * lightProp.y * float(equal(vec2(type), vec2(4.0)));// * ((-1.0 * mod(1.0, type)) +1.0);
}
    
    // Illuminates side facing toward the light
vec3 areaVectorsOut(float spec,vec3 norm,vec3 dif,vec2 pos, vec4 lightPos, vec2 lightProp, vec3 col, float type)
{   
    // lightPos     .x = x Start     .y = y Start    .z = x End    .w = y End
    // lightProp    .x = lightFalloffDist   .y = intensity
    vec3 Nm = vec3(normalize(pos-(lightPos.xy+lightPos.zw)/2.0),0.0);
    vec2 x1 = vec2 (lightPos.x - lightProp.x ,0.0);
    vec2 x2 = vec2 (lightPos.z + lightProp.x ,0.0);
    vec2 y1 = vec2 (lightPos.y - lightProp.x ,0.0);
    vec2 y2 = vec2 (lightPos.w + lightProp.x ,0.0);
    
    // Lit areas must be within the area specified
    float A = 
    float(greaterThanEqual(vec2(pos.x,0.0), x1)) * 
    float(greaterThanEqual(vec2(pos.y,0.0), y1)) * 
    float(lessThanEqual(vec2(pos.x,0.0), x2)) *
    float(lessThanEqual(vec2(pos.y,0.0), y2));
    
    // Light falloff zone: distance from area light edges to light's falloffDistance 
    float fallLeft =    max(1.0- (-pos.x + lightPos.x ) / lightProp.x, 0.0);
    float fallRight =   max(1.0- (pos.x - lightPos.z ) / lightProp.x, 0.0);
    float fallTop =     max(1.0- (-pos.y + lightPos.y ) / lightProp.x, 0.0);
    float fallBottom =  max(1.0- (pos.y - lightPos.w ) / lightProp.x, 0.0);
    
    return (pow((max(dot(norm,Nm),0.0)) *4.0, spec*4.0)*0.25* A * fallLeft * fallRight * fallTop * fallBottom *dif.rgb*normalize(col)) * lightProp.y * float(equal(vec2(type), vec2(4.0)));// * ((-1.0 * mod(1.0, type)) +1.0);
    
    //return (pow(max(0.5, 0.0)*4.0,spec*4.0)*0.25* A * fallLeft * fallRight * fallTop * fallBottom *dif.rgb*normalize(col)) * lightProp.y * float(equal(vec2(type), vec2(4.0)));// * ((-1.0 * mod(1.0, type)) +1.0);
    //return (pow(max(dot(norm,Nm),0.5)*4.0,spec*4.0)*0.25* A * fallLeft * fallRight * fallTop * fallBottom *dif.rgb*normalize(col)) * lightProp.y * float(equal(vec2(type), vec2(4.0)));// * ((-1.0 * mod(1.0, type)) +1.0);
    /*
        The float after dot(norm,Nm) determines the strength of the the visual light.  
    */
}


void main()
{ 
    float Spec = texture2D( spec, v_vTexcoord ).r;
    vec3 Norm = normalize(texture2D( norm, v_vTexcoord ).rgb*-2.0+1.0);
    vec4 Dif = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    int i = 0;
    vec3 total;
    
    for(i=0; i< LN; i++){
    
    //point
        total += point(Spec,Norm,Dif.rgb,v_vPosition,vec4(PointLights[i*N+1],PointLights[i*N+2],PointLights[i*N+6 ],PointLights[i*N+7]),vec3(PointLights[i*N+3],PointLights[i*N+4],PointLights[i*N+5]), PointLights[i*N]);
    //spot
        total += spot(Spec,Norm,Dif.rgb,v_vPosition,vec4(PointLights[i*N+1],PointLights[i*N+2],PointLights[i*N+6 ],PointLights[i*N+7]),vec3(PointLights[i*N+3],PointLights[i*N+4],PointLights[i*N+5]), vec2(PointLights[i*N+8], PointLights[i*N+9]),PointLights[i*N+10], PointLights[i*N]);
    //directional
        total += dir(Spec,Norm,Dif.rgb,v_vPosition,PointLights[i*N+4],vec3(PointLights[i*N+1],PointLights[i*N+2],PointLights[i*N+3]), vec2(PointLights[i*N+5],PointLights[i*N+6]), PointLights[i*N]);
    //area
    /**/
        total += areaVectorsIn(Spec,Norm,Dif.rgb,v_vPosition,
        vec4(PointLights[i*N+1],PointLights[i*N+2],PointLights[i*N+3 ],PointLights[i*N+4]),
        vec2(PointLights[i*N+8],PointLights[i*N+9]),
        vec3(PointLights[i*N+5],PointLights[i*N+6],PointLights[i*N+7]), 
         PointLights[i*N]);
     /**/
        total += areaVectorsOut(Spec,Norm,Dif.rgb,v_vPosition,
        vec4(PointLights[i*N+1],PointLights[i*N+2],PointLights[i*N+3 ],PointLights[i*N+4]),
        vec2(PointLights[i*N+8],PointLights[i*N+9]),
        vec3(PointLights[i*N+5],PointLights[i*N+6],PointLights[i*N+7]), 
        PointLights[i*N]);
      
        //vec3 sp = spot(Spec,Norm,Dif.rgb,v_vPosition,vec4(PointLights[i*N+1],PointLights[i*N+2],PointLights[i*N+6 ],PointLights[i*N+7]),vec3(PointLights[i*N+3],PointLights[i*N+4],PointLights[i*N+5]), vec2(PointLights[i*N+8], PointLights[i*N+9]),PointLights[i*N+10]);
        //    total += sp * vec3(float(equal(vec2(PointLights[i*N]), vec2(2.0))));
    }
    
    total = max(total, vec3(0.0));
     
    gl_FragColor = vec4( (Dif.rgb * ambiance + (total)* (ambiance) ) , Dif.a);   
}





/* Good for Directional Light maybe
vec3 point(float spec,vec3 norm,vec3 dif,vec2 pos,vec4 light,vec3 col)
{   
    // light.x = xpos   .y = yos    .z = intensity     .w = radius
    vec3 Nm = normalize(vec3(pos,0.0)-light.xyz);
    float A = max(length(vec2(pos)-light.xy)/light.w,0.0);
    return pow(max(dot(norm,Nm),0.0)*4.0,spec*4.0)*0.25*A*dif.rgb*normalize(col);
}
*/
