var isXMode;
var xx;
var yy;
var spawnX;
var drop_code;
var needHealth;
var needMissiles;
var needSMissiles;
var needPBombs;
var p_i;
var pArr;
var dropBuf;

// Only room authority rolls drops when playing in co-op in the same room
if (instance_exists(oClient))
{
    if (oClient.connected && ds_list_size(oClient.roomList) > 0 && !oClient.isRoomHost)
        exit;
}

if (random(100) < argument0)
{
    isXMode = (oControl.mod_fusion == 1 || global.sax || global.saxmode);
    if (global.saxmode)
        canbeX = 1;

    if (canbeX == 1)
        xParasite = "What, you expected something useful?";
    
    xx = mean(bbox_left, bbox_right);
    yy = mean(bbox_top, bbox_bottom);
    pickup = irandom(3);
    spawnX = 0;
    drop_code = 0;
    
    needHealth = (global.playerhealth < global.maxhealth);
    needMissiles = (global.missiles < global.maxmissiles && global.maxmissiles > 0);
    needSMissiles = (global.smissiles < global.maxsmissiles && global.maxsmissiles > 0);
    needPBombs = (global.pbombs < global.maxpbombs && global.maxpbombs > 0);
    
    if (instance_exists(oClient))
    {
        if (ds_list_size(oClient.roomListData) > 0)
        {
            for (p_i = 0; p_i < ds_list_size(oClient.roomListData); p_i += 1)
            {
                pArr = ds_list_find_value(oClient.roomListData, p_i);
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
    
    if ((global.item[0] == 0 && global.maxpbombs > 0) || oControl.mod_insanitymode == 1)
        pickup = irandom(4);
    
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
        else if ((global.item[0] == 0 && global.maxpbombs > 0) || oControl.mod_insanitymode == 1)
        {
            pickup = 4;
        }
    }
    
    if (pickup == 4)
    {
        if (needPBombs && instance_number(oPBPickup) < 2)
        {
            if (isXMode && canbeX == 1)
            {
                xParasite = instance_create(xx, yy, oPBXPickup);
                drop_code = 10;
            }
            else
            {
                instance_create(xx, yy, oPBPickup);
                drop_code = 5;
            }
        }
    }
    
    if (canbeX == 1 && instance_exists(xParasite) && isXMode)
    {
        if (object_index == oEnemyFrozen)
        {
            xParasite.lastSprite = xSprite;
            xParasite.lastFrame = xLastFrame;
            xParasite.lastFacing = xLastFacing;
            xParasite.lastAngle = xLastAngle;
            xParasite.lastDepth = xLastDepth;
            xParasite.lastXPos = xLastXPos;
            xParasite.lastYPos = xLastYPos;
            xParasite.lastEnemy = xLastEnemy;
            xParasite.frozenAngle = image_angle;
        }
        else
        {
            xParasite.lastSprite = sprite_index;
            xParasite.lastFrame = image_index;
            xParasite.lastFacing = image_xscale;
            xParasite.lastAngle = image_angle;
            xParasite.lastDepth = depth;
            xParasite.lastXPos = xstart;
            xParasite.lastYPos = ystart;
            xParasite.lastEnemy = object_index;
        }
        
        xParasite.lastEnemyX = x;
        xParasite.lastEnemyY = y;
        xParasite.lastYscale = image_yscale;
        xParasite.lastEnemyTimer = timer;
        xParasite.lastEnemyRotspeed = rotspeed;
        xParasite.lastEnemyMyspeed = myspeed;
        xParasite.lastEnemyOffset = offset;
        xParasite.lastEnemyMoveratio = moveratio;
        xParasite.lastEnemyMovesteps = movesteps;
        
        if (object_index == oHalzyn)
            xParasite.lastEnemyGlow = glow;
        
        if (sprite_index == sHalzynBodyFrozen)
            xParasite.lastEnemyGlow = xLastGlow;
    }
    
    // Broadcast drop to other players in the room
    if (drop_code > 0 && instance_exists(oClient))
    {
        if (oClient.connected && ds_list_size(oClient.roomList) > 0)
        {
            dropBuf = buffer_create(64, buffer_grow, 1);
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
}
