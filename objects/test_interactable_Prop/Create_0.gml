event_inherited();

/// Initialize components
self.util.addComponent(new InteractableComponent(self));

self.components.interactable.interactions = [
    new InteractionEvent("1", function(){
        consoleDebug($"SIGN WAS PRESSED ({self.components.interactable.timesTriggered})");
        self.components.interactable.nextInteraction();
    }),
    new InteractionEvent("2", function(){
        consoleDebug($"SIGN WAS PRESSED AGAIN ({self.components.interactable.timesTriggered})");
        
    })
];

self.util.addDrawEvent(new ObjectDrawEvent(function(){
    draw_set_alpha(0.25);
    draw_circle_colour(self.x + self.components.interactable.zoneOffsetX, 
        self.y + self.components.interactable.zoneOffsetY, 
        self.components.interactable.distance, c_white, c_white, false);
    draw_set_alpha(1);
}));