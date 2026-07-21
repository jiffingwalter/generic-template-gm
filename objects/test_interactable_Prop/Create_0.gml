event_inherited();

/// Initialize components
self.util.addComponent(new InteractableComponent(self, 32, 0, 0, [player_temp_object]));

self.components.interactable.interactions = [
    new InteractionEvent("1", function(){
        self.util.addDrawEvent(function(){
            draw_set_colour(c_white);
            draw_set_halign(fa_center);
            draw_text(x, y - (self.sprite_height + 10), $"SIGN WAS PRESSED ({self.components.interactable.timesTriggered})");
        }, 50);
        self.components.interactable.nextInteraction();
    }),
    new InteractionEvent("2", function(){
        consoleDebug($"SIGN WAS PRESSED AGAIN ({self.components.interactable.timesTriggered})");
        self.util.addDrawEvent(function(){
            draw_set_colour(c_white);
            draw_set_halign(fa_center);
            draw_text(x, y - (self.sprite_height + 10), $"SIGN WAS PRESSED AGAIN ({self.components.interactable.timesTriggered})");
        }, 50);
    })
];

self.util.addDrawEvent(new ObjectDrawEvent(function(){
    draw_set_alpha(0.25);
    draw_circle_colour(self.x + self.components.interactable.zoneOffsetX, 
        self.y + self.components.interactable.zoneOffsetY, 
        self.components.interactable.distance, c_white, c_white, false);
    draw_set_alpha(1);
}));