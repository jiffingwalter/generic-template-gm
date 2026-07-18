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
]