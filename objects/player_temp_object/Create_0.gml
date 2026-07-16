event_inherited();

//todo: break this into a movement component class
self.moveSpeed = 5;
self.movementStateMachine = new StateMachine(self);
self.movementStateMachine.addStates({
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