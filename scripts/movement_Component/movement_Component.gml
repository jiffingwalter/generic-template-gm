/// @description Component to enable movement and expose useful variables attributed to it
/// @param {Asset.GMObject} ownerIn: Owning object reference
function MovementComponent(ownerIn): 
ObjectComponent(ownerIn, "movement") constructor{
    owner = ownerIn;
    enabled = true;
    moveSpeed = 0;
    currentVelocity = 0;
    currentDirection = 0;
    currentPosition = {x: ownerIn.x, y: ownerIn.y};
    lastPosition = {x: ownerIn.x, y: ownerIn.y};
    
    static update = function(){
        // get current position from update
        self.lastPosition.x = currentPosition.x;
        self.lastPosition.y = currentPosition.y;
        self.currentPosition.x = owner.x;
        self.currentPosition.y = owner.y;
        
        // get current direction from last move - TODO: only update this if a move happened previously
        self.currentDirection = point_direction(self.lastPosition.x, self.lastPosition.y, self.currentPosition.x, self.currentPosition.y);
        
        // get current velocity from last move?
        
        // listen for movement commands from parent to make the next move
    }
}