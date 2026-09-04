/// @description 
// METADATA TEST -- this would all be injected into the room via some sort of look up that checks to see if the current room has scripts and what 
var gameCameraInstance = instance_find(game_camera_GMObject, 0);
var playerInstance = instance_find(player_temp_Actor, 0);
gameCameraInstance.followTarget = playerInstance;

var sign1Instance = instance_find(rm1_sign_1,0);
var sign2Instance = instance_find(rm1_sign_2,0);

// TODO: when starting room script system, make function that accepts an instance, callback function, and an input variable struct? 
//      basically would do the "with" but creates repeatable pattern for "injecting" input variables from the script so it doesn't have to be typed everytime
with (sign1Instance){
    input = {
        camera: gameCameraInstance,
        player: playerInstance,
        sign2: sign2Instance
    }
    
    self.components.interactable
    .addInteraction(new InteractionEvent("1", function(){
        input.camera.followTarget = input.sign2;
        self.components.interactable.nextInteraction();
    }))
    .addInteraction(new InteractionEvent("2", function(){
        input.camera.followTarget = input.player;
        self.components.interactable.disableInteraction();
    }));
}

with (sign2Instance){
    self.components.interactable
    .addInteraction(new InteractionEvent("1", function(){
        self.util.addDrawEvent(function(){
            draw_set_colour(c_white);
            draw_set_halign(fa_center);
            draw_text(self.x, self.y - (self.sprite_height + 30), $"You read the sign. Holy moly...!");
        }, 150, "sign_interact_text");
        self.components.interactable.nextInteraction();
    }))
    .addInteraction(new InteractionEvent("2", function(){
        self.util.removeDrawEvents($"sign_interact_text");
        self.util.addDrawEvent(function(){
            draw_set_colour(c_white);
            draw_set_halign(fa_center);
            draw_text(self.x, self.y - (self.sprite_height + 30), $"...it just says \"E\".");
        }, 150, "sign_interact_text");
        self.components.interactable.disableInteraction();
    }));
}