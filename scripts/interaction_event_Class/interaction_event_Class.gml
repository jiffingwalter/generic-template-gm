/// @description Defines an interaction for the Interactable component
/// @param {String} nameIn: Name of the interaction for access/reference
/// @param {Function} callbackIn: Optional, logic to run when the interaction is triggered
function InteractionEvent(nameIn, callbackIn = undefined) constructor{
    name = nameIn;
    callback = callbackIn;
    triggered = false; // was this interaction triggered at least once?
    triggerCount = 0; // how many times has this interaction been triggered?
    
    function trigger(){
        triggered = true;
        triggerCount++;
        if (is_callable(callback()))
            return callback();
    }
}