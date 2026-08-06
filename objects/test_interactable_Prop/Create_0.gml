event_inherited();

/// Initialize components
self.util.addComponent(new InteractableComponent(self, 32, 0, 0, [player_temp_Object]));
self.components.interactable.onEnterZone = function(){
    self.util.addDrawEvent(function(){
        // TODO: make class out of shader logic & reference so it can be reused easier
        shader_set(glow_pulse_Shader);
        shader_set_uniform_f(shader_get_uniform(glow_pulse_Shader, "brightness"), 0.25 + sin(current_time / 300) * 0.25);
        draw_self();
        shader_reset();
    }, undefined, "shader: player nearby glow");
}
self.components.interactable.onExitZone = function(){
    self.util.removeDrawEvents("shader: player nearby glow");
}

//self.util.addDrawEvent(function(){
//    draw_set_alpha(0.25);
//    draw_circle_colour(self.x + self.components.interactable.zoneOffsetX, 
//    self.y + self.components.interactable.zoneOffsetY, 
//    self.components.interactable.distance, c_white, c_white, false);
//    draw_set_alpha(1);
//}, undefined, "debug: interaction zone");