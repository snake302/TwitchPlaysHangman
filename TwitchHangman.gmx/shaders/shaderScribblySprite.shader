//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
uniform float time;
uniform float subWidth;

void main()
{
    float subWidthUV = 1.00 / subWidth;
    vec2 pos = v_vTexcoord;
    float angle = time + mod(pos.x, subWidthUV) * 1000.0 + mod(pos.y, subWidthUV) * 500.0;
    pos.x +=  sin(angle) * .00015;
    pos.y -=  cos(angle) * .00015;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, pos);   
}

