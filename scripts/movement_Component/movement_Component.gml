/// @description Component to enable movement and expose useful variables attributed to it
/// @param {Asset.GMObject} ownerIn: Owning object reference
function MovementComponent(ownerIn, moveSpeedIn = 0): 
ObjectComponent(ownerIn, "movement") constructor{
    owner = ownerIn;
    enabled = true;
    moveSpeed = 0;
    currentVelocity = 0;
    moveDirection = 0;
    facing = 0;
    isMoving = false;
    currentPosition = {x: ownerIn.x, y: ownerIn.y};
    lastPosition = {x: ownerIn.x, y: ownerIn.y};
    
    static update = function(){
        // get current position from update
        self.lastPosition.x = currentPosition.x;
        self.lastPosition.y = currentPosition.y;
        self.currentPosition.x = owner.x;
        self.currentPosition.y = owner.y;
        self.isMoving = self.checkIfPositionChanged();
        
        // get current direction from last move
        self.moveDirection = point_direction(self.lastPosition.x, self.lastPosition.y, self.currentPosition.x, self.currentPosition.y);
        if (isMoving) self.facing = self.moveDirection;

        
        // get current velocity from last move?
        
        // listen for movement commands from parent to make the next move
    }
    
    static checkIfPositionChanged = function(){
        return (currentPosition.x != lastPosition.x || currentPosition.y != lastPosition.y);
    }
}