/// @description 
draw_self();

var activeDrawEventsLength = array_length(self.activeDrawEvents);
if (activeDrawEventsLength > 0){
    for (var i = 0; i < activeDrawEventsLength; i++){
        var drawEvent = self.activeDrawEvents[i];
        if (is_callable(drawEvent.callback)) drawEvent.callback();
    }
}
// 
if (!is_undefined(self.activeShaderEvent)){
    shader_set(self.activeShaderEvent.shader);
    for (var i = 0; i < self.activeShaderEvent.uniformCount; i++){
        var uniformName = self.activeShaderEvent.uniformInputs[i].name;
        var uniformInput = (is_callable(self.activeShaderEvent.uniformInputs[i].input) ? self.activeShaderEvent.uniformInputs[i].input() : self.activeShaderEvent.uniformInputs[i].input);
        shader_set_uniform_f(self.activeShaderEvent.shader.uniforms[$ uniformName], uniformInput);
    }
    draw_self();
    shader_reset();
}