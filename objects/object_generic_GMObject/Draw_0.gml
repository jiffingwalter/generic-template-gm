/// @description 
draw_self();

var activeDrawEventsLength = array_length(self.activeDrawEvents);
if (activeDrawEventsLength > 0){
    for (var i = 0; i < activeDrawEventsLength; i++){
        var drawEvent = self.activeDrawEvents[i];
        if (is_callable(drawEvent.callback)) drawEvent.callback();
    }
}
if (!is_undefined(self.activeShader)){
    // TODO: inputify this, make dynamic based on activeShader
    shader_set(glow_pulse_Shader);
    shader_set_uniform_f(shader_get_uniform(glow_pulse_Shader, "brightness"), 0.25 + sin(current_time / 300) * 0.25);
    draw_self();
    shader_reset();
}