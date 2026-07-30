/// @description Component to enable interaction on an object from the player when the "INTERACT" input is pressed within its interaction zone
/// @param {Asset.GMObject} ownerIn: Owning object reference
/// @param {Real} distanceIn: The distance of the interaction zone that defines if the object is in interactable range. Defaults to 32.
/// @param {Real} zoneOffsetXIn: X offset of the interaction zone Defaults to 0.
/// @param {Real} zoneOffsetYIn: Y offset of the interaction zone. Defaults to 0.
/// @param {Array<Asset.GMObject>} allowableInteractorsIn: Any specific GMObjects that are allowed to interact on the owning object. Default is ANY
function 
InteractableComponent
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
    
    debugInteractorInZone = false;
    
    /// @description add an interaction event object to the interactions array, optionally at a specified index
    /// @param {Asset.InteractionEvent} interactionIn: New interaction event
    /// @param {Real} index: Optional, index to insert the interaction at
    function addInteraction(interactionIn, index = undefined){
        if (is_instanceof(interactionIn, InteractionEvent)) {
            var insertAt = (index)? index : array_length(self.interactions);
            array_insert(self.interactions, insertAt, interactionIn);
        } else {
            consoleWarn($"Tried to add non-interaction event to interaction array");
        }
        return self;
    }
    
    /// @description trigger the current interaction index
    function triggerCurrentInteraction(){
        self.interactions[currentIndex].trigger();
        self.timesTriggered++;
        return self;
    }
    
    /// @description parse interactions array to get the index of the provided interaction by name
    /// @param {String} searchName: the name to search for
    /// @returns {Real} index of found interaction, or -1 if no interaction with input name is found
    function getInteractionIndexByName(searchName){
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
    function setInteractionIndex(newIndex){
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
    function nextInteraction(){
        if (!is_undefined(self.interactions[self.currentIndex + 1])){
            self.currentIndex++;
            return true;
        } else return false;
    }
    
    /// @description interaction on-tick update
    function update(){
        self.interactorInZone = collision_circle(owner.x + self.zoneOffsetX, owner.y + self.zoneOffsetY, self.distance, self.allowableInteractors, false, true);
        if (
            isInteractable
            && array_length(self.interactions) > 0
            && array_length(self.allowableInteractors) > 0 
            && self.interactorInZone
            && global.input.pressStart.INTERACT // TODO: figure out how a non-player npc would "interact" here... just on intersection??
        ){
            self.triggerCurrentInteraction();
        }
    }
}