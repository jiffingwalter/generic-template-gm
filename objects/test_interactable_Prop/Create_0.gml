event_inherited();

/// Initialize components
self.util.addComponent(new InteractableComponent(self, 32, 0, 0, [player_temp_Object]));
self.components.interactable.onEnterZone = function(){
    self.util.addDrawEvent(function(){
        draw_set_alpha(0.25);
        draw_circle_colour(self.x + self.components.interactable.zoneOffsetX, 
        self.y + self.components.interactable.zoneOffsetY, 
        self.components.interactable.distance, c_white, c_white, false);
        draw_set_alpha(1);
    }, undefined, "interaction zone");
}
self.components.interactable.onExitZone = function(){
    self.util.removeDrawEvents("interaction zone");
}