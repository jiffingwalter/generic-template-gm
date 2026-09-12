/// @description Component to allow tracking of multi-faceted state machines for the object
/// @param {Asset.GMObject} ownerIn: Owning object reference
function StateComponent(ownerIn): 
ObjectComponent(ownerIn, "state") constructor{
    owner = ownerIn;
    facets = {}; // {StateMachine}: struct of uniquely named state machines
    facetKeys = []; // [String]: keys of state machine struct
    
    static update = function(){
        var facetCount = array_length(facetKeys);
        // run the update function for each state machine added in the object in the order they were added
        if (facetCount > 0){
            for (var i = 0; i < facetCount; i++){
              var facet = facets[$ facetKeys[i]];
              facet.update();
          }
        }
    }
    
    ///@description adds a state machine facet to the state component
    static addStateFacet = function(facetName){
        if (!array_contains(facetKeys, facetName) || is_undefined(facets[$ facetName])){
            facets[$ facetName] = new StateMachine(owner);
            array_push(facetKeys, facetName);
        } else {
            consoleWarn($"tried to add duplicate state facet into state component [{facetName}]","StateComponent");
        }
        return self;
    }
}