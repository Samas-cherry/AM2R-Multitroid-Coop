if (x < view_xview[0] - (oControl.widescreen_space / 2) - argument0 
 || x > view_xview[0] + 320 + (oControl.widescreen_space / 2) + argument0 
 || y < view_yview[0] - argument0 
 || y > view_yview[0] + 240 + argument0)
{
    active = 0;
    
    // In co-op multiplayer, keep enemies awake if there are other players in the room!
    if (instance_exists(oClient))
    {
        if (oClient.connected && ds_list_size(oClient.roomList) > 0)
            active = 1;
    }
}
else
{
    active = 1;
}
