///getTurnsBeforeT(T_size);
// individial Actors run this script


// Old - getTurnsBeforeT(targetTime)  // Target time is t1, which is the last value in Q. Just use ds_priority_find_max
//currentTime = t;
var n = argument0;

//var t = 0
var next = 0;
//get turns up to some timestamp t, and adds it into a queue:
//for (var i=0; i<n; i++){
for (var i=0; i<10; i++){ //Loop until timestamp gives result past targetTime
    timestamps[i] = oGame.turnCount + ((i+1) * wt_max - wt) / wt_speed;
    
    if (ds_priority_find_priority(oGame.Q, timestamps[i]))
        timestamps[i] += .01;
     
    // delete any excess elements in the queue
    if (ds_priority_size(oGame.Q) > n){
            ds_priority_delete_max(oGame.Q); //Keep queue size constant  
    }
    // if timestamp is less than the max in the queue, delete the max timestamp
    if (ds_priority_size(oGame.Q) == n){
        if(timestamps[i] < ds_priority_find_max(oGame.Q)){
            next = ds_priority_delete_max(oGame.Q); //Keep queue size constant
        }
    }
    
    // Add timestamp as long as there is space in queue 
    if (ds_priority_size(oGame.Q) < n){
        ds_priority_add(oGame.Q,id, timestamps[i]);
    }
    
    //t++;
}




