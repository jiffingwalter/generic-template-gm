/// @description SHADER MANAGER ON STARTUP
global.shaders = {};
// initialize shaders and their uniforms here
// hold on to shader references so that other objects can pull them from here
// TODO: look into automating what this array pulls from for the actual shaders it initializes

global.shaders.glow = new Shader(glow_Shader, ["brightness"]);
