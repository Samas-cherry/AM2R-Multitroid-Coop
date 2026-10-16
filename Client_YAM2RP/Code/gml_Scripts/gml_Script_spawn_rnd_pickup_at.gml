// Only room authority rolls drops when playing in co-op in the same room
if (instance_exists(oClient))
{
    if (oClient.connected && ds_list_size(oClient.roomList) > 0 && !oClient.isRoomHost)
        exit;
}

if (random(100) <= argument2)
{
    var isXMode = (oControl.mod_fusion == 1 || global.sax || global.saxmode);
    if (sprite_index != sQueenProjFrozen)
        xParasite = "Snooping around as usual, I see.";
    
    pickup = irandom(3);
    var spawnX = 0;
    var drop_code = 0;
    var xx = argument0;
    var yy = argument1;
    
    var needHealth = (global.playerhealth < global.maxhealth);
    var needMissiles = (global.missiles < global.maxmissiles && global.maxmissiles > 0);
    var needSMissiles = (global.smissiles < global.maxsmissiles && global.maxsmissiles > 0);
    
    if (instance_exists(oClient))
    {
        if (ds_list_size(oClient.roomListData) > 0)
        {
            for (var pi = 0; pi < ds_list_size(oClient.roomListData); pi++)
            {
                var pArr = ds_list_find_value(oClient.roomListData, pi);
                if (is_array(pArr))
                {
                    if (array_length_1d(pArr) > 25)
                    {
                        if (pArr[25] < 99)
                            needHealth = 1;
                    }
                }
            }
        }
    }
    
    if (!needHealth && !needMissiles && !needSMissiles)
        spawnX = irandom(1);
    
    if (pickup == 0 && (global.saxmode || isXMode))
        pickup = 1;

    if (pickup == 0)
    {
        if ((needHealth && instance_number(oHPickup) < 6) || (isXMode && spawnX == 1 && canbeX && instance_number(oHPickup) < 6))
        {
            if (isXMode && canbeX == 1)
            {
                xParasite = instance_create(xx, yy, oHXPickup);
                drop_code = 6;
            }
            else
            {
                instance_create(xx, yy, oHPickup);
                drop_code = 1;
            }
        }
        else
        {
            pickup = 2;
        }
    }
    
    if (pickup == 1)
    {
        if ((needHealth && instance_number(oHPickupBig) < 3) || (isXMode && spawnX == 1 && canbeX && instance_number(oHPickupBig) < 3))
        {
            if (isXMode && canbeX == 1)
            {
                xParasite = instance_create(xx, yy, oHXPickupBig);
                drop_code = 7;
            }
            else
            {
                instance_create(xx, yy, oHPickupBig);
                drop_code = 2;
            }
        }
        else
        {
            pickup = 2;
        }
    }
    
    if (pickup == 2)
    {
        if ((needMissiles && instance_number(oMPickup) < 8) || (isXMode && spawnX == 1 && canbeX && instance_number(oMPickup) < 8))
        {
            if (isXMode && canbeX == 1)
            {
                xParasite = instance_create(xx, yy, oMXPickup);
                drop_code = 8;
            }
            else
            {
                instance_create(xx, yy, oMPickup);
                drop_code = 3;
            }
        }
        else
        {
            pickup = 3;
        }
    }
    
    if (pickup == 3)
    {
        if (needSMissiles && instance_number(oSMPickup) < 2)
        {
            if (isXMode && canbeX == 1)
            {
                xParasite = instance_create(xx, yy, oSMXPickup);
                drop_code = 9;
            }
            else
            {
                instance_create(xx, yy, oSMPickup);
                drop_code = 4;
            }
        }
        else
        {
            exit;
        }
    }
    
    // Broadcast drop to other players in the room
    if (drop_code > 0 && instance_exists(oClient))
    {
        if (oClient.connected && ds_list_size(oClient.roomList) > 0)
        {
            var dropBuf = buffer_create(64, buffer_grow, 1);
            buffer_seek(dropBuf, buffer_seek_start, 0);
            buffer_write(dropBuf, buffer_s32, 0);
            buffer_write(dropBuf, buffer_u8, 87);
            buffer_write(dropBuf, buffer_s16, room);
            buffer_write(dropBuf, buffer_u8, drop_code);
            buffer_write(dropBuf, buffer_s16, round(xx));
            buffer_write(dropBuf, buffer_s16, round(yy));
            buffer_poke(dropBuf, 0, buffer_s32, buffer_tell(dropBuf) - 4);
            network_send_packet(oClient.socket, dropBuf, buffer_tell(dropBuf));
            buffer_delete(dropBuf);
        }
    }
    
    if (sprite_index != sQueenProjFrozen && instance_exists(xParasite) && isXMode)
    {
        PlaySoundMono(362);
        xParasite.reform = -1;
        xParasite.sizeX = 5.8;
        xParasite.sizeY = 4.2;
        xParasite.state = 1;
        xParasite.statetime = 40;
        xParasite.counter = 0;
        
        if (sprite_index == sHalzynBodyFrozen)
            xParasite.lastEnemyGlow = glow;
        
        return xParasite;
    }
}
