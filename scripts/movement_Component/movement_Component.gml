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
    facingBounds = { // todo: make this input dynamically
        back: [
            { lower: 45, upper: 135 }
        ],
        right: [
            { lower: 0, upper: 25 },
            { lower: 315, upper: 360 }
        ],
        front: [
            { lower: 225, upper: 315 }
        ],
        left: [
            { lower: 135, upper: 225 }
        ]
    };
    facingKeys = variable_struct_get_names(self.facingBounds);
    facing = "front"; // todo: make this input dynamically
    
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
    /// @returns {String} facing direction
    static determineFacedDirection = function(){
        if (self.facingBounds){
            for (var i = 0; i < array_length(self.facingKeys); i++){
                var faceString = self.facingKeys[i];
                var bounds = self.facingBounds[$ faceString];
                
                for (var j = 0; j < array_length(bounds); j++){
                    var lowerBound = bounds[j].lower;
                    var upperBound = bounds[j].upper;
                    if (self.moveDirection >= lowerBound && self.moveDirection < upperBound) return faceString;
                }
            }
            consoleWarn("Object fell through all face direction potentials...","MovementComponent.determineFacedDirection");
        }
    }
}