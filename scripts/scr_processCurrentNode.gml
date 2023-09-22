//Run through A* process on current node

var debug=false;

if(debug) show_debug_message("____("+string(curX)+","+string(curY)+")_____");
//add to closed list
ds_list_add(C,curNode);

//analyze adjacent blocks/grid locations
//Look for travelable blocks in edges array
// go to one with lowest g score and then use thier edges
var distFromStartToCurrent=ds_map_find_value(G,curNode);
for(var n=0; n< array_length_2d(curNode.edges,0);n++){
    //edge is the node being checked
    var edge_id = curNode.edges[0,n]
    if (edge_id == noone)
        continue;
    var edge_type = curNode.edges[1,n]
    var edgeX = edge_id.x div blockSize
    var edgeY = edge_id.y div blockSize
    
    if(edge_id == curNode)
        continue;
    var closed=ds_list_find_index(C,edge_id)!=-1;
    //var canWalk=false;
    var distFromCurrentToEdge=0;
    
    if(edge_type == 'EdgeType.Platform')
        distFromCurrentToEdge=5;
    
    else if(edge_type == 'EdgeType.StepUp')
    distFromCurrentToEdge= 10//1.7;
    
    else if(edge_type == 'EdgeType.StepDown')
        distFromCurrentToEdge= -10//1.3;
        
    else if(edge_type == 'EdgeType.Runoff')
        distFromCurrentToEdge= 10;
        
    else if(edge_type == 'EdgeType.Jump')
        distFromCurrentToEdge= 15;
        
    else if(edge_type == 'EdgeType.JumpDownOneWay')
        distFromCurrentToEdge= 1;
    
    if(!closed){ //&& canWalk){
        //calculated G,H,and F
        var tempG=distFromStartToCurrent+distFromCurrentToEdge;
        var tempH= point_distance(edgeX,edgeY,endX,endY)
        //abs(edgeX-endX)+abs(edgeY-endY);//insert heuristic of choice (we use manhattan)
            //NOTE : you could also use point_distance(i,j,endX,endY);
        var tempF=tempG+tempH;
        //update if necessary
        var processed=ds_map_exists(G,edge_id);
        if(processed){
            //var oldG=;
            //show_debug_message(string(tempG)+" compare to "+string(oldG));
            var lowerG=(ds_map_find_value(G,edge_id)>tempG);
            if(lowerG){
                ds_map_replace(G,edge_id,tempG);
                ds_map_replace(H,edge_id,tempH);
                ds_priority_change_priority(F,edge_id,tempF);
                ds_map_replace(P,edge_id,curNode);
                //if(debug)
                //    show_debug_message("Updating ("+string(i)+","+string(j)+") G:"+
                //        string(tempG)+" H:"+string(tempH)+" F:"+string(tempF));   
            }
        }else{
            ds_map_add(G,edge_id,tempG);
            ds_map_add(H,edge_id,tempH);
            ds_priority_add(F,edge_id,tempF);
            ds_map_add(P,edge_id,curNode);
            //if(debug)
            //        show_debug_message("Adding ("+string(i)+","+string(j)+")     G:"+
             //           string(tempG)+"     H:"+string(tempH)+"     F:"+string(tempF)); 
        }
    }
    
}
//find best option
var minF=-1;
var empty=ds_priority_empty(F);
if(!empty)
    minF=ds_priority_delete_min(F);
//decide what to do
if(minF==-1){
    searching=false;
    found=false;
    if(debug) show_debug_message("No more nodes left :'(");
}else{
    if(debug) show_debug_message("Trying ("+string(minF)+")");
    curNode = minF
}
//check whether we're at the end
if(curNode = endNode){
    searching=false;
    found=true;
    if(debug)show_debug_message("You found me :D,"+
        " I'm the final block");
}

/*
if(edge_type == 'EdgeType.Platform')
        distFromCurrentToEdge=1;
    // Bigger distance = More Dist
    // Less distance = Less Dist
        
    else if(edge_type == 'EdgeType.Runoff'){
        
        distFromCurrentToEdge=1.5//distance_to_point(curNode.x, edgeX) /5000;
    }
    
    else if(edge_type == 'EdgeType.StepUp')
        distFromCurrentToEdge= 1.7//1.7;
    
    else if(edge_type == 'EdgeType.StepDown')
        distFromCurrentToEdge= -5//1.3;
    
    else if(edge_type == 'EdgeType.Jump')
        distFromCurrentToEdge=3.0;
        
    else if(edge_type == 'EdgeType.JumpDownOneWay')
        distFromCurrentToEdge=0.7;
*/
