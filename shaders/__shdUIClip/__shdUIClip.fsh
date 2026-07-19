varying vec2 v_vPosition;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;
uniform vec4 u_vClipWindow;
void main()
{
    gl_FragColor = v_vColour*texture2D(gm_BaseTexture, v_vTexcoord);
    
    if ((v_vPosition.x < u_vClipWindow.x) || (v_vPosition.y < u_vClipWindow.y) || (v_vPosition.x > u_vClipWindow.z) || (v_vPosition.y > u_vClipWindow.w))
    {
        gl_FragColor.a = 0.0;
    }
}