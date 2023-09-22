///scr_genTurnList();
// Generate a proper Turn Order System

// clear datastructures before adding any values
ds_priority_clear(Q);
ds_list_clear(L);
ds_list_clear(T);

// Update L - List of Units 
for (var c = 0; c < instance_count; c++){
    //if (object_get_parent(instance_id[c].object_index) == oActor){
    if (object_is_ancestor(instance_id[c].object_index, oActor)){
        if (instance_id[c].active == true){
            ds_list_add(L, instance_id[c]);
            
            for (var b = 0; b < ds_list_size(L); b++){
                var otherUnit = ds_list_find_value(L, b); 
        
                if (instance_id[c] != otherUnit && instance_id[c].wt == otherUnit.wt){
                    // wt_offset actor's wt if another actor has the same wt
                    if (instance_id[c].wt_speed > otherUnit.wt_speed){
                        otherUnit.wt_offset -= .01;
                        otherUnit.wt -= .01;
                    }
                    else if (instance_id[c].wt_speed < otherUnit.wt_speed){
                        instance_id[c].wt_offset -= .01;
                        instance_id[c].wt -= .01;
                    }
                    else if (instance_id[c].wt_speed == otherUnit.wt_speed){    // choose random
                        if (random_range(0, 1)){
                            instance_id[c].wt_offset -= .01;
                            instance_id[c].wt -= .01;
                        }
                        else{
                            otherUnit.wt_offset -= .01
                            otherUnit.wt -= .01
                        }
                    }
                }
            } 
        }
    }
}


// Fill Q with timestamps
if (ds_exists(L,ds_type_list)){
    for (var t = 0; t < ds_list_size(L); t++){
        var curUnit = ds_list_find_value(L,t);
        with (curUnit){
            //var A = 0;
            // Fill Q with 10 timestamps of 1st unit
            //if (ds_list_find_index(oGame.L, id) == 0){
                // gets the timestamps for the next n turns of a given unit
           //     scr_getNextTurns(oGame.T_size);
            //}
            // Overwrite 1st unit's timesptamps with other units' timestamps
            //else{   
                // adds timestamps for units until timestamp gives result past max in Q
                scr_getTurnsBeforeT(oGame.T_size);
           // }
        }
    }
}

// Transfer ids (smallest to largest) from Q to T (Turn Order List
//repeat(T_size){
while(ds_list_size(T) < T_size && ds_priority_size(Q) > 0){
        ds_list_add(T, ds_priority_delete_min(Q));
}
//b = 1;
