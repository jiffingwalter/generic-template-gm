/// @description Defines a state controller class for holding state and logic, made up of StateAction classes
/// @param {Struct} _owner: The owning parent object that will be modified by the state
/// @param {Struct} _stateStruct: Optional, shorthand initialization of state struct. a struct with key/value pairs of possible states with values of array of StateActions
function StateMachine(_owner, _stateStruct = {}) constructor{
	currentState = "_UNSET_";
	previousState = "_UNSET_";
	owner = _owner;
	states = {};
	stateNames = [];
	
	static _init = function(stateStructIn){
		if (!is_undefined(stateStructIn) && struct_names_count(stateStructIn) > 0){
			addStates(stateStructIn);
		}
	} _init(_stateStruct);
	
	/// Add a struct of one or more states to the state machine
	/// @param {Struct} _stateStruct: A struct of StateActions. Keys act as the name of the new state, values should be a StateAction struct
	static addStates = function(_stateStruct){
		var newStateNames = struct_get_names(_stateStruct);
		
		for (var i = 0; i < array_length(newStateNames); i++){
			if (!is_undefined(states[$ newStateNames[i]])){
				consoleWarn($"tried to add duplicate state in state machine ({newStateNames[i]})");
			} else {
				states[$ newStateNames[i]] = _stateStruct[$ newStateNames[i]];
			}
		}
		
		_resortStateNames();
		return self;
	}
	
	/// Resort the current states name list by priority order, larger priority values take precedence. Do this any time we add state(s) to the state machine to ensure priority is correct
	static _resortStateNames = function(){
		stateNames = struct_get_names(states);
		array_sort(stateNames,function(current,next){
			return states[$ next].priority - states[$ current].priority;
		});
	}
	
	/// On tick, parse through states defined in states array
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
	
	/// Set current state and run any enter/exit logic
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