/// @description 
// parse through components and run update functions, if any
var componentNamesLength = array_length(self.componentNames);
if (componentNamesLength > 0){
    for (var i = 0; i < componentNamesLength; i++){
        self.components[$ self.componentNames[i]].update();
    }
}