/// @description 
var gameCameraInstance = instance_find(game_camera_GMObject, 0);
var playerInstance = instance_find(player_temp_Object, 0);
gameCameraInstance.followTarget = playerInstance;
consoleDebug(gameCameraInstance);
consoleDebug(playerInstance);