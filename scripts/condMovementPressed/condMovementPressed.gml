/// @description ACTION CONDITION: returns if any movement input buttons are currently being pressed
function condMovementPressed(){
	return (
		global.input.pressed.UP || 
		global.input.pressed.DOWN || 
		global.input.pressed.LEFT || 
		global.input.pressed.RIGHT
	);
}