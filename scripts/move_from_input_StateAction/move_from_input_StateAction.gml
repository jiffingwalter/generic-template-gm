/// @description Generic handler to move an object based on input from the player machine
/// @param {Asset.GMObject} owner: Reference to the GameMaker object owned by the state (if needed)
function ActionMoveFromInput(owner = {}){
	if (global.input.pressed.UP) owner.y -= owner.components.movement.moveSpeed;
	if (global.input.pressed.DOWN) owner.y += owner.components.movement.moveSpeed;
	if (global.input.pressed.LEFT) owner.x -= owner.components.movement.moveSpeed;
	if (global.input.pressed.RIGHT) owner.x += owner.components.movement.moveSpeed;
        
    // VERY VERY TEMP, change sprite based on movement's current faced direction... TODO: figure out where this should live...? define in initial animation component code?
    if (owner.components.movement.facing == "front") owner.sprite_index = player_temp_stand_idle_front_Sprite;
    if (owner.components.movement.facing == "back") owner.sprite_index = player_temp_stand_idle_back_Sprite;
    if (owner.components.movement.facing == "left") owner.sprite_index = player_temp_stand_idle_left_Sprite;
    if (owner.components.movement.facing == "right") owner.sprite_index = player_temp_stand_idle_right_Sprite;
}