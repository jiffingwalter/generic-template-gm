/// @description Component to allow tracking of multi-faceted state machines for the object
/// @param {Asset.GMObject} ownerIn: Owning object reference
function StateComponent(ownerIn): 
ObjectComponent(ownerIn, "state") constructor{
    owner = ownerIn;
    stateFacets = {}; // {StateMachine}: struct of uniquely named state machines
    stateFacetKeys = []; // [String]: keys of state machine struct
    
    static update = function(){
        // run the update function for each state machine added in the object in the order they were added
    }
    
    ///@description adds a state machine facet to the state component
    static addStateFacet = function(facetName){
        if (!array_contains(self.stateFacetKeys, facetName) || is_undefined(self.stateFacets[$ facetName])){
            self.stateFacets[$ facetName] = new StateMachine(self.owner);
            array_push(self.stateFacetKeys, facetName);
        } else {
            consoleWarn($"tried to add duplicate state facet into state component [{facetName}]","StateComponent");
        }
        return self;
    }
}