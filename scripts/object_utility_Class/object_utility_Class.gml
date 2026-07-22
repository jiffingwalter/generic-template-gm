/// @description A utility class for in-place operations on a GameMaker object, such as setting object types, component management
/// @param {Asset.GMObject} GMObject The object which operations are performed on
function ObjectUtility(GMObject) constructor{
    owner = GMObject;
    
    ///@description Set the type on an object and validate it
    ///@param {String} newType: Type of object
    ///@returns {Bool}: Success
    static setType = function(newType){
        if (!array_contains(global.PROJECT.OBJECT_TYPES,newType)){
            consoleWarn($"WARNING: tried to set an object to unknown type ({type})");
            return false;
        } else {
            self.owner.type = newType;
            return true;
        }
    }
    
    ///@description Add a new component to an object and validate
    ///@param {Asset.ObjectComponent} newComponent: New initialized component function
    ///@returns {Asset.GMObject} updated GameMaker object for method chaining
    static addComponent = function(newComponent){
        var newComponentName = newComponent.componentName;
        if (!is_undefined(newComponentName) && is_undefined(self.owner.components[$ newComponentName])){
            self.owner.components[$ newComponentName] = newComponent;
            array_push(self.owner.componentNames,newComponentName);
        } else {
            consoleWarn($"tried to add duplicate component in GMObject ({newComponentName})");
        }
        return self.owner;
    }
    
    ///@description Add a new draw event to the draw event array.
    ///@param {Asset.ObjectDrawEvent} drawEventIn: The draw event to be added
    ///@returns {Real}: Returns the new length of the array
    static addDrawEvent = function (callbackIn, durationIn = undefined, labelIn = ""){
        var newDrawEvent = new ObjectDrawEvent(callbackIn, durationIn, labelIn)
        array_push(self.owner.activeDrawEvents, newDrawEvent);
        return array_length(self.owner.activeDrawEvents);
    }
    
    ///@description Looks up any draw events on the owning object of the given label and queues it for clean up on the next tick (set duration to 0)
    ///@param {String} drawEventLabel: The label of the draw event(s) to queue for removal
    static removeDrawEventsByLabel = function (drawEventLabel){
        var activeDrawEventsLength = array_length(self.owner.activeDrawEvents)
        for (var i = 0; i < activeDrawEventsLength; i++){
            var drawEvent = self.owner.activeDrawEvents[i];
            if (drawEvent.label == drawEventLabel){
                drawEvent.duration = 0;
            }
        }
    }
}