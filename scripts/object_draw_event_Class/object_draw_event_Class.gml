/// @description An event callback to be ran in the draw event of an object
/// @param {Function} callbackIn: The logic to run every frame the draw event while it exists
/// @param {Real} durationIn: The amount of frames the draw event lasts for. Indefinite if none provided
/// @param {String} label: A unique identifier to access the draw event by for manual removal
function ObjectDrawEvent(callbackIn, durationIn = undefined, labelIn = undefined) constructor {
    callback = callbackIn;
    duration = durationIn;
    label = labelIn;
}