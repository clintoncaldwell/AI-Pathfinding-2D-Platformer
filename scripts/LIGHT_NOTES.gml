/*
Needed components:
- Actor essentials: Sprite Sheet || Normal Map || Specular Map
    - These three components can be separated into their own sprites. 
            Each Actor will have a folder with these 3.
    - Sprite sheets for each Actor
    - Specular Map will provide added light to areas that need it like a shiny sword
    - Normal Maps must have their green channels inverted before being added to project
        - Shaders read top and bottom lit areas in reverse, and the green channel 
            inverted, switches them
GOTTA MAKE SURE LIGHT DOESNT GO THROUGH AREAS THAT MAKE NO SENSE. LIGHT GOTTA REACT TO ENVIRONMENT
            
- Ambient Light - Adjustable at any time
    - mixes with local colors to make objects & environment blend together
    - Will not be a light but an overlay for the screen. The ambient light will be the shadow
- Direct Light - Type, X pos, Y pos, X scale, Y scale, rotation, Affecting Radius/Strength, Color, 
    - Must be simple and easy to plug in for easy readability later on.
    - Xscale and yScale are the visible lengths of the light 
            while radius/strength is the distance and power it has.
    - Spotlight ( Flashlight, Window Light
        Concentrated Light moving in a general directionMoves
    - Directional Light( Sun, Moon ) - way too big light sources that are uniform throughout the stage
        
    Idea: Have the light be completely modular so when a skill is executed, it is done with ease.
    Idea: Maybe have light take the shape of whatever is emitting it. And make the strength
        of the light dependent on the size of the swiping sprite. A sword swipe would 
    - Have a configurabe & movable light source in game to test things out
        - Configurable colors, size, scale, etc, everything listed above.
    - Don't go get too crazy with the amount of lights on screen.
-  






