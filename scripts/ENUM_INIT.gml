enum NodeType{
    Walkway, 
    LedgeLeft,
    LedgeRight,
    LedgeBoth,
    DownOneWay
}

//specify what action is required by the agent to traverse the edge
enum EdgeType{
    Platform,
    RunOff,
    Jump,
    StepUp,
    DownOneWay    
    
}


/*
Perfect the tradjectory of the markers. Maybe need to use motionX and Y
instead of yIncr and xIncr? Maybe not.. Check back with info page and get
the right arc. Markers can connect to other nodes with the Runoff script.
Jump script is not yet tampered with. Deal with Runoff first then go on.
Databin values * blockSize? Idk fuck around with it
*/


/*
Keyboard controls restricted to oGame Step event - 
Added Palette System - 
Added Time speed up / slow down feature - 
Added Turn Order System
Added Pause Feature
Issue: Low REAL FPS (40 - 60) 
deactivating objects help but not enough

*/
