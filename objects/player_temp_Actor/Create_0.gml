event_inherited();
/// @description 
self.util.addComponent(new MovementComponent(self, 5));

// TEMP HARDCODED TEST - CREATE A STATE COMPONENT LATER
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

self.util.addDrawEvent(function(){
    draw_text(x, y - (self.sprite_height + 18), $"state: {self.components.state.currentState}");
    draw_text(x, y - (self.sprite_height + 36), $"facing: {self.components.movement.facing}");
    draw_text(x, y - (self.sprite_height + 54), $"move direction: {self.components.movement.moveDirection}");
})
