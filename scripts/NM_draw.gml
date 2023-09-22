///NM_draw(x,y)

shader_set(shdr_normal);
texture_set_stage(uspec,surface_get_texture(NMspec))
texture_set_stage(unorm,surface_get_texture(NMnorm))
shader_set_uniform_f(uamb,colour_get_red(NMamb)/255,colour_get_green(NMamb)/255,colour_get_blue(NMamb)/255)

shader_set_uniform_f_array(ulights,NMlights);

draw_surface(NMdif,argument0,argument1)
shader_reset()

//draw_surface(NMnorm,argument0,argument1)
surface_set_target(NMdif)
draw_clear_alpha(0,0)
surface_reset_target()
surface_set_target(NMnorm)
draw_clear_alpha(0,0)
surface_reset_target()
surface_set_target(NMspec)
draw_clear_alpha(0,0)
surface_reset_target()

setup = 1;
