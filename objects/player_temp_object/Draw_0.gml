draw_self();

// object origin
draw_set_colour(c_green);
draw_circle(x, y, 2, false);

// object state
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_text(x, y - (self.sprite_height + 18), $"state: {self.movementStateMachine.currentState}");