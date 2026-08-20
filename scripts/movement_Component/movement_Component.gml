/// @description Component to enable movement and expose useful variables attributed to it
/// @param {Asset.GMObject} ownerIn: Owning object reference
function MovementComponent(ownerIn): 
ObjectComponent(ownerIn, "movement") constructor{
    movementEnabled = true;
    moveSpeed = 0;
    moveVelocity = 0;
    moveDirection = "FRONT";
}