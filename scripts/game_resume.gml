/*
call this script to resume the game.

Usage:
game_resume()

*/

if(!paused) then exit;

//Free the background from memory:
if background_exists(pause_BG) then background_delete(pause_BG);
pause_surface = -1;

//Activate all instances:
instance_activate_all();

paused = false;
