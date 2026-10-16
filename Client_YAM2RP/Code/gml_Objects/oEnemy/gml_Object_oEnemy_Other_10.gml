if (object_index != oBoss1Head && coop_scaled == 0)
{
    coop_scaled = 1;
    update_variables("coop_scaling");
    if (global.coop_enemy_mult > 1.0)
    {
        myhealth = ceil(myhealth * global.coop_enemy_mult);
        if (freezehp > 0)
            freezehp = ceil(freezehp * global.coop_enemy_mult);
    }
}

dmg = other.damage;

if (other.object_index == oMissile || other.object_index == oMissileExpl)
{
    if (global.icemissiles && !other.smissile)
    {
        if (canfreeze)
            frozen = 240;
    }
}

if (global.difficulty == 2)
    dmg = ceil(dmg / 2);

if (justfrozen == 0)
    myhealth -= dmg;

if (myhealth <= 0)
{
    if (justfrozen == 0 && state != 100)
    {
        state = 100;
        statetime = 0;
        global.kills += 1;
    }
}
stun = stuntime;
if (other.ibeam)
{
    if (frozen == 0 && canfreeze && myhealth < freezehp)
        event_user(15);
}
if (canflash)
{
    flashing = 5;
    fxtimer = 0;
}
if (frozen)
{
    if (myhealth > 0)
        PlaySoundMono(82);
    else
        PlaySoundMono(hitsound);
}
else
    PlaySoundMono(hitsound);
