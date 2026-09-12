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
            { lower: 0, upper: 45 },
            { lower: 315, upper: 360 }
        ],
        front: [
            { lower: 225, upper: 315 }
        ],
        left: [
            { lower: 135, upper: 225 }
        ]
    };
    facingKeys = struct_get_names(facingBounds);
    facing = "front"; // todo: make this input dynamically
    
    static update = function(){
        // get current position from update
        lastPosition.x = currentPosition.x;
        lastPosition.y = currentPosition.y;
        currentPosition.x = owner.x;
        currentPosition.y = owner.y;
        isMoving = checkIfPositionChanged();
        
        // get current direction from last move
        moveDirection = point_direction(lastPosition.x, lastPosition.y, currentPosition.x, currentPosition.y);
        if (isMoving) facing = determineFacedDirection();

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
        if (facingBounds){
            for (var i = 0; i < array_length(facingKeys); i++){
                var faceString = facingKeys[i];
                var bounds = facingBounds[$ faceString];
                
                for (var j = 0; j < array_length(bounds); j++){
                    var lowerBound = bounds[j].lower;
                    var upperBound = bounds[j].upper;
                    if (moveDirection >= lowerBound && moveDirection < upperBound) return faceString;
                }
            }
            consoleWarn("Object fell through all face direction potentials...","MovementComponent.determineFacedDirection");
        }
    }
}