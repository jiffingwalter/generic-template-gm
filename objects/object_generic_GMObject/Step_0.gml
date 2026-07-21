/// @description 
/* COMPONENTS */
var componentNamesLength = array_length(self.componentNames);
if (componentNamesLength > 0){
    for (var i = 0; i < componentNamesLength; i++){
        self.components[$ self.componentNames[i]].update();
    }
}

/* DRAW EVENTS */
// read through draw event array, decrement definite draw events and remove ones that have expired
var activeDrawEventsLength = array_length(self.activeDrawEvents);
if (activeDrawEventsLength > 0){
    for (var i = 0; i < activeDrawEventsLength; i++){
        var drawEvent = activeDrawEventsLength[i];
        if (!is_undefined(drawEvent.duration) && drawEvent.duration > 0){
            drawEvent.duration--;
        } else if (drawEvent.duration <= 0){
            array_delete(self.activeDrawEvents, i, 1);
        }
    }
}