/// @description 
/* COMPONENTS */
var componentNamesLength = array_length(self.componentNames);
if (componentNamesLength > 0){
    for (var i = 0; i < componentNamesLength; i++){
        self.components[$ self.componentNames[i]].update();
    }
}

/* DRAW EVENTS */
// read through draw event array, decrement definite draw events, then clean up ones that have expired
var activeDrawEventsLength = array_length(self.activeDrawEvents);
if (activeDrawEventsLength > 0){
    for (var i = 0; i < activeDrawEventsLength; i++){
        var drawEvent = self.activeDrawEvents[i];
        if (!is_undefined(drawEvent.durationRemaining) && drawEvent.durationRemaining > 0){
            drawEvent.durationRemaining--;
        }
    }
    // step backward through event array for completed draw events and remove them
    for (var i = activeDrawEventsLength - 1; i >= 0; i--){
        var drawEvent = self.activeDrawEvents[i];
        if (!is_undefined(drawEvent.durationRemaining) && drawEvent.durationRemaining <= 0){
            array_delete(self.activeDrawEvents, i, 1);
        }
    }
}