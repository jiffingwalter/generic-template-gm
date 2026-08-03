/// @description 
var gameCameraInstance = instance_find(game_camera_GMObject, 0);
var playerInstance = instance_find(player_temp_Object, 0);
gameCameraInstance.followTarget = playerInstance;

var sign1Instance = instance_find(rm1_sign_1,0);
var sign2Instance = instance_find(rm1_sign_2,0);

with (sign1Instance){
    sign2 = sign2Instance;
    camera = gameCameraInstance;
    player = playerInstance;
    
    self.components.interactable
    .addInteraction(new InteractionEvent("1", function(){
        camera.followTarget = sign2;
        self.components.interactable.nextInteraction();
    }))
    .addInteraction(new InteractionEvent("2", function(){
        camera.followTarget = player;
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
    }));
}