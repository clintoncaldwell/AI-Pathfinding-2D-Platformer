///smoothstep(start, destination) {

var start = argument0;
var destination = argument1;
var temp;

// Scale, bias and saturate temp to 0..1 range
temp = clamp((temp - start) / (destination - start), 0.0, 1.0); 
// Evaluate polynomial
zoomPercent =  temp * temp * (3 - 2 * temp);

