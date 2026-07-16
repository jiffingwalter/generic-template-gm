///@description set root game information... attempting to build a dynamic engine that can be appropriated as necessary
global.PROJECT = {};

/// root project name
global.PROJECT.PROJECT_NAME = "TEMPLATE_TEST";

/// project version & environment
global.PROJECT.PROJECT_VERSION = "0.0.0";
global.PROJECT.PROJECT_ENV = "DEV";

/// the input actions that will need to be bound to input keys
global.PROJECT.INPUT_ACTIONS = [
	"UP",
	"DOWN",
	"LEFT",
	"RIGHT",
	"INTERACT",
	"PRIMARY",
	"SECONDARY"
];

/// different types for GM Objects
global.PROJECT.OBJECT_TYPES = [
	"NONE",
	"GENERIC",
	"SYSTEM",
	"ROOM_WALL",
	"ROOM_TRIGGER",
	"ROOM_POINT",
	"ACTOR",
	"PROP",
	"ITEM",
];