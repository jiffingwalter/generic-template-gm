/// @description A utility class for in-place operations on a GameMaker object, such as setting object types, component management
/// @param {Asset.GMObject} GMObject The object which operations are performed on
function ObjectUtility(GMObject) constructor{
    owner = GMObject;
    
    ///@description Set the type on an object and validate it
    ///@param {String} newType: Type of object
    ///@returns {Bool}: Success
    static setType = function(newType){
        if (!array_contains(global.PROJECT.OBJECT_TYPES,newType)){
            consoleWarn($"WARNING: tried to set an object to unknown type ({newType})");
            return false;
        } else {
            self.owner.type = newType;
            return true;
        }
    }
    
    /** COMPONENT FUNCTIONS **/
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
    
    /** DRAW EVENT FUNCTIONS **/
    ///@description Add a new draw event to the draw event array.
    /// @param {Function} callbackIn: The logic to run every frame the draw event while it exists
    /// @param {Real} durationIn: The amount of frames the draw event lasts for. Indefinite if none provided
    /// @param {String} label: A unique identifier to access the draw event by for manual removal
    ///@returns {Real}: Returns the new length of the array
    static addDrawEvent = function (callbackIn, durationIn = undefined, labelIn = ""){
        var newDrawEvent = new ObjectDrawEvent(callbackIn, durationIn, labelIn);
        array_push(self.owner.activeDrawEvents, newDrawEvent);
        return array_length(self.owner.activeDrawEvents);
    }
    
    ///@description Looks up any draw events on the owning object of the given label and queues it for clean up on the next tick (sets duration to 0)
    ///@param {String} drawEventLabel: The label of the draw event(s) to queue for removal
    static removeDrawEvents = function (drawEventLabel){
        parseDrawEventsByLabel(drawEventLabel, function(drawEvent){
            drawEvent.durationRemaining = 0;
        });
    }
    
    ///@description Looks up any draw events on the owning object of the given label and replaces the callback function(s)
    ///@param {String} drawEventLabel: The label of the draw event(s) to replace the callback
    ///@param {Function} newCallback: The new callback to replace the old one
    static updateDrawEventCallback = function (drawEventLabel, newCallback){
        parseDrawEventsByLabel(drawEventLabel, function(drawEvent){
            drawEvent.callback = newCallback;
        });
    }
    
    ///@description Parses through owning object's draw event list and runs the given callback on any matching labels
    ///@param {String} drawEventLabel: The label of the draw event(s)
    ///@param {Function} callback: The logic to run on the draw event. Provides the found draw event if any
    ///@returns {Array<Asset.ObjectDrawEvent>} Array of found draw events that were acted upon
    static parseDrawEventsByLabel = function (drawEventLabel, callback){
        var activeDrawEventsLength = array_length(self.owner.activeDrawEvents);
        var foundDrawEvents = [];
        for (var i = 0; i < activeDrawEventsLength; i++){
            var drawEvent = self.owner.activeDrawEvents[i];
            if (drawEvent.label == drawEventLabel){
                callback(drawEvent);
                array_push(foundDrawEvents, drawEvent);
            }
        }
        return foundDrawEvents;
    }
    
    ///@description Apply a shader to the object
    ///@param {Asset.Shader} shader: The shader class to apply
    ///@param {Array<Struct>} uniformInputs: Optional; An array of any uniform inputs of the format: {uniformName, uniformInput}. Uniform input can be a callback for logic 
    ///@return {Asset.ObjectShaderEvent} The newly assigned shader event
    static applyShader = function (shader, uniformInput = undefined){
        var newShaderEvent = new ObjectShaderEvent(shader, uniformInput);
        self.owner.activeShaderEvent = newShaderEvent;
        return newShaderEvent;
    }
    
    ///@description Clear the object's current shader event
    static clearActiveShader = function(){
        self.owner.activeShaderEvent = undefined;
    }
}