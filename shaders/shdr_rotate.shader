//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float angle;//Angle in degrees
void main()
{
    float A = radians(angle);//Angle in radians
    mat3 anglemat = mat3(cos(A),-sin(A),0.0,sin(A),cos(A),0.0,0.0,0.0,1.0);
    vec4 Col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = vec4((normalize(Col.rgb*2.0-1.0) * anglemat)*0.5+0.5 ,Col.a);
}

