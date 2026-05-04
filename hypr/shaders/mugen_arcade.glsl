precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pix = texture2D(tex, v_texcoord);
    
    // Tint the screen blue to prove the shader compiled
    pix.b += 0.3; 
    
    gl_FragColor = pix;
}