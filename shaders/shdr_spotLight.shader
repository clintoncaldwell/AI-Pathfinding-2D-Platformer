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

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition;
//#pragma glsl
// If the max number changes here, change it in the NM_start script too
#define LN 10 //Number of Lights
#define N 11  // spaces for each light - 11 spaces currently


uniform sampler2D spec;//specular map
uniform sampler2D norm;//normal map

uniform float PointLights[LN*N];
uniform vec3 ambiance;//r,g,b


// SPOT LIGHT
    // vec4 light = x, y ,intensity, radius
vec3 spot(float spec,vec3 norm,vec3 dif,vec2 pos,vec4 light,vec3 col, vec2 lightTarget,vec2 cutoffAngle)
{
    vec3 Nm = vec3(normalize(pos-light.xy),0.0);
    float A = max(1.0-length(vec2(pos)-light.xy)/light.w,0.0);
    
    vec2 toLight  = normalize(light.xy - pos);
    vec2 lightDirection = normalize(lightTarget.xy - light.xy);
    float angle = acos(dot(-toLight, lightDirection));
    
    vec3 Ang = vec3(max(vec3(0),vec3(cutoffAngle.x - angle)));
      return pow(max(dot(norm,Nm),0.0)*4.0,spec*4.0)*0.25*A*dif.rgb*normalize(col)   *Ang * vec3(light.z)  * vec3(float(equal(vec2(cutoffAngle.y,0.0), vec2(2.0))));
      //return max(dot(norm,Nm),0.0)*4.0*spec*4.0*0.25*A*dif.rgb*normalize(col);
}



float findRightType(float type)
{
    return (mod(2.0, type));
}

void main()
{ 
    float Spec = texture2D( spec, v_vTexcoord ).r;
    vec3 Norm = normalize(texture2D( norm, v_vTexcoord ).rgb*-2.0+1.0);
    vec4 Dif = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    int i = 0;
    vec3 total;
    
    for(i=0; i< LN; i++){
        total += spot(Spec,Norm,Dif.rgb,v_vPosition,vec4(PointLights[i*N+1],PointLights[i*N+2],PointLights[i*N+6 ],PointLights[i*N+7]),vec3(PointLights[i*N+3],PointLights[i*N+4],PointLights[i*N+5]), vec2(PointLights[i*N+8], PointLights[i*N+9]), vec2(PointLights[i*N+10], PointLights[i*N]));
    
    }
    
    //total = max(total, vec3(0.0));
     
     
     gl_FragColor = vec4( (Dif.rgb * ambiance + (total)* (ambiance) ) , Dif.a);
     
     //gl_FragColor = vec4( (Dif.rgb * ambiance + total ) , Dif.a);
     
     //gl_FragColor = vec4( (Dif.rgb * ambiance + (total) * (vec3(1) - ambiance) ) , Dif.a);
    /*
    for ( int i = 0; i < g_iDirLights; i++ ) {
    // Directional light computations.
    // g_vLightVecs[i] = current directional light vector.
    }
    
    for ( int i = 0; i < g_iPointLights; i++ ) {
        // Point light computations.
        // g_vLightVecs[i+g_iDirLights] = current point light position.
    }
    
    for ( int i = 0; i < g_iPointLights; i++ ) {
        // Spot light computations.
        // g_vLightVecs[i+g_iDirLights+g_iPointLights] = current spot light position.
    }
    */
    //gl_FragColor = vec4(min(ambiance+total,Dif.rgb),Dif.a);
    //vec3 vt = ambiance+total;
    //gl_FragColor = vec4( (Dif.rgb * (ambiance+total) ) / vec3(2.0) , Dif.a);
    //gl_FragColor = vec4( (Dif.rgb * (total *vec3(0.16)+ ambiance) ) , Dif.a);
// good shit - works the best: gl_FragColor = vec4( (Dif.rgb * ambiance +(total * ambiance) ) , Dif.a);
    
    
    //gl_FragColor = vec4( (Dif.rgb * ambiance +(total * ambiance*vec3(0.2)) ) , Dif.a);  // 94% Brightness
    
    //gl_FragColor = vec4( Dif.rgb * ambiance + (total / ( ambiance*vec3(15)/(ambiance*vec3(5)) ) ), Dif.a); 
    //gl_FragColor = vec4( (Dif.rgb * ambiance +(total/vec3(2.5)) ), Dif.a); 
    //gl_FragColor = vec4( mix(Dif.rgb * ambiance, total- ambiance, 0.2 ), Dif.a); 
// very good. Almost exactly same as sprIlluminator - gl_FragColor = vec4( (Dif.rgb * ambiance +(total/vec3(4)) ) , Dif.a);
   
}


