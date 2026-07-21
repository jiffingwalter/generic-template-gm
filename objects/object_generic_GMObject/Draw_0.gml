/// @description 
var activeDrawEventsLength = array_length(self.activeDrawEvents);
if (activeDrawEventsLength > 0){
    draw_self();
    for (var i = 0; i < activeDrawEventsLength; i++){
        var drawEvent = self.activeDrawEvents[i];
        drawEvent.callback();
    }
}