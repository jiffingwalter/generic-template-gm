/// @description 
draw_self();

var activeDrawEventsLength = array_length(self.activeDrawEvents);
if (activeDrawEventsLength > 0){
    for (var i = 0; i < activeDrawEventsLength; i++){
        var drawEvent = self.activeDrawEvents[i];
        if (is_callable(drawEvent.callback)) drawEvent.callback();
    }
}