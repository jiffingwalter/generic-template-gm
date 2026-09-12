/// @description 
if (!is_undefined(followTarget)){
    var newX = (followTarget.x - x) * 0.15;
    var newY = (followTarget.y - y) * 0.15;
    
    x += newX;
    y += newY;
}
if (!is_undefined(viewport.camera)){
    viewport.widthOffset = camera_get_view_width(viewport.camera) * 0.5;
    viewport.heightOffset = camera_get_view_height(viewport.camera) * 0.5;
    
    x = clamp(x, viewport.widthOffset, room_width - viewport.widthOffset);
    y = clamp(y, viewport.heightOffset, room_height - viewport.heightOffset);
    
    camera_set_view_pos(viewport.camera, x - viewport.widthOffset, y - viewport.heightOffset);
}