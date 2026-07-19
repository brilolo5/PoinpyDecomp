//
// Simple passthrough vertex shader
//
attribute vec4 in_Position;
    attribute vec4 in_Colour;
    attribute float in_Normal;
    varying vec4 v_vColour;
    const float speed = 0.5;   //speed of star
    const float stretch = 8.0;  //length of star
    uniform float time;
    void main() {
        gl_Position = vec4( in_Position.xy, 0.0, mod( in_Position.z - time * speed, in_Colour.a) - stretch * in_Position.a );
        float brightness = min(2.0,in_Normal / (gl_Position.w*gl_Position.w));  //fade brightness with distance (cap max brightness as well)
        v_vColour = vec4( in_Colour.rgb * brightness, 1.0);
    }