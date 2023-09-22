//Run through A* process on current node

var debug=true;

if(debug) show_debug_message("____("+string(curX)+","+string(curY)+")_____");
//add to closed list
ds_list_add(C,getKey(curX,curY));

//analyze adjacent blocks/grid locations
var distFromStartToCurrent=ds_map_find_value(G,getKey(curX,curY));
for(var i=max(0,curX-1);i<=min(oAStar.fieldWidth-1,curX+1);i++){
    for(var j=max(0,curY-1);j<=min(oAStar.fieldHeight-1,curY+1);j++){
        if(i==curX && j==curY)
            continue;
        var closed=ds_list_find_index(C,getKey(i,j))!=-1;
        var diagonal=((i+j)%2 == (curX+curY)%2);
        var canWalk=false;
        var distFromCurrentToIJ=0;
        if(diagonal){
            canWalk=oAStar.walkable[i,j] &&
                oAStar.walkable[curX,j] && 
                oAStar.walkable[i,curY];
            distFromCurrentToIJ=1.414;
        }else{
            canWalk=oAStar.walkable[i,j];
            distFromCurrentToIJ=1;
        }
        if(!closed && canWalk){
            //calculated G,H,and F
            var tempG=distFromStartToCurrent+distFromCurrentToIJ;
            var tempH=abs(i-endX)+abs(j-endY);//insert heuristic of choice (we use manhattan)
                //NOTE : you could also use point_distance(i,j,endX,endY);
            var tempF=tempG+tempH;
            //update if necessary
            var processed=ds_map_exists(G,getKey(i,j));
            if(processed){
                //var oldG=;
                //show_debug_message(string(tempG)+" compare to "+string(oldG));
                var lowerG=(ds_map_find_value(G,getKey(i,j))>tempG);
                if(lowerG){
                    ds_map_replace(G,getKey(i,j),tempG);
                    ds_map_replace(H,getKey(i,j),tempH);
                    ds_priority_change_priority(F,getKey(i,j),tempF);
                    ds_map_replace(P,getKey(i,j),getKey(curX,curY));
                    if(debug)
                        show_debug_message("Updating ("+string(i)+","+string(j)+") G:"+
                            string(tempG)+" H:"+string(tempH)+" F:"+string(tempF));   
                }
            }else{
                ds_map_add(G,getKey(i,j),tempG);
                ds_map_add(H,getKey(i,j),tempH);
                ds_priority_add(F,getKey(i,j),tempF);
                ds_map_add(P,getKey(i,j),getKey(curX,curY));
                if(debug)
                        show_debug_message("Adding ("+string(i)+","+string(j)+")     G:"+
                            string(tempG)+"     H:"+string(tempH)+"     F:"+string(tempF)); 
            }
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
    if(debug) show_debug_message("Trying ("+string(getKeyX(minF))+
        ","+string(getKeyY(minF))+")");
    curX=getKeyX(minF);
    curY=getKeyY(minF);
}
//check whether we're at the end
if(curX==endX && curY==endY){
    searching=false;
    found=true;
    if(debug)show_debug_message("You found me :D,"+
        " I'm the final block");
}
