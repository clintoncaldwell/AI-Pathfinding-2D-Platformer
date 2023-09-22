/// This script is not funtional; Only for logging purposes

/*
Depth Hierarchy
    
    oLight
    All Actors

*/



/*

• Platforming
--------------------------------------------------
- JUMP connections for walkways so I can jump from walkway to ledge
    - Allow all nodetypes to go into jump script, but stop it if the
        node's type is walkway and targetNode is not a ledge
            - This will stop walkways from connecting to other walkways
            so player will not jump to a walkway node two blocks away
            when they can walk there

- Adding a pause for the actor after a jump and runoff. 
- Solving complex jump arcs that say they are do-able in simulation but not actually possible
    - in jump connections, have each jump arc point take note of their surrounding blocks and assess if jump arc is possible?
        - for example, if there's a solid to my left and I'm mid-arc, how do I tell the simulation 
            its not possible and abandon the idea before the connection is available to the actor
- Polishing up movement
    - Movement of a.i should be similar to player, so way too smooth arcs won't work if the player cant do them to

    
    
    
    
• Battle
--------------------------------------------------
moving circular sp skill gauge when attacking
    that the player can hold onto to store more power. Level 1, 2, 3, etc in return for SP

    
    
    
    
• Aesthetics
--------------------------------------------------

In spriteIlluminator, the best global light option for simple sprites is:
    Z Position: 0
    Brightness: 152%

A z position of 0 means that the light will not affect the shadows. 
    Only light will be added to the currently lit area
This is good for simple sprites since it stops them from getting muddy and too complicated.

The ambient light mixes it's color with the sprite's color to give an 
    interesting color for the shadows(anything not currently lit)


    
    
    
    
*/
