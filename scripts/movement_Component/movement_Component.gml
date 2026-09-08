/// @description Component to enable movement and expose useful variables attributed to it
/// @param {Asset.GMObject} ownerIn: Owning object reference
/// @param {Real} moveSpeedIn: The initial move speed for the object
function MovementComponent(ownerIn, moveSpeedIn = 0): 
ObjectComponent(ownerIn, "movement") constructor{
    owner = ownerIn;
    enabled = true;
    moveSpeed = moveSpeedIn;
    currentVelocity = 0;
    moveDirection = 0;
    currentPosition = {x: ownerIn.x, y: ownerIn.y};
    lastPosition = {x: ownerIn.x, y: ownerIn.y};
    isMoving = false;
    facing = undefined; // todo: make this input dynamically
    facingBounds = { // todo: make this input dynamically
        back: [
            { d1: 45, d2: 135 }
        ],
        right: [
            { d1: 0, d2: 25 },
            { d1: 315, d2: 360 }
        ],
        front: [
            { d1: 225, d2: 315 }
        ],
        left: [
            { d1: 135, d2: 225 }
        ]
    };
    facingKeys = variable_struct_get_names(self.facingBounds);
    
    static update = function(){
        // get current position from update
        self.lastPosition.x = currentPosition.x;
        self.lastPosition.y = currentPosition.y;
        self.currentPosition.x = owner.x;
        self.currentPosition.y = owner.y;
        self.isMoving = self.checkIfPositionChanged();
        
        // get current direction from last move
        if (isMoving) self.facing = determineFacedDirection();
        self.moveDirection = point_direction(self.lastPosition.x, self.lastPosition.y, self.currentPosition.x, self.currentPosition.y);

        // get current velocity from last move?
        
        // listen for movement commands from parent to make the next move
    }
    
    /// @description Quick check for if movement changed
    /// @returns {Bool} If movement changed
    static checkIfPositionChanged = function(){
        return (currentPosition.x != lastPosition.x || currentPosition.y != lastPosition.y);
    }
    
    /// @description Gets the current "facing" string from the facing bounds array based on if any of the set facing bounds match
    static determineFacedDirection = function(){
        if (self.facingBounds){
             // for each face key...
            for (var i = 0; i < array_length(self.facingKeys); i++){
                var faceString = self.facingKeys[i];
                var bounds = self.facingBounds[$ faceString];
                // ...step through each of its bounds values
                for (var j = 0; j < array_length(bounds); j++){
                    var bound1 = bounds[j].d1;
                    var bound2 = bounds[j].d2;
                    // ... and check each bound for if it's valid, returning if so
                    if (self.moveDirection >= bound1 && self.moveDirection < bound2) return faceString;
                }
            }
        }
    }
}