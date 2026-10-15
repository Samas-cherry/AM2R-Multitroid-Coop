var num_players = 1;
if (instance_exists(oClient))
{
    if (oClient.connected)
        num_players = max(1, ds_list_size(global.idList));
}

// User Decision 3D Formulas:
// Regular Enemies: +20% HP per player in server above 1 player (1P=1.0, 2P=1.2, 3P=1.4, 4P=1.6)
// Bosses: +40% HP per player in server above 1 player (1P=1.0, 2P=1.4, 3P=1.8, 4P=2.2)
global.coop_enemy_mult = 1.0 + (num_players - 1) * 0.20;
global.coop_boss_mult = 1.0 + (num_players - 1) * 0.40;

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
