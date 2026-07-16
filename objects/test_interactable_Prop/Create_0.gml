event_inherited();

/// Initialize components
self.data.addComponent(new InteractableObjComponent(self));


self.data.components.interactable.interactions = [
    new InteractionEvent("1", function(){
        consoleDebug($"SIGN WAS PRESSED ({self.data.components.interactable.timesTriggered})");
        self.data.components.interactable.nextInteraction();
    }),
    new InteractionEvent("2", function(){
        consoleDebug($"SIGN WAS PRESSED AGAIN ({self.data.components.interactable.timesTriggered})");
        
    }) 
]