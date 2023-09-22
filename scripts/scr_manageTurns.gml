///scr_manageTurns();
//turn order mechanics
Q = ds_priority_create();   // priority queue for timestamps    unit id = value, timestamp[x] = priority
L = ds_list_create();       // list of active units
T = ds_list_create();       // Turn Order List - do not sort - 
                            // takes ids of Q in order from smallest -> largest. 
                            // Smallest timestamps goes first

// Generate Turn List - Runs once in the beginning of battle and is later called after every turn (every action later on)

    scr_genTurnList();

if (ds_exists(T, ds_type_list) && !ds_list_empty(T)){
    //if (object_get_parent(ds_list_find_value(T, 0).object_index) == oActor){
    //if (object_is_ancestor(ds_list_find_value(T, 0).object_index, oActor)){
        if (ds_list_find_value(T, 0).wt < 100){
            // Increment all actors' wt until one of them gets to at least 100
            scr_increment_wt();
        }
    //}
    //else{   
    /*
        // Get current Actor - current Actor is first in T
        if (is_undefined(ds_list_find_value(T, 0)) || 
        ds_list_find_value(T, 0) == 0)
            // if first turnOrder position is undefined or 0, set curActor to noone 
            curActor = noone;
        else 
    */
            // set curActor to first turnOrder pos, as long as it is a valid id
            curActor = ds_list_find_value(T, 0);
        
        // Current Actor is chosen
        if (curActor != noone){
            // Allow Current Actor to move and act
            if (curActor.endTurn == 0){
                curActor.isTurn = true;
            }
            else{   // end of Current Actor's turn
                curActor.isTurn = false
                // Reset wait time 
                curActor.wt = curActor.wt_offset;
               /* 
               // checks for similar wt of other Actors
                for(var s = 0;s<instance_count;s++)
                {
                    
                    if (object_get_parent(instance_id[s].object_index) == oActor){
                        if (curActor != instance_id[s] && curActor.active && instance_id[s].active 
                        && curActor.wt == instance_id[s].wt){
                            instance_id[s].wt += .01;
                        }
                    }
                    
                }
                */
                curActor.endTurn = false;
                
                oAstar.path = 0;
                // Increment turnCount
                turnCount++;
                
                // After every turn, update the data structures -- change to after every action later on
                scr_genTurnList();
                
                curActor = noone;
                
                
            }
        }
    
}
    

