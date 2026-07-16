/// @description Waits a set time, then optionally runs a function
/// @param {int} timeout: The amount of time to wait for in miliseconds
function Timer(timeMS,functionInput,repeatTimer) constructor{
	counter = 0;
	timeoutTime = timeMS;
	repeatTime = repeatTimer;
	timeoutAction = functionInput;
	
	static start = function(){
		if (counter > timeoutTime){
			counter--;
		} else if (counter == 0){
			if (!is_undefined(timeoutAction)) timeoutAction();
			counter--;
		}
		return counter;
	}
	start();
	
	static stop = function(){
		
	}
	
	static reset = function(){
		counter = timeoutTime;
	}
	
	
}