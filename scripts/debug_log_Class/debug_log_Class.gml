/// Print debug text to the GM console with an optional context indicator
/// @param {Any} input: content to log
/// @param {String} context: runtime context for the log
function consoleDebug(input,context = ""){
	_consoleGeneric(input,context,"DEBUG");
}

/// Print info text to the GM console with an optional context indicator
/// @param {Any} input: content to log
/// @param {String} context: runtime context for the log
function consoleInfo(input,context = ""){
	_consoleGeneric(input,context,"INFO");
}

/// Print warning text to the GM console with an optional context indicator
/// @param {Any} input: content to log
/// @param {String} context: runtime context for the log
function consoleWarn(input,context = ""){
	_consoleGeneric(input,context,"WARN");
}

/// Print error text to the GM console with an optional context indicator
/// @param {Any} input: content to log
/// @param {String} context: runtime context for the log
function consoleError(input,context = ""){
	_consoleGeneric(input,context,"ERROR");
}

/// Print warning text to the GM console with an optional context indicator
/// @param {Any} input: content to log
/// @param {String} context: runtime context for the log
function _consoleGeneric(input,context,type){
	var output = "";
    var inputType = typeof(input);
    
    switch (inputType){
        case "string":
            output = input;
            break;
        case "bool":
            output = (input) ? "true" : "false";
            break;
        case "struct":
        case "array":
            output = json_stringify(input,true);
            break;
        default:
            output = string(input);
            break;
    }
    
	show_debug_message("***" + type + " " + ((context != "") ? $"[{context}] : " : ": ") + output);
}