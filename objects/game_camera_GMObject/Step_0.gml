/// @description 
if (!is_undefined(self.followTarget)){
    var newX = (followTarget.x - self.x) * 0.15;
    var newY = (followTarget.y - self.y) * 0.15;
    
    self.x += newX;
    self.y += newY;
}
if (!is_undefined(self.viewport.camera)){
    self.viewport.widthOffset = camera_get_view_width(self.viewport.camera) * 0.5;
    self.viewport.heightOffset = camera_get_view_height(self.viewport.camera) * 0.5;
    
    self.x = clamp(self.x, self.viewport.widthOffset, room_width - self.viewport.widthOffset);
    self.y = clamp(self.y, self.viewport.heightOffset, room_height - self.viewport.heightOffset);
    
    camera_set_view_pos(self.viewport.camera, self.x - self.viewport.widthOffset, y - self.viewport.heightOffset);
}