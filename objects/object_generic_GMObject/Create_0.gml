/// @description Generic object initialization
self.util = new ObjectUtility(self);

// Components
self.components = {};
self.componentNames = [];

// Draw functions
self.activeDrawEvents = []; //ObjectDrawEvent
self.activeShaderEvent = undefined; //ObjectShaderEvent