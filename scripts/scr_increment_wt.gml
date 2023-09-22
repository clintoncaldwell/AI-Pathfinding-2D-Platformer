///scr_increment_wt(); 
// increment every actor's wt

// search through list of active units
for (var a = 0; a<ds_list_size(L);a++){
    var curUnit = ds_list_find_value(L, a);
    // increment actor's wt by actor's wt_speed
    curUnit.wt += curUnit.wt_speed;
    
   /* 
    // check if Actor has similar wt to any other Actor (besides themselves)
    for (var b = 0; b < ds_list_size(L); b++){
        var otherUnit = ds_list_find_value(L, b); 
        
        
        if (a != b && curUnit.wt == otherUnit.wt){
            // if wt is equal to another actor, offset it by incrementing the other actor's wt 
            // (They were first to have that wt, not the currnent actor)
            if (curUnit.wt_speed > otherUnit.wt_speed)
                curUnit.wt += 1;
            else if (curUnit.wt_speed < otherUnit.wt_speed)
                curUnit.wt -= 1;
            else
                curUnit.wt -= 1;
        }
        
    } 
    
    */
}
//exit;




/*
for (var a = 0; a<instance_count;a++){
    if (object_get_parent(instance_id[a].object_index) == oActor){
        if (instance_id[a].active == true){
            
            // increment actor's wt by actor's wt_speed
            instance_id[a].wt += instance_id[a].wt_speed;
            
            // check if Actor has similar wt to any other Actor (besides themselves)
            for (var b = 0; b < instance_count; b++){
                if (object_get_parent(instance_id[b].object_index) == oActor){
                    if (instance_id[a] != instance_id[b] && instance_id[a].active == true && 
                        instance_id[b].active == true && instance_id[a].wt == instance_id[b].wt){
            
                        // if wt is equal to another actor, offset it by incrementing the other actor's wt 
                        // (They were first to have that wt, not the currnent actor)
                        instance_id[b].wt += .001;
                    }
                }
            } 
        }
    }
}
exit;
*/
