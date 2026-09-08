/// @description Component to enable dynamic animation and visual control over an object through defined sprites
/// @param {Asset.GMObject} ownerIn: Owning object reference
function AnimationComponent(ownerIn): 
ObjectComponent(ownerIn, "animation") constructor{
    owner = ownerIn;
    animationSet = {};
    animationAssets = {};
    active = undefined;
    
    static update = function(){
        // check the frame of the current animation for any frame events and run them if so
    }
}