event_inherited();
global.SuitChange = 1;
if (collision_line(x + 8, y - 8, x + 8, y - 32, 268, 0, 1))
    global.SuitChange = 0;
if (!collision_point(x + 8, y + 8, 268, 0, 1))
    global.SuitChange = 0;
if (global.saxmode)
    global.SuitChange = 0;
global.SuitChangeX = x;
global.SuitChangeY = y;
global.SuitChangeGravity = 0;
if (active)
{
    with (oCharacter)
        alarm[1] = 1;
    global.icemissiles = 1;
    if (instance_exists(oClient) && oClient.connected)
    {
        popup_text("Varia suit and Ice Missiles " + get_text("GlobalOptions", "Enabled"));
        with (oClient)
            event_user(8);
    }
}
