/// @description An individual action to be associated to a state
/// @param {Function} conditionalIn: A callback that returns a boolean value that is evaluated every update for to decide if the state action should execute
/// @param {Real} priorityIn: An integer that defines the order the action will be read and fired inside the state machine. Larger priority values take precedence.
/// @param {Function} updateCallbackIn: A callback function that defines the state CORE logic that will be run if the state is fired
/// @param {Function} enterCallbackIn: Optional, a callback function that defines the state ENTER logic that will be run if the state is fired
/// @param {Function} exitCallbackIn: Optional, a callback function that defines the state EXIT logic that will be run if the state is fired
/// @param {Bool} isDefaultIn: Optional, flags if this StateAction is a default state that will always fire

function StateAction(conditionalIn = undefined, priorityIn, updateCallbackIn, enterCallbackIn = undefined, exitCallbackIn = undefined, isDefaultIn = false) constructor{
	condition = conditionalIn;
	priority = priorityIn;
	update = updateCallbackIn;
	onEnter = enterCallbackIn;
	onExit = exitCallbackIn;
	isDefault = isDefaultIn;
	
    /// Run the conditional check function (or return false if no condition is provided)
	static checkCondition = function(owner){
		return is_callable(condition) ? condition(owner) : false;
	}
}