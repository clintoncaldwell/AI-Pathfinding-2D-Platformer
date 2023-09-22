/*
Observed TurnOrder Issues
a & b start battle with same wt, so randomly, b is decremented.
a = 50 wt;   b = 49.99 wt
throughout the battle, a matches wt with c and a is decremented.
But since b is already decremented once a goes down from 50 to 49.99, it will have to decrement once again.
b = 49.99 wt;   a = 49.98 wt
This causes changes to the TurnOrder list because a & b decided to switch places in heirarchy.





*/
