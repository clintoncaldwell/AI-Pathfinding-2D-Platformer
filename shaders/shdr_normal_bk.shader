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

// If the max number changes here, change it in the NM_start script too
#define LN 10 //Number of Lights
#define N 10


uniform sampler2D spec;//specular map
uniform sampler2D norm;//normal map

uniform float PointLights[LN*N];
uniform vec3 ambiance;//r,g,b

vec3 lighting(float spec,vec3 norm,vec3 dif,vec2 pos,vec4 light,vec3 col)
{
    vec3 Nm = normalize(vec3(pos,0.0)-light.xyz);
    float A = max(1.0-length(vec2(pos)-light.xy)/light.w,0.0);
    return pow(max(dot(norm,Nm),0.0)*4.0,spec*4.0)*0.25*A*dif.rgb*normalize(col);
}


void main()
{
    float Spec = texture2D( spec, v_vTexcoord ).r;
    vec3 Norm = normalize(texture2D( norm, v_vTexcoord ).rgb*-2.0+1.0);
    vec4 Dif = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    int i = 0;
    vec3 total;
    for(i=0; i< LN; i++){
        total += lighting(Spec,Norm,Dif.rgb,v_vPosition,vec4(PointLights[i*N],PointLights[i*N+1],24.0,PointLights[i*N+8]),vec3(PointLights[i*N+2],PointLights[i*N+3],PointLights[i*N+4]));
    }
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
    gl_FragColor = vec4(min(ambiance+total,Dif.rgb),Dif.a);
}

