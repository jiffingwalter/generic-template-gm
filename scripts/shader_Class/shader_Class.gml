/// @description Wrapper class for shaders. Contains methods for creating the shader and holds its expected uniform(s)
/// @param {Asset.Shader} shaderIn: Shader reference to wrap around
/// @param {Array<String>} uniformsArray: Uniform string names to initialize, if any
function Shader(shaderIn,uniformNamesIn = undefined) constructor {
    shader = shaderIn;
    uniformNames = uniformNamesIn;
    uniforms = {};
    
    function _init(){
        var uniformsArrayLength = array_length(uniformNames);
        if (uniformsArrayLength > 0){
            for (var i = 0; i < uniformsArrayLength; i++){
                var newUniformName = uniformNames[i];
                uniforms[$ newUniformName] = shader_get_uniform(shader, newUniformName);
            }
        }
    } _init();
    
    function get(){
        return shader;
    }
}