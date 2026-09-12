event_inherited();

/// Initialize components
util.addComponent(new InteractableComponent(self, 32, 0, 0, [object_Actor]));


//util.addDrawEvent(function(){
//    draw_set_alpha(0.25);
//    draw_circle_colour(x + components.interactable.zoneOffsetX, 
//    y + components.interactable.zoneOffsetY, 
//    components.interactable.distance, c_white, c_white, false);
//    draw_set_alpha(1);
//}, undefined, "debug: interaction zone");