if (global.spectator || global.multiDamageCollision)
{
    global.multiDamageCollision = 0;
    exit;
}

var serverdamageMult = global.damageMult;

if (global.multiDamageCollision)
{
    if (instance_exists(oCharacter))
        oCharacter.fillhp = 0;
    
    var metcount = 0;
    
    for (var i = 0; i <= 40; i++)
    {
        if (global.metdead[i] == 1)
            metcount += 1;
    }
    
    if (global.sax)
    {
        global.damageMult = 1 + (1.5 * (metcount / global.MetCount));
        
        if (global.damageMult > 2.5)
            global.damageMult = 2.5;
        
        if (global.currentsuit == 2 && global.juggActive)
            global.ignoreKnockback = 1;
    }
}

var experimentalExtraSAXDamageMultiplier = 1;
var damage_taken = 0;

if (global.currentsuit == 0 || argument3 == 1)
{
    if (!global.multiDamageCollision)
    {
        damage_taken = argument0 * oControl.mod_diffmult;
    }
    else
    {
        damage_taken = argument0 * experimentalExtraSAXDamageMultiplier * oControl.mod_diffmult;
        damage_taken = damage_taken + (damage_taken * global.damageMult);
    }
}

if (argument3 == 0)
{
    if (global.currentsuit == 1)
    {
        if (!global.multiDamageCollision)
        {
            damage_taken = ceil(argument0 * 0.5) * oControl.mod_diffmult;
        }
        else
        {
            damage_taken = ceil(argument0 * 0.75) * experimentalExtraSAXDamageMultiplier * oControl.mod_diffmult;
            damage_taken = damage_taken + (damage_taken * global.damageMult);
        }
    }
    
    if (global.currentsuit == 2)
    {
        if (!global.multiDamageCollision)
        {
            if (global.item[5] == 0)
                damage_taken = ceil(argument0 * 0.5) * oControl.mod_diffmult;
            else
                damage_taken = ceil(argument0 * 0.25) * oControl.mod_diffmult;
        }
        else if (global.item[5] == 0)
        {
            damage_taken = ceil(argument0 * 0.75) * experimentalExtraSAXDamageMultiplier * oControl.mod_diffmult;
            damage_taken = damage_taken + (damage_taken * global.damageMult);
        }
        else
        {
            damage_taken = ceil(argument0 * 0.6) * experimentalExtraSAXDamageMultiplier * oControl.mod_diffmult;
            damage_taken = damage_taken + (damage_taken * global.damageMult);
        }
    }
}

var bossDamageMult = 1.0;
if (variable_global_exists("coop_boss_damage_mult"))
    bossDamageMult = global.coop_boss_damage_mult;

if (bossDamageMult < 1.0)
{
    var isBossAttacker = 0;
    if (instance_exists(other))
    {
        var atObj = other.object_index;
        if (atObj == oBoss1Head || atObj == oArachnus || atObj == oArachnusFireball1 || atObj == oArachnusFBExpl || atObj == oArachnusFireball2 || atObj == oArachnusFireball3 || atObj == oArachnusClawProj || atObj == oArachnusSpikes || atObj == oTorizo || atObj == oTorizo2 || atObj == oTorizoFireball || atObj == oTorizoSlashProj || atObj == oTorizoBottom || atObj == oTorizoSpikes || atObj == oTorizoGhost || atObj == oTesterGlass || atObj == oTesterIceSpark || atObj == oTesterMissileExpl || atObj == oTesterPlasmaBeam || atObj == oTesterSpazerBeam || atObj == oTesterWaveBeam || atObj == oTesterShield || atObj == oTank || atObj == oTankHead || atObj == oTankProjectile || atObj == oTankCannon || atObj == oTankBottom || atObj == oTankCore || atObj == oEris || atObj == oErisBody1 || atObj == oErisHead || atObj == oErisSegment || atObj == oErisProjectile || atObj == oGenesis || atObj == oGenesisAcid || atObj == oGenesisSlashProj || atObj == oQueen || atObj == oQueenHead || atObj == oQueenLegFront || atObj == oQueenHeadTop || atObj == oQueenFireball || atObj == oCoreXShell || atObj == oBoss1Beam || atObj == oBoss1FBall || atObj == oBoss1FBExplR || atObj == oBoss1FBExplL || atObj == oBoss1FBall2 || atObj == oBoss1FBExpl2 || atObj == oBoss1FBall3 || atObj == oMAlpha || atObj == oMGamma || atObj == oMZetaHead || atObj == oMZetaBodyMask || atObj == oMZetaSlashProj || atObj == oMZetaSlashProj2 || atObj == oMZetaProj || atObj == oMOmegaHead || atObj == oMOmegaMask || atObj == oMOmegaGroundHit || atObj == oMOmegaFlame || atObj == oMOmegaMask2 || atObj == oMOmegaMask4 || atObj == oMOmega_Projectile)
            isBossAttacker = 1;
    }
    if (isBossAttacker)
        damage_taken = ceil(damage_taken * bossDamageMult);
}

if (global.playerhealth > 0)
{
    with (oCharacter)
    {
        var currState = state;
        
        if (((state != HURT && invincible == 0) || (argument4 == 1 && statetime > 2)) && !global.ignoreKnockback)
        {
            if (canbehit && state != IDLE && state != SAVING && state != SAVINGFX && state != SAVINGSHIPFX && state != SAVINGSHIP && state != ELEVATOR && state != GFELEVATOR)
            {
                if (state == BALL || state == AIRBALL || state == SPIDERBALL || sjball == 1)
                {
                    multiBall = 1;
                    fixedx = 12;
                    sball = 0;
                }
                else
                {
                    sjball = 0;
                }
                
                if (state == WATERJET)
                {
                    state = AIRBALL;
                    statetime = 0;
                }
                
                if (global.multiDamageCollision)
                {
                    if (otherOBJ != 439)
                        state = HURT;
                    else
                        fixedx = 0;
                }
                else
                {
                    state = HURT;
                }
                
                statetime = 0;
                canturn = 0;
                image_index = 0;
                
                if (other.x >= x)
                    xVel = -argument1;
                
                if (other.x < x)
                    xVel = argument1;
                
                yVel = argument2;
                sfx_play(1);
                ctrl_vibrate(0.5, 0.5, 10);
                invincible = 60;
                
                if (global.playerFreeze > 0)
                {
                    invincible = 45;
                    
                    if (state == BALL || state == AIRBALL || state == SPIDERBALL)
                        fixedx = 0;
                }
                
                if (global.playerFreeze == 156)
                {
                    state = currState;
                    invincible = 0;
                    
                    if (state == BALL || state == AIRBALL || state == SPIDERBALL)
                        fixedx = 0;
                }
                
                if (inwater)
                {
                    repeat (3 + floor(random(3)))
                    {
                        bubble = instance_create(x, y - 6 - random(20), oLBubble);
                        
                        if (instance_exists(bubble))
                        {
                            bubble.hspeed = 1 - random(2);
                            bubble.vspeed = -0.1 - random(1);
                        }
                    }
                }

                if (global.multiDamageCollision)
                {
                    with (oClient)
                    {
                        var buffer = buffer_create(1024, buffer_grow, 1);
                        buffer_seek(buffer, buffer_seek_start, 0);
                        buffer_write(buffer, buffer_s32, 4);
                        buffer_write(buffer, buffer_u8, 69);
                        buffer_write(buffer, buffer_u8, global.clientID);
                        buffer_write(buffer, buffer_u16, damage_taken);
                        buffer_poke(buffer, 0, buffer_s32, buffer_tell(buffer) - 4);
                        network_send_packet(socket, buffer, buffer_tell(buffer));
                        buffer_delete(buffer);
                    }
                }

                global.playerhealth -= damage_taken;
            }
        }
        
        if (global.playerhealth <= 0 && state != DEFEATED)
        {
            alarm[0] = 6;
            state = DEFEATED;
        }
    }
}

with (oCharacter)
{
    if (global.ignoreKnockback && invincible == 0)
    {
        invincible = 60;
        
        if (global.playerFreeze > 0)
        {
            invincible = 45;
            
            if (state == BALL || state == AIRBALL || state == SPIDERBALL)
                fixedx = 0;
        }
        
        if (global.playerFreeze == 156)
        {
            invincible = 0;
            
            if (state == BALL || state == AIRBALL || state == SPIDERBALL)
                fixedx = 0;
        }

        if (global.multiDamageCollision)
        {
            with (oClient)
            {
                var buffer = buffer_create(1024, buffer_grow, 1);
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_s32, 4);
                buffer_write(buffer, buffer_u8, 69);
                buffer_write(buffer, buffer_u8, global.clientID);
                buffer_write(buffer, buffer_u16, damage_taken);
                buffer_poke(buffer, 0, buffer_s32, buffer_tell(buffer) - 4);
                network_send_packet(socket, buffer, buffer_tell(buffer));
                buffer_delete(buffer);
            }
        }

        global.playerhealth -= damage_taken;
        
        if (global.playerhealth <= 0 && state != DEFEATED)
        {
            alarm[0] = 6;
            state = DEFEATED;
        }
    }
}

global.multiDamageCollision = 0;
global.ignoreKnockback = 0;
global.hitBySuper = 0;
global.damageMult = serverdamageMult;

if (instance_exists(oA2WaterJetMachine))
{
    with (oA2WaterJetMachine)
        state = 0;
}
