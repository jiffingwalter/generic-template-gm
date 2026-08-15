/// @description A single uniform input for a shader
/// @param {String} uniformNameIn: The name of the uniform this input applies to
/// @param {Any} uniformInputIn: The expected input value for the shader. Can be any value the shader expects. (real, function, array... etc)
function ShaderUniformInput(uniformNameIn, uniformInputIn) constructor{
    name = uniformNameIn;
    input = uniformInputIn;
}