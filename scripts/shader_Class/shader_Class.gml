/// @description Wrapper class for shaders. Contains methods for creating the shader and holds its expected uniform(s)
/// @param {Asset.Shader} shaderIn: Shader reference to wrap around
/// @param {Array<String>} uniformsArray: Uniform string names to initialize
function Shader(shaderIn,uniformNamesIn){
    shader = shaderIn;
    uniformNames = uniformNamesIn;
    uniforms = {};
    
    for (var i = 0; i = array_length(uniformNames); i++){
        var newUniformName = uniformNames[i];
        uniforms[$ newUniformName] = shader_get_uniform(self.shader, newUniformName);
    }
}