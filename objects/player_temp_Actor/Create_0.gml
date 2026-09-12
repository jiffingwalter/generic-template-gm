event_inherited();
util.addComponent(new MovementComponent(self, 5));
util.addComponent(new StateComponent(self));

// populate state component
// [MODE][ACTION][DIRECTION]
components.state.addStateFacet("mode");
components.state.addStateFacet("action");
components.state.addStateFacet("direction");
components.state.facets.mode.addState( // only using mode rn for testing
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
    //draw_text(x, y - (sprite_height + 18), $"state: {components.state.currentState}");
    draw_text(x, y - (sprite_height + 36), $"facing: {components.movement.facing}");
    draw_text(x, y - (sprite_height + 54), $"move direction: {components.movement.moveDirection}");
})
