//   @jujuadams   v7.1.2   2020-03-16
precision highp float;
#define PREMULTIPLY_ALPHA false
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vPosition; // Custom code for Poinpy
uniform vec4 u_vClipWindow; // Custom code for Poinpy
void main()
{
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
    
    if (PREMULTIPLY_ALPHA)
    {
        gl_FragColor *= v_vColour.a;
    }
    else
    {
        gl_FragColor.a *= v_vColour.a;
    }
    
    if ((v_vPosition.x < u_vClipWindow.x) || (v_vPosition.y < u_vClipWindow.y) || (v_vPosition.x > u_vClipWindow.z) || (v_vPosition.y > u_vClipWindow.w)) // Custom code for Poinpy
    { // Custom code for Poinpy
        gl_FragColor.a = 0.0; // Custom code for Poinpy
    } // Custom code for Poinpy
}