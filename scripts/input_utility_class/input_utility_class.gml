/// @description Input utility class for storing and manipulating 
function InputUtility() constructor{
	actions = global.PROJECT.INPUT_ACTIONS;
	
	/// function: initialize input globals, populate globals with action and default binding data, get the active method of input, 
	static initialize = function(){
		global.input = {
			enabled: false, // is input currently enabled?
			source: undefined, // where input is being sourced from
			bindings: {}, // binding map for keys to input actions
			pressed: {}, // true while the action is currently pressed
            pressStart: {}, // true on the single tick the action gets pressed down
            pressEnd: {} // true on the single tick the action press stops
		}
		
		// build out shell bindings and pressed arrays...
		for (var i = 0; i < array_length(self.actions); i++){
			var action = self.actions[i];
			global.input.bindings[$ action] = undefined;
			global.input.pressed[$ action] = false;
            global.input.pressStart[$ action] = false;
            global.input.pressEnd[$ action] = false;
		}
		
		// TEMP: set bindings...
		// TODO: build function that pulls this data from an options file or similar
		// TODO: set up logic to store bindings for multiple input methods at the same time
		global.input.bindings.UP = "W";
		global.input.bindings.DOWN = "S";
		global.input.bindings.LEFT = "A";
		global.input.bindings.RIGHT = "D";
		global.input.bindings.INTERACT = "E";
		global.input.bindings.PRIMARY = "SPACE";
		global.input.bindings.SECONDARY = "SHIFT";
	}
	
	/// on step input handler - read through input actions and flag if the associated binding is pressed
	static onStep = function(){
		// flag or keep flagged if input is pressed
		for (var i = 0; i < array_length(self.actions); i++){
			var key = global.input.bindings[$ self.actions[i]];
            
            var wasPressedPreviously = (global.input.pressed[$ self.actions[i]]);
            var isPressedNow = keyboard_check(ord(key))
            
            if (!wasPressedPreviously && isPressedNow){
                global.input.pressStart[$ self.actions[i]] = true;
            } else if (wasPressedPreviously && isPressedNow){
                global.input.pressStart[$ self.actions[i]] = false;
            }
            
            global.input.pressed[$ self.actions[i]] = isPressedNow;
            
            if (wasPressedPreviously && !isPressedNow){
                global.input.pressEnd[$ self.actions[i]] = true;
            } else if (!wasPressedPreviously && !isPressedNow){
                global.input.pressEnd[$ self.actions[i]] = false;
            }
		}
	}
	
	// parseBindings<function>: read bindings from some to-be-determined options file for current input...
}