event_inherited();

/// Initialize components
self.util.addComponent(new InteractableComponent(self, 32, 0, 0, [object_Actor]));


//self.util.addDrawEvent(function(){
//    draw_set_alpha(0.25);
//    draw_circle_colour(self.x + self.components.interactable.zoneOffsetX, 
//    self.y + self.components.interactable.zoneOffsetY, 
//    self.components.interactable.distance, c_white, c_white, false);
//    draw_set_alpha(1);
//}, undefined, "debug: interaction zone");