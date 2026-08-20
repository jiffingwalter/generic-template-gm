/// @description Component to enable interaction on an object from the player when the "INTERACT" input is pressed within its interaction zone
///              Provides methods to run functions when an object is inside the interaction zone as well
/// @param {Asset.GMObject} ownerIn: Owning object reference
/// @param {Real} distanceIn: The distance of the interaction zone that defines if the object is in interactable range. Defaults to 32.
/// @param {Real} zoneOffsetXIn: X offset of the interaction zone Defaults to 0.
/// @param {Real} zoneOffsetYIn: Y offset of the interaction zone. Defaults to 0.
/// @param {Array<Asset.GMObject>} allowableInteractorsIn: Any specific GMObjects that are allowed to interact on the owning object. Default is ANY
function InteractableComponent
    (ownerIn, distanceIn = 32, zoneOffsetXIn = 0, zoneOffsetYIn = 0, allowableInteractorsIn = [object_generic_GMObject]) : 
ObjectComponent(ownerIn, "interactable") constructor {
    distance = distanceIn; 
    zoneOffsetX = zoneOffsetXIn;
    zoneOffsetY = zoneOffsetYIn;
    allowableInteractors = allowableInteractorsIn; 
    
    isInteractable = true;
    interactions = [];
    currentIndex = 0;
    timesTriggered = 0;
    onEnterZone = function (){};
    onExitZone = function (){};
    interactorInZone = false;
    
    /// @description add an interaction event object to the interactions array, optionally at a specified index
    /// @param {Asset.InteractionEvent} interactionIn: New interaction event
    /// @param {Real} index: Optional, index to insert the interaction at
    static addInteraction = function(interactionIn, index = undefined){
        if (is_instanceof(interactionIn, InteractionEvent)) {
            var insertAt = (index)? index : array_length(self.interactions);
            array_insert(self.interactions, insertAt, interactionIn);
        } else {
            consoleWarn($"Tried to add non-interaction event to interaction array");
        }
        return self;
    }
    
    /// @description disables interaction on the object
    static disableInteraction = function(){
        self.isInteractable = false;
        self.owner.util.clearActiveShader();
    }
    
    /// @description trigger the current interaction index
    static triggerCurrentInteraction = function(){
        self.interactions[currentIndex].trigger();
        self.timesTriggered++;
        return self;
    }
    
    /// @description parse interactions array to get the index of the provided interaction by name
    /// @param {String} searchName: the name to search for
    /// @returns {Real} index of found interaction, or -1 if no interaction with input name is found
    static getInteractionIndexByName = function(searchName){
        var foundInteractionIndex
        for (var i = 0; i < array_length(self.interactions); i++){
            var interaction = self.interactions[i];
            if (searchName == interaction.name) return i;
        }
        return -1;
    }
    
    /// @description set interaction index with safeguards for OOB
    /// @param {Real} newIndex: new interaction index
    /// @returns {Real} new interaction index, or -1 if couldn't set it
    static setInteractionIndex = function(newIndex){
        if (newIndex >= 0 && newIndex < array_length(self.interactions)){
            self.currentIndex = newIndex;
            return self.currentIndex;
        } else {
            consoleWarn($"tried to set an interaction to a non-existent key [{newIndex}] of interactable array");
            return -1;
        }
    }
    
    /// @description increment interaction index with safeguards
    /// @returns {Bool} true if incremented to next interaction, false if no more interactions to increment
    static nextInteraction = function(){
        if (!is_undefined(self.interactions[self.currentIndex + 1])){
            self.currentIndex++;
            return true;
        } else return false;
    }
    
    /// @description interaction on-tick update
    static update = function(){
        // current interaction zone status...
        var interactorWasInZone = self.interactorInZone;
        self.interactorInZone = collision_circle(owner.x + self.zoneOffsetX, owner.y + self.zoneOffsetY, self.distance, self.allowableInteractors, false, true);
        
        var interactionIsValid = (
            isInteractable
            && array_length(self.interactions) > 0
            && array_length(self.allowableInteractors) > 0 
            && self.interactorInZone
        );
        
        // check for interaction from player, trigger current interaction if so...
        if (interactionIsValid && global.input.pressStart.INTERACT){ // TODO: figure out how a non-player npc would "interact" here... just on intersection??
            self.triggerCurrentInteraction();
        }
        
        // enter & exit zone functions...
        var interactorEntered = (!interactorWasInZone && self.interactorInZone);
        if (self.isInteractable && interactorEntered && is_callable(self.onEnterZone)){
            consoleDebug(self.owner);
            self.onEnterZone();
            self.owner.util.applyShader(global.shaders.glow, [new ShaderUniformInput("brightness",function(){
                return 0.25 + sin(current_time / 300) * 0.25;
            })]);
            
        }
        var interactorExited = (interactorWasInZone && !self.interactorInZone);
        if (self.isInteractable && interactorExited && is_callable(self.onExitZone)){
            self.onExitZone();
            self.owner.util.clearActiveShader();
        }
    }
}