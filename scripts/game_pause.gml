/* 
call this script to pause the game

Usage:
game_pause()

Tip:
Objects that have the parent "parent_dont_pause" will not be paused.
Remember that they will still appear on the pause background unless
you draw them in the draw GUI event.

Tip 2:
Do not change rooms while the game is paused, because then the old 
pause background may still exist in the game's memory.
You can simply use the game_resume() function before changing rooms.
You don't need to first check if the game is paused, because the
game_resume() funciton already does that on it's own.

*/

if(paused) then exit;

//This code block takes a screenshot of the game to use as the pause background:
if(application_surface_is_enabled()) {
    var w, h, tempsurf;
    w = surface_get_width(application_surface);
    h = surface_get_height(application_surface);
    
    //This is to prevent alpha distortions that sometimes occur when copying the application surface:
    tempsurf = surface_create(w,h);
    surface_set_target(tempsurf);
    draw_clear(c_black);
    draw_set_colour_write_enable(true,true,true,false);
    draw_enable_alphablend(false);
    draw_surface(application_surface,0,0);
    draw_set_colour_write_enable(true,true,true,true);
    draw_enable_alphablend(true);
    surface_reset_target();
    
    pause_BG = background_create_from_surface(tempsurf,0,0,w,h,false,false);
    surface_free(tempsurf);
} else {
    //If you have disabled the application surface, we will take a screenshot in another way. 
    //IMPORTANT: screen_save() does not work on HTML5, so HTML5 games need to have the application surface enabled.
    screen_save("pauseBG.png");
    pause_BG = background_add("pauseBG.png",0,0)
}



//Next, all instances are deactivated, except for any instance with the "parent_dont_pause" parent.
instance_deactivate_all(true);
instance_activate_object(parent_dont_pause);

paused = true;
