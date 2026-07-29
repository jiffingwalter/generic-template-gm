/// @description 
var gameCameraInstance = instance_find(game_camera_GMObject, 0);
var playerInstance = instance_find(player_temp_Object, 0);
gameCameraInstance.followTarget = playerInstance;

var sign1Instance = instance_find(rm1_sign_1,0);
consoleDebug(sign1Instance);
var sign2Instance = instance_find(rm1_sign_2,0);
consoleDebug(sign2Instance);