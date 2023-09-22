///scr_getNextTurns(n);\
// individial Actors run this script

// when actor's wt is 0, replenis

var n = argument0;
var t = 0;

for(var i = 0; i < n; i++){ //Work out timestamps of next n turns
    var final_timestamp;
    //timestamps[i] = t+((i+1) * wt_max - wt) / wt_speed;
    timestamps[i] = t+((i+1) * wt_max - wt) / wt_speed;
    
    
    if (ds_priority_find_priority(oGame.Q, timestamps[i]))
        final_timestamp = timestamps[i] + .01;
    else
        final_timestamp = timestamps[i];
        
    ds_priority_add(oGame.Q, id, final_timestamp);
    t++;
    
}

/*
var n = argument0;
var t = 0;

for(var i = 0; i < n; i++){ //Work out timestamps of next n turns
    var final_timestamp;
    //timestamps[i] = t+((i+1) * wt_max - wt) / wt_speed;
    timestamps[i] = t+((i+1) * wt_max - wt) / wt_speed;
    
    final_timestamp = timestamps[i];
    
    while(ds_priority_find_priority(oGame.Q, final_timestamp)){

        final_timestamp = timestamps[i] + .01;
    }
    ds_priority_add(oGame.Q, id, final_timestamp);
    t++;
    
}
*/
//exit;



// https://www.reddit.com/r/gamedev/comments/5b17uk/is_there_a_math_formula_to_calculate_turn_order/
/*  Original
getNextNTurns(n) {
//speed = 10;
//currentReadiness = 50;
//MAX = 100;
//currentTime = t;
timestamps = []; //Empty array/vector/whatever
for(int i = 0; i < n; i++) //Work out timestamps of next n turns
    timestamps.push_back(t+((i+1) * MAX-currentReadiness)/speed);
return timestamps; }
*/
