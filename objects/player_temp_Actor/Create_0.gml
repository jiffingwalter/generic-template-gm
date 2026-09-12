event_inherited();
/// @description 
util.addComponent(new MovementComponent(self, 5));

// TEMP HARDCODED TEST - CREATE A STATE COMPONENT LATER
components.state = new StateMachine(self);
array_push(componentNames,"state");
components.state.addState(
    "idle", 
    new StateAction(
		undefined,
		0,
		ActionNull
)).addState(
    "moving",
    new StateAction(
		condMovementPressed,
		100,
		ActionMoveFromInput
));


util.addDrawEvent(function(){
    draw_text(x, y - (sprite_height + 18), $"state: {components.state.currentState}");
    draw_text(x, y - (sprite_height + 36), $"facing: {components.movement.facing}");
    draw_text(x, y - (sprite_height + 54), $"move direction: {components.movement.moveDirection}");
})
