/// @description Component to enable dynamic animation and visual control over an object through defined sprites
/// @param {Asset.GMObject} ownerIn: Owning object reference
function AnimationComponent(ownerIn): ObjectComponent(ownerIn, "animation") constructor{
    animationSet = {};
    animationAssets = {};
    active = undefined;
}