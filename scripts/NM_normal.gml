///NM_normal(add,rotation)
if argument0
{
    shader_set(shdr_rotate)
    shader_set_uniform_f(oLight.uangle,-argument1)
    surface_set_target(oLight.NMnorm)
}
else
{
    shader_reset()
    surface_reset_target()
}
