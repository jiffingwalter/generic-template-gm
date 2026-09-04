/// @description Generic handler to move an object based on input from the player machine
/// @param {GMObject} owner: Reference to the GameMaker object owned by the state (if needed)
function ActionMoveFromInput(owner = {}){
	if (global.input.pressed.UP) owner.y -= owner.components.movement.moveSpeed;
	if (global.input.pressed.DOWN) owner.y += owner.components.movement.moveSpeed;
	if (global.input.pressed.LEFT) owner.x -= owner.components.movement.moveSpeed;
	if (global.input.pressed.RIGHT) owner.x += owner.components.movement.moveSpeed;
}