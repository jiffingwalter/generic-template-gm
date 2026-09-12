/// @description 
draw_self();

var activeDrawEventsLength = array_length(activeDrawEvents);
if (activeDrawEventsLength > 0){
    for (var i = 0; i < activeDrawEventsLength; i++){
        var drawEvent = activeDrawEvents[i];
        if (is_callable(drawEvent.callback)) drawEvent.callback();
    }
}
// 
if (!is_undefined(activeShaderEvent)){
    shader_set(activeShaderEvent.shader.get());
    for (var i = 0; i < activeShaderEvent.uniformCount; i++){
        var uniformName = activeShaderEvent.uniformInputs[i].name;
        // v make this less dirty looking and better support arrays v
        var uniformInput = (is_callable(activeShaderEvent.uniformInputs[i].input) ? activeShaderEvent.uniformInputs[i].input() : activeShaderEvent.uniformInputs[i].input);
        shader_set_uniform_f(activeShaderEvent.shader.uniforms[$ uniformName], uniformInput);
    }
    draw_self();
    shader_reset();
}