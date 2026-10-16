instance_activate_region(x - 64, y - 64, 128, 128, 1);

if (coop_scaled == 0)
{
    coop_scaled = 1;
    update_variables("coop_scaling");
    if (global.coop_boss_mult > 1.0)
    {
        myhealth = ceil(myhealth * global.coop_boss_mult);
        starthealth = myhealth;
    }
}
