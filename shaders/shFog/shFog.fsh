varying vec2 v_vPosition;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;
uniform vec4 u_vFog;
uniform vec4 u_vClipWindow;
void main()
{
    vec4 sample = texture2D(gm_BaseTexture, v_vTexcoord);
    sample = vec4(mix(sample.rgb, u_vFog.rgb, u_vFog.a), sample.a);
    
    gl_FragColor = v_vColour*sample;
    
    if ((v_vPosition.x < u_vClipWindow.x) || (v_vPosition.y < u_vClipWindow.y) || (v_vPosition.x > u_vClipWindow.z) || (v_vPosition.y > u_vClipWindow.w))
    {
        gl_FragColor.a = 0.0;
    }
}