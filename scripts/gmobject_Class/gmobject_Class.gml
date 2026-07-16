/// @description GameMaker Object wrapper class. Provides interface to add components to the object 
///     and utilities to interact with the object
/// @param {Struct} _owner: the parent object we're wrapped around
/// @param {String} _type: the type of object this is. Valid object list is defined in PROJECT file
function GMObject(_owner, _type) constructor{
	type = _type;
    owner = _owner;
	objectTypes = global.PROJECT.OBJECT_TYPES;
	components = {};
    componentNames = [];
	
	static init = function(){
		if (!array_contains(self.objectTypes,self.type)){
			consoleWarn($"WARNING: tried to create object with unknown type ({type})");
		}
	} init();
    
    ///@description Add a component to the component struct by name
    ///@param {InteractableObjComponent} newComponent: Uninitialized component reference
    static addComponent = function(newComponent){
        var newComponentName = newComponent.componentName;
        if (!is_undefined(newComponentName) && is_undefined(self.components[$ newComponentName])){
            self.components[$ newComponentName] = newComponent;
            array_push(self.componentNames,newComponentName);
        } else {
            consoleWarn($"tried to add duplicate component in GMObject ({newComponentName})");
        }
        return self;
    }
	
    ///@description Every step logic
	static onStep = function(){
        // parse through components and run update functions, if any
        var componentNamesLength = array_length(self.componentNames);
		if (componentNamesLength > 0){
			for (var i = 0; i < componentNamesLength; i++){
				self.components[$ self.componentNames[i]].update();
			}
		}
	}
}