//Pass in the texture coordinates from the vertex shader.
varying vec2 v_vTexcoord;
//Pass in the vertex color/alpha from the vertex shader.
varying vec4 v_vColour;

//Handle fragments/pixels.
void main()
{
    //Set the output the vertex color multiplied by texture color of each pixel.
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}