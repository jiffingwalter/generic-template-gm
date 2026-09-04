event_inherited();
/// @description 
self.util.addComponent(new MovementComponent(self));

// TEMP TEST - REFACTOR STATE TO COMPONENT ARCHITECTURE LATER
self.components.state = new StateMachine(self);
array_push(self.componentNames,"state");
self.components.state.addStates({
	idle: new StateAction(
		undefined,
		0,
		ActionNull
	),
	moving: new StateAction(
		condMovementPressed,
		100,
		ActionMoveFromInput
	)
});
