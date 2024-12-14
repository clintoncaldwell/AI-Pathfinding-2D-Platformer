# AI-Pathfinding-2D-Platformer
In this project, I developed an AI pathfinding system for a 2D platformer game using the A* Search Algorithm. The main challenge was creating a flexible system that could accommodate various unit types and their characteristics, including differing sizes, jump heights, and other environmental factors.
Key features of the system include:
- Real-Time Path Calculation: The algorithm calculates the best route to a target in real-time, navigating a network of connected nodes. It accounts for dynamic factors like terrain, gravity, and player size to ensure the most efficient path is chosen.

- Handling Dynamic Variables: The pathfinding system adjusts based on various factors, such as jump height and gravity, allowing for reliable movement even in complex, changing environments.

- Optimized Decision-Making: Using the A* Search Algorithm, the AI can make quick, efficient decisions about movement, even with obstacles and constantly changing conditions.

<br>This project was programmed in GameMaker Studio using GameMaker Language (GML). 
<br>In addition to the pathfinding system, this project includes a lighting script I developed using shaders in GLSL, which allows characters and objects to dynamically react to lights placed within the scene.
<br>
## Demo
The user clicks a location above a ground block, and if the path is traversable, the AI-controlled player automatically follows the most efficient route. The path can be redirected at any time, whether en route or mid-jump, and the player will immediately adjust course.<br>
<div align="center">
  <video src="https://github.com/user-attachments/assets/6d01ab15-9d09-41ca-adf5-6c54a357af93" />
</div>


## Early System Builds: Node Network Visualization
In the initial builds, the primary goal was to have the script dynamically identify nodes that could be traversed through walking, falling, or jumping, in various environments with different terrain layouts. The node network is clearly displayed, with each node showing the number of direct connections (reachable in one action). These connections are numbered above each node for clarity. Additionally, each node lists the IDs of its non-adjacent connected nodes.
<br><br>
Jump paths are highlighted in mid-air with magenta circles, fixed to the grid pattern of the level. Jumping is considered a higher cost action than falling off a ledge in the algorithm, so when both actions are available to reach a node, falling off the ledge is prioritized.
<br>
### Node Types:
- Green Nodes – No adjacent nodes
- Blue Nodes – 1 adjacent node (left or right)
- Red Nodes – 2 adjacent nodes (left and right)

### Connection Types:
- Purple Lines – Walking paths for adjacent nodes
- Yellow Lines – Ledge fall-offs, where the player can drop down to the next node
- Blue Lines – Jumping paths between nodes
<br><br>
This section provides a detailed look at the early stages of the system’s development, focusing on how the pathfinding algorithm recognizes and visualizes traversable paths across the environment.
<br><br>
![image](https://github.com/anEnemyStand/Platformer-Pathfinding/assets/16449117/315a286d-bc5e-48a3-91f1-a118ef0daba4)

![image](https://github.com/anEnemyStand/Platformer-Pathfinding/assets/16449117/68a194c7-f7fe-49f7-9931-b5befb022354)

![image](https://github.com/anEnemyStand/Platformer-Pathfinding/assets/16449117/f5ff8371-1bf7-473a-beb0-0b63d7b574ec)
<br>
## Screenshots

![image](https://github.com/anEnemyStand/Platformer-Pathfinding/assets/16449117/e9e87e04-3986-4f43-8b2e-4ac00065ab11)

![image](https://github.com/anEnemyStand/Platformer-Pathfinding/assets/16449117/46c9bdbb-3974-4a5e-8893-553733dad147)

![image](https://github.com/anEnemyStand/Platformer-Pathfinding/assets/16449117/9c20ad66-2417-4386-8133-569d9981ab20)

### Controls:
- Left Alt: Toggle Debug Mode
- R: Restart Game
- Esc: Exit Game
- Space: Pause
- +/=: Zoom In
- -: Zoom Out
- Y: Switch Player
- Right Click: Place Player
- Left Click: Set Destination
