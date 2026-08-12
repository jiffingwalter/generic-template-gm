/// @description A shader draw event that holds a shader, input data, and passes input data to a shader dynamically
/// @param {Asset.Shader} shaderIn: The shader we're attached to
/// @param {Array<Struct>} uniformInputsIn: An array of uniform inputs to inject into the shader, if any
function ObjectShaderEvent(shaderIn, uniformInputsIn = undefined) constructor {
    shader = shaderIn;
    uniformInputs = uniformInputsIn;
    uniformCount = !is_undefined(uniformInputs) ? array_length(uniformInputs) : 0;
}