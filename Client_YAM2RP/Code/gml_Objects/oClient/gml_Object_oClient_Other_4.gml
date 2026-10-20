if (room == 4)
{
    buffer_delete(buffer);
    var size = 1024;
    var type = 1;
    var alignment = 1;
    buffer = buffer_create(size, type, alignment);
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_u8, 19);
    buffer_write(buffer, buffer_s32, global.gametime);
    buffer_write(buffer, buffer_u8, global.clientID);
    var bufferSize = buffer_tell(buffer);
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_s32, bufferSize);
    buffer_write(buffer, buffer_u8, 19);
    buffer_write(buffer, buffer_s32, global.gametime);
    buffer_write(buffer, buffer_u8, global.clientID);
    var result = network_send_packet(socket, buffer, buffer_tell(buffer));
}

if (room == 20)
    resetTimer = 5;

global.objdeactivate = 0;
instance_activate_all();

// Co-Op Difficulty Rebalance
var num_players = 1;
if (instance_exists(oClient))
{
    if (oClient.connected)
        num_players = max(1, ds_list_size(global.idList));
}

global.coop_enemy_mult = 1.0 + (num_players - 1) * 0.20;
global.coop_boss_mult = 1.0 + (num_players - 1) * 0.40;

var is_sax = global.saxmode;

if (is_sax && num_players > 1)
    global.coop_boss_damage_mult = max(0.35, 1.0 - (num_players - 1) * 0.13);
else
    global.coop_boss_damage_mult = 1.0;

if (global.base_mod_initialized == 1)
{
    global.mod_zetahealth = ceil(global.base_mod_zetahealth * global.coop_boss_mult);
    global.mod_omegahealth = ceil(global.base_mod_omegahealth * global.coop_boss_mult);
    global.mod_boss1Health = ceil(global.base_mod_boss1Health * global.coop_boss_mult);
    global.mod_torizohealthform1 = ceil(global.base_mod_torizohealthform1 * global.coop_boss_mult);
    global.mod_torizohealthform2 = ceil(global.base_mod_torizohealthform2 * global.coop_boss_mult);
    global.mod_torizohealthform1hard = ceil(global.base_mod_torizohealthform1hard * global.coop_boss_mult);
    global.mod_torizohealthform2hard = ceil(global.base_mod_torizohealthform2hard * global.coop_boss_mult);
    global.mod_testerHcannon = ceil(global.base_mod_testerHcannon * global.coop_boss_mult);
    global.mod_testerHeye = ceil(global.base_mod_testerHeye * global.coop_boss_mult);
    global.mod_testerHglass = ceil(global.base_mod_testerHglass * global.coop_boss_mult);
    global.mod_testerHshield = ceil(global.base_mod_testerHshield * global.coop_boss_mult);
    global.mod_tankHbottom = ceil(global.base_mod_tankHbottom * global.coop_boss_mult);
    global.mod_tankHcannon = ceil(global.base_mod_tankHcannon * global.coop_boss_mult);
    global.mod_tankHcore = ceil(global.base_mod_tankHcore * global.coop_boss_mult);
    global.mod_tankHhead = ceil(global.base_mod_tankHhead * global.coop_boss_mult);
    global.mod_tankHshield = ceil(global.base_mod_tankHshield * global.coop_boss_mult);
    global.mod_serrisHealth = ceil(global.base_mod_serrisHealth * global.coop_boss_mult);
    global.mod_serrisHbody = ceil(global.base_mod_serrisHbody * global.coop_boss_mult);
    global.mod_genesisHealth = ceil(global.base_mod_genesisHealth * global.coop_boss_mult);
    global.mod_queenHstart = ceil(global.base_mod_queenHstart * global.coop_boss_mult);
    global.mod_queenHcorridors = ceil(global.base_mod_queenHcorridors * global.coop_boss_mult);
    global.mod_queenHbigroom = ceil(global.base_mod_queenHbigroom * global.coop_boss_mult);
    global.mod_queenHlast = ceil(global.base_mod_queenHlast * global.coop_boss_mult);
    global.mod_queenHprojectile = ceil(global.base_mod_queenHprojectile * global.coop_boss_mult);

    global.mod_coreArachnusHealthBlue = ceil(global.base_mod_coreArachnusHealthBlue * global.coop_boss_mult);
    global.mod_coreArachnusHealthYellow = ceil(global.base_mod_coreArachnusHealthYellow * global.coop_boss_mult);
    global.mod_coreArachnusHealthRed = ceil(global.base_mod_coreArachnusHealthRed * global.coop_boss_mult);
    global.mod_coreTorizoHealthBlue = ceil(global.base_mod_coreTorizoHealthBlue * global.coop_boss_mult);
    global.mod_coreTorizoHealthYellow = ceil(global.base_mod_coreTorizoHealthYellow * global.coop_boss_mult);
    global.mod_coreTorizoHealthRed = ceil(global.base_mod_coreTorizoHealthRed * global.coop_boss_mult);
    global.mod_coreGenesisHealthBlue = ceil(global.base_mod_coreGenesisHealthBlue * global.coop_boss_mult);
    global.mod_coreGenesisHealthYellow = ceil(global.base_mod_coreGenesisHealthYellow * global.coop_boss_mult);
    global.mod_coreGenesisHealthRed = ceil(global.base_mod_coreGenesisHealthRed * global.coop_boss_mult);
    global.mod_coreErisHealthBlue = ceil(global.base_mod_coreErisHealthBlue * global.coop_boss_mult);
    global.mod_coreErisHealthYellow = ceil(global.base_mod_coreErisHealthYellow * global.coop_boss_mult);
    global.mod_coreErisHealthRed = ceil(global.base_mod_coreErisHealthRed * global.coop_boss_mult);
}

if (global.coop_enemy_mult > 1.0)
{
    with (oEnemy)
    {
        coop_scaled = 0;
    }
    with (oEnemy)
    {
        if (object_index != oBoss1Head && coop_scaled == 0)
        {
            coop_scaled = 1;
            myhealth = ceil(myhealth * global.coop_enemy_mult);
            if (freezehp > 0)
                freezehp = ceil(freezehp * global.coop_enemy_mult);
        }
    }
}

with (oEnemy)
{
    sync_target_x = x;
    sync_target_y = y;
    sync_target_scale = image_xscale;
    sync_active = 0;
    sync_vx = 0;
    sync_vy = 0;
}
