/// @description Defines a state controller class for holding state and logic, made up of StateAction classes
/// @param {Asset.GMObject} ownerIn: The owning parent object that will be modified by the state
/// @param {Struct} stateStructIn: Optional, shorthand initialization of state struct. a struct with key/value pairs of possible states with values of array of StateActions
function StateMachine(ownerIn, stateStructIn = {}) constructor{
	currentState = "_UNSET_";
	previousState = "_UNSET_";
	owner = ownerIn;
	states = {};
	stateNames = [];
	
	/// Add a struct of one or more states to the state machine
	/// @param {String} stateName: The name of the new state to add to the state machine. must be unique.
    /// @param {Asset.StateMachine} stateObject: The initialized state data for the state.
	static addState = function(stateName, stateObject){
        if (!array_contains(stateNames, stateName) || is_undefined(states[$ stateName])){
            states[$ stateName] = stateObject;
        } else {
            consoleWarn($"tried to add duplicate state in state machine ({stateName})","StateMachine");
        }
		
		_resortStateNames();
		return self;
	}
	
	/// @description Resort the current states name list by priority order, larger priority values take precedence. Do this any time we add state(s) to the state machine to ensure priority is correct
	/// @return {Array<String>} The updated state names
    static _resortStateNames = function(){
		stateNames = struct_get_names(states);
		array_sort(stateNames,function(current,next){
			return states[$ next].priority - states[$ current].priority;
		});
        return stateNames;
	}
	
	/// @description On tick, parse through states defined in states array
	/// @return {Struct} State action that was switched to or False if the state wasn't updated
	static update = function(){
		// for each state in priority order, check if the state's conditional passes and transition if so
		for (var i = 0; i < array_length(stateNames); i++){
			var potentialState = states[$ stateNames[i]];
			var conditionPassed = potentialState.checkCondition(owner);
            var isLast = (i + 1 == array_length(stateNames));

			if ((conditionPassed && stateNames[i] != currentState) || isLast) {
				setState(stateNames[i]);
				break;
			} else if (conditionPassed && stateNames[i] == currentState) {
				break;
			}
		}
		
		// get the current state object and update...
		var state = states[$ currentState];
		if (currentState != "_UNSET_" && is_callable(state.update))	// TODO: add a buffer here to the conditonal that skips the update if we changed state on the current run?
			state.update(owner);
	}
	
	/// @description Set current state and run any enter/exit logic
	static setState = function(stateNameIn){
		// if entering a new state... run exit logic for previous state and begin the next state
		if (states[$ stateNameIn]){
			previousState = currentState;
			currentState = stateNameIn;
			
			if (previousState != "_UNSET_" && is_callable(states[$ previousState].onExit)) 
				states[$ previousState].onExit(owner);
				
			if (is_callable(states[$ stateNameIn].onEnter))
				states[$ stateNameIn].onEnter(owner);
				
			return states[$ currentState];
		} else {
			consoleWarn($"tried to change state to nonexistent state in state machine ({currentState} to {stateNameIn})");
			return false;
		}
	}
}