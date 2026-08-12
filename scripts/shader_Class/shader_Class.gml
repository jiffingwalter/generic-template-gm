/// @description Wrapper class for shaders. Contains methods for creating the shader and holds its expected uniform(s)
/// @param {Asset.Shader} shaderIn: Shader reference to wrap around
/// @param {Array<String>} uniformsArray: Uniform string names to initialize, if any
function Shader(shaderIn,uniformNamesIn = undefined){
    shader = shaderIn;
    uniformNames = uniformNamesIn;
    uniforms = {};
    
    var uniformsArrayLength = array_length(uniformNames);
    if (uniformsArrayLength > 0){
        for (var i = 0; i = uniformsArrayLength; i++){
            var newUniformName = uniformNames[i];
            uniforms[$ newUniformName] = shader_get_uniform(self.shader, newUniformName);
        }
    }
}