///NM_wiggle(light id,range,radius,time)
var i,r,R,t;
i = argument0;
r = argument1;
R = argument2;
t = argument3;
NMlights[i*3+2] = r+dcos(t)*R;
