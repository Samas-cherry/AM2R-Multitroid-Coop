disconnectTimer = 900;

if (!global.acceptPacket)
    exit;

var type_event = ds_map_find_value(async_load, "type");
writelog("NET START: type_event=" + string(type_event));

switch (type_event)
{
    case 3:
        var _buffer = ds_map_find_value(async_load, "buffer");
        var bufferSize = buffer_get_size(_buffer);
        buffer_seek(_buffer, buffer_seek_start, 0);
        
        while (buffer_tell(_buffer) + 4 <= bufferSize)
        {
            var packetStart = buffer_tell(_buffer);
            var bufferSizePacket = buffer_read(_buffer, buffer_s32);
            
            if (!is_real(bufferSizePacket) || bufferSizePacket < 0)
                break;
            
            var packetEnd = packetStart + 4 + bufferSizePacket;
            if (packetEnd > bufferSize)
                break;
            
            msgid = buffer_read(_buffer, buffer_u8);
            writelog("NET PACKET: msgid=" + string(msgid));
            
            switch (msgid)
            {
            case 254:
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (ds_list_size(roomList) > 0)
                {
                    var findsocket = ds_list_find_index(roomList, clientID);
                    
                    if (findsocket >= 0)
                        ds_list_delete(roomList, findsocket);
                }
                
                for (var i = 0; i < ds_list_size(roomListData); i++)
                {
                    var arrList = ds_list_find_value(roomListData, i);
                    
                    if (is_array(arrList))
                    {
                        if (arrList[0] == clientID)
                            ds_list_delete(roomListData, i);
                    }
                }
                
                for (var f = 0; f < ds_list_size(global.idList); f++)
                {
                    var arrList = ds_list_find_value(global.idList, f);
                    
                    if (is_array(arrList))
                    {
                        if (clientID == arrList[0, 0])
                            ds_list_delete(global.idList, f);
                    }
                }
                var num_players = max(1, ds_list_size(global.idList));
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
                
                for (var v = 0; v < ds_list_size(posData); v++)
                {
                    var arrList = ds_list_find_value(posData, v);
                    
                    if (is_array(arrList))
                    {
                        if (clientID == arrList[0])
                            ds_list_delete(posData, v);
                    }
                }
                
                if (instance_exists(oHatchling))
                {
                    with (oHatchling)
                    {
                        if (myid != 0)
                            instance_destroy();
                    }
                }
                
                break;
            
            case 250:
                var ban = buffer_read(_buffer, buffer_u8);
                kickReason = buffer_read(_buffer, buffer_u8);
                
                if (ban)
                    banned = 1;
                else
                    kicked = 1;
                
                instance_destroy();
                break;
            
            case 200:
                preferredcolor = buffer_read(_buffer, buffer_u8);
                break;
            
            case 100:
                var clientID = buffer_read(_buffer, buffer_u8);
                var clientX = buffer_read(_buffer, buffer_s16);
                var clientY = buffer_read(_buffer, buffer_s16);
                var clientSprite = buffer_read(_buffer, buffer_s16);
                var clientImage = buffer_read(_buffer, buffer_s16);
                var clientA1 = buffer_read(_buffer, buffer_s16);
                var clientA1X = buffer_read(_buffer, buffer_s16);
                var clientA1Y = buffer_read(_buffer, buffer_s16);
                var clientA2 = buffer_read(_buffer, buffer_s16);
                var clientA2X = buffer_read(_buffer, buffer_s16);
                var clientA2Y = buffer_read(_buffer, buffer_s16);
                var clientA2A = buffer_read(_buffer, buffer_s16);
                var clientMirror = buffer_read(_buffer, buffer_s16);
                var clientArmmsl = buffer_read(_buffer, buffer_s16);
                var clientRoom = buffer_read(_buffer, buffer_s16);
                var clientName = buffer_read(_buffer, buffer_string);
                var clientBlend = buffer_read(_buffer, buffer_s16);
                var clientFXTimer = buffer_read(_buffer, buffer_s8);
                var clientRoomPrev = buffer_read(_buffer, buffer_s16);
                var clientState = buffer_read(_buffer, buffer_u8);
                var clientSAX = buffer_read(_buffer, buffer_u8);
                var clientSpeedboost = buffer_read(_buffer, buffer_u8);
                var clientSJBall = buffer_read(_buffer, buffer_u8);
                var clientSJDir = buffer_read(_buffer, buffer_u8);
                var clientSpeedCharge = buffer_read(_buffer, buffer_u8);
                var clientPlayerHealth = buffer_read(_buffer, buffer_s16);
                var findsocket = ds_list_find_index(roomList, clientID);
                var clientSpectator = buffer_read(_buffer, buffer_u8);
                var clientInvincible = buffer_read(_buffer, buffer_u8);
                var clientMosaic = buffer_read(_buffer, buffer_u8);
                var clientReform = buffer_read(_buffer, buffer_u8);
                var clientVisible = buffer_read(_buffer, buffer_u8);
                var clientSBall = buffer_read(_buffer, buffer_u8);
                
                if (global.clientID != clientID)
                {
                    if (findsocket < 0)
                    {
                        if (clientRoom == room || clientRoom == 6 || clientRoom == 10 || clientRoom == 9 || clientRoom == 11 || clientRoom == 16)
                        {
                            ds_list_add(roomList, clientID);
                            sameRoom = 1;
                            var arr;
                            arr[0] = clientID;
                            arr[1] = clientX;
                            arr[2] = clientY;
                            arr[3] = clientSprite;
                            arr[4] = clientImage;
                            arr[5] = clientA1;
                            arr[6] = clientA1X;
                            arr[7] = clientA1Y;
                            arr[8] = clientA2;
                            arr[9] = clientA2X;
                            arr[10] = clientA2Y;
                            arr[11] = clientA2A;
                            arr[12] = clientMirror;
                            arr[13] = clientArmmsl;
                            arr[14] = clientRoom;
                            arr[15] = clientName;
                            arr[16] = clientBlend;
                            arr[17] = clientFXTimer;
                            arr[18] = clientRoomPrev;
                            arr[19] = clientState;
                            arr[20] = clientSAX;
                            arr[21] = clientSpeedboost;
                            arr[22] = clientSJBall;
                            arr[23] = clientSJDir;
                            arr[24] = clientSpeedCharge;
                            arr[25] = clientPlayerHealth;
                            arr[26] = clientSpectator;
                            arr[27] = clientInvincible;
                            arr[28] = clientMosaic;
                            arr[29] = clientReform;
                            arr[30] = clientVisible;
                            arr[31] = clientSBall;
                            ds_list_add(roomListData, arr);
                        }
                    }
                    else
                    {
                        var arr;
                        arr[0] = clientID;
                        arr[1] = clientX;
                        arr[2] = clientY;
                        arr[3] = clientSprite;
                        arr[4] = clientImage;
                        arr[5] = clientA1;
                        arr[6] = clientA1X;
                        arr[7] = clientA1Y;
                        arr[8] = clientA2;
                        arr[9] = clientA2X;
                        arr[10] = clientA2Y;
                        arr[11] = clientA2A;
                        arr[12] = clientMirror;
                        arr[13] = clientArmmsl;
                        arr[14] = clientRoom;
                        arr[15] = clientName;
                        arr[16] = clientBlend;
                        arr[17] = clientFXTimer;
                        arr[18] = clientRoomPrev;
                        arr[19] = clientState;
                        arr[20] = clientSAX;
                        arr[21] = clientSpeedboost;
                        arr[22] = clientSJBall;
                        arr[23] = clientSJDir;
                        arr[24] = clientSpeedCharge;
                        arr[25] = clientPlayerHealth;
                        arr[26] = clientSpectator;
                        arr[27] = clientInvincible;
                        arr[28] = clientMosaic;
                        arr[29] = clientReform;
                        arr[30] = clientVisible;
                        arr[31] = clientSBall;
                        var indexValue = ds_list_find_value(roomList, findsocket);
                        
                        for (var i = 0; i < ds_list_size(roomListData); i++)
                        {
                            var arrList = ds_list_find_value(roomListData, i);
                            
                            if (is_array(arrList))
                            {
                                if (arrList[0] == indexValue)
                                    ds_list_set(roomListData, i, arr);
                            }
                        }
                        
                        if (clientRoom != room && clientRoom != 6 && clientRoom != 10 && clientRoom != 9 && clientRoom != 11 && clientRoom != 16)
                        {
                            indexValue = ds_list_find_value(roomList, findsocket);
                            ds_list_delete(roomList, findsocket);
                            if (ds_list_size(roomList) == 0)
                                sameRoom = 0;
                            
                            for (var i = 0; i < ds_list_size(roomListData); i++)
                            {
                                var arrList = ds_list_find_value(roomListData, i);
                                
                                if (is_array(arrList))
                                {
                                    if (arrList[0] == indexValue)
                                        ds_list_delete(roomListData, i);
                                }
                            }
                        }
                    }
                }
                
                break;
            
            case 101:
                var clientID = buffer_read(_buffer, buffer_u8);
                var clientRoom = buffer_read(_buffer, buffer_s16);
                var clientMapX = buffer_read(_buffer, buffer_s16);
                var clientMapY = buffer_read(_buffer, buffer_s16);
                var sax = buffer_read(_buffer, buffer_u8);
                var spectator = buffer_read(_buffer, buffer_u8);
                var playerState = buffer_read(_buffer, buffer_u8);
                var combatState = buffer_read(_buffer, buffer_bool);
                var findsocket = ds_list_find_index(roomList, clientID);
                
                if (clientRoom == room && global.clientID != clientID)
                {
                    sameRoom = 1;
                }
                else if (clientRoom != room && global.clientID != clientID && clientRoom != 6 && clientRoom != 10 && clientRoom != 9 && clientRoom != 11 && clientRoom != 16)
                {
                    if (ds_list_size(roomList) > 0 && findsocket >= 0)
                    {
                        sameRoom = 0;
                        var indexValue = ds_list_find_value(roomList, findsocket);
                        ds_list_delete(roomList, findsocket);
                        
                        for (var i = 0; i < ds_list_size(roomListData); i++)
                        {
                            var arrList = ds_list_find_value(roomListData, i);
                            
                            if (is_array(arrList))
                            {
                                if (arrList[0] == clientID)
                                    ds_list_delete(roomListData, i);
                            }
                        }
                    }
                }
                
                findsocket = ds_list_find_index(roomList, clientID);
                
                if (ds_list_size(roomList) > 0 && findsocket >= 0)
                {
                    for (var i = 0; i < ds_list_size(roomListData); i++)
                    {
                        var arrList = ds_list_find_value(roomListData, i);
                        
                        if (is_array(arrList))
                        {
                            if (arrList[0] == clientID)
                            {
                                arrList[14] = clientRoom;
                                ds_list_set(roomListData, i, arrList);
                            }
                        }
                    }
                }
                
                checkList = ds_list_create();
                
                if (ds_list_size(global.idList) > 0)
                {
                    for (var f = 0; f < ds_list_size(global.idList); f++)
                    {
                        if (ds_list_size(posData) > 0 && clientID != global.clientID)
                        {
                            var arrPosData;
                            arrPosData[0] = clientID;
                            arrPosData[1] = clientMapX;
                            arrPosData[2] = clientMapY;
                            arrPosData[3] = sax;
                            arrPosData[4] = clientRoom;
                            arrPosData[5] = spectator;
                            arrPosData[6] = playerState;
                            arrPosData[7] = combatState;
                            
                            for (var v = 0; v < ds_list_size(posData); v++)
                            {
                                var arr = ds_list_find_value(posData, v);
                                if (is_array(arr))
                                {
                                    ds_list_add(checkList, arr[0]);
                                    
                                    if (arr[0] == clientID)
                                        ds_list_set(posData, v, arrPosData);
                                }
                            }
                            
                            var find = ds_list_find_index(checkList, clientID);
                            
                            if (find < 0)
                                ds_list_add(posData, arrPosData);
                        }
                        else if (ds_list_size(posData) == 0 && clientID != global.clientID)
                        {
                            var arrPosData;
                            arrPosData[0] = clientID;
                            arrPosData[1] = clientMapX;
                            arrPosData[2] = clientMapY;
                            arrPosData[3] = sax;
                            arrPosData[4] = clientRoom;
                            arrPosData[5] = spectator;
                            arrPosData[6] = playerState;
                            arrPosData[7] = combatState;
                            ds_list_add(posData, arrPosData);
                            
                            if (instance_exists(oMapCursor) && surface_exists(oSS_Control.s_map))
                                surface_free(oSS_Control.s_map);
                        }
                    }
                }
                
                ds_list_destroy(checkList);
                
                if (clientRoom == 216 && room != rm_a4b01 && is_array(global.event) && global.event[203] > 0 && global.event[203] < 9 && !teleport)
                {
                    if (room == rm_a4b02 || room == rm_a4b03 || room == rm_a4b04 || room == rm_a4b05 || room == rm_a4b06 || room == rm_a4b07 || room == rm_a4b08 || room == rm_a4b09 || room == rm_a4b10 || room == rm_a4b11 || room == rm_a4b12 || room == rm_a4b13 || room == rm_a4b14 || room == rm_a4b15 || room == rm_a4b16 || room == rm_a4b17 || room == rm_a4b18 || room == rm_a4b19)
                    {
                        teleport = 1;
                        global.targetx = 624;
                        global.targety = 144;
                        room_change(216, 1);
                    }
                }
                
                break;
            
            case 102:
                ds_list_read(global.idList, strict_decompress(buffer_read(_buffer, buffer_string)));
                var num_players = max(1, ds_list_size(global.idList));
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
                break;
            
            case 104:
                global.playerhealth -= buffer_read(_buffer, buffer_s16);
                global.playerhealth = clamp(global.playerhealth, 0, global.maxhealth);
                global.playerhealthPrev = global.playerhealth;
                global.missiles -= buffer_read(_buffer, buffer_s16);
                global.missiles = clamp(global.missiles, 0, global.maxmissiles);
                global.missilesPrev = global.missiles;
                global.smissiles -= buffer_read(_buffer, buffer_s16);
                global.smissiles = clamp(global.smissiles, 0, global.maxsmissiles);
                global.smissilesPrev = global.smissiles;
                global.pbombs -= buffer_read(_buffer, buffer_s16);
                global.pbombs = clamp(global.pbombs, 0, global.maxpbombs);
                global.pbombsPrev = global.pbombs;
                break;
            
            case 105:
                var ping = buffer_read(_buffer, buffer_u32);
                global.ping = current_time - ping;
                break;
            
            case 106:
                load_character_vars();
                
                reset_dmap();
                
                global.itemPrev = array_clone(global.item);
                global.metdeadPrev = array_clone(global.metdead);
                global.eventPrev = array_clone(global.event);
                global.dmapPrev = array_clone(global.dmap);
                popup_text("Stats reset");
                break;
            
            case 107:
                disconnectTimer = -10;
                break;
            
            case 108:
                var clientID = buffer_read(_buffer, buffer_u8);
                var team = buffer_read(_buffer, buffer_u8);
                var spacejump = buffer_read(_buffer, buffer_u8);
                var screwattack = buffer_read(_buffer, buffer_u8);
                var spiderball = buffer_read(_buffer, buffer_u8);
                var speedbooster = buffer_read(_buffer, buffer_u8);
                var bomb = buffer_read(_buffer, buffer_u8);
                var ibeam = buffer_read(_buffer, buffer_u8);
                var wbeam = buffer_read(_buffer, buffer_u8);
                var pbeam = buffer_read(_buffer, buffer_u8);
                var sbeam = buffer_read(_buffer, buffer_u8);
                var cbeam = buffer_read(_buffer, buffer_u8);
                var canscrew = buffer_read(_buffer, buffer_u8);
                var otherItemArr;
                otherItemArr[0] = clientID;
                otherItemArr[1] = team;
                otherItemArr[2] = spacejump;
                otherItemArr[3] = screwattack;
                otherItemArr[4] = spiderball;
                otherItemArr[5] = speedbooster;
                otherItemArr[6] = bomb;
                otherItemArr[7] = ibeam;
                otherItemArr[8] = wbeam;
                otherItemArr[9] = pbeam;
                otherItemArr[10] = sbeam;
                otherItemArr[11] = cbeam;
                otherItemArr[12] = canscrew;
                
                if (ds_list_size(global.otherPlayerItems) == 0)
                {
                    ds_list_add(global.otherPlayerItems, otherItemArr);
                }
                else
                {
                    var IDCheck = 0;
                    
                    for (var i = 0; i < ds_list_size(global.otherPlayerItems); i++)
                    {
                        var tempArr = ds_list_find_value(global.otherPlayerItems, i);
                        if (is_array(tempArr))
                        {
                            var ID = tempArr[0];
                            
                            if (ID == clientID)
                            {
                                IDCheck = 1;
                                ds_list_set(global.otherPlayerItems, i, otherItemArr);
                            }
                        }
                    }
                    
                    if (!IDCheck)
                        ds_list_add(global.otherPlayerItems, otherItemArr);
                }
                
                break;
            
            case 109:
                global.showHealthIndicatorsTimer = 900;
                break;
            
            case 110:
                global.showHealthIndicatorsTimer = 900;
                var checkBeam = buffer_read(_buffer, buffer_u8);
                var checkMissile = buffer_read(_buffer, buffer_u8);
                var checkDamage = buffer_read(_buffer, buffer_u8);
                var checkFreeze = buffer_read(_buffer, buffer_u8);
                var checkDir = buffer_read(_buffer, buffer_u8);
                // Friendly fire is disabled in co-op mode: do not apply damage or freeze
                break;
            
            case 111:
                var newTeam = buffer_read(_buffer, buffer_u8);
                global.sax = 0;
                break;
            
            case 112:
                var saxmode = buffer_read(_buffer, buffer_u8);
                var newTeam = buffer_read(_buffer, buffer_u8);
                global.saxmode = saxmode;
                global.sax = 0;
                break;
            
            case 113:
                var time = buffer_read(_buffer, buffer_s32);
                var saxmode = buffer_read(_buffer, buffer_u8);
                var lobbyLocked = buffer_read(_buffer, buffer_u8);
                var samCount = buffer_read(_buffer, buffer_u8);
                var damageMultStr = buffer_read(_buffer, buffer_string);
                var damageMult = real(damageMultStr);
                var shortcuts = buffer_read(_buffer, buffer_u8);
                global.juggActive = buffer_read(_buffer, buffer_u8);
                global.MetCount = buffer_read(_buffer, buffer_u8);
                global.exp_gradualetanks = buffer_read(_buffer, buffer_u8);
                global.damageMult = damageMult;
                global.saxmode = saxmode;
                global.shortcuts = shortcuts;
                
                if (global.saxmode)
                    global.gametime = time;
                
                if (global.spectator)
                {
                    global.spectator = 0;
                    global.spectatorIndex = -1;
                }
                
                global.lobbyLocked = lobbyLocked;
                global.samCount = samCount;
                break;
            
            case 114:
                var lobbyLocked = buffer_read(_buffer, buffer_u8);
                global.spectator = 0;
                global.spectatorIndex = -1;
                global.mosaic = 0;
                global.lobbyLocked = lobbyLocked;
                break;
            
            case 115:
                global.freezeDisabled = buffer_read(_buffer, buffer_u8);
                
                for (var i = 0; i < 15; i += 1)
                {
                    var isItemCollected = 0;
                    if (is_array(global.item))
                    {
                        if (i < array_length_1d(global.item))
                            isItemCollected = global.item[i];
                    }
                    if (buffer_read(_buffer, buffer_u8) == 1 && global.saxmode && global.sax && !isItemCollected && instance_number(oCoreXSyncedItem) == 0 && string_count("rm_a", room_get_name(room)))
                    {
                        var core = instance_create(irandom_range(0, room_width), -100, oCoreXSyncedItem);
                        core.itemtype = i;
                    }
                }
                
                break;
            
            case 116:
                var receivedPasswordHash = buffer_read(_buffer, buffer_string);
                
                if (sha1_string_unicode(oControl.password) == receivedPasswordHash)
                    global.moderator = 1;
                else
                    global.moderator = 0;
                
                break;
            
            case 0:
                global.clientID = buffer_read(_buffer, buffer_u8);
                show_debug_message(string(msgid) + " " + string(global.clientID));
                global.receiving = 1;
                buffer_delete(buffer);
                var size = 1024;
                var type = 1;
                var alignment = 1;
                buffer = buffer_create(size, type, alignment);
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_u8, 200);
                buffer_write(buffer, buffer_u8, global.clientID);
                buffer_write(buffer, buffer_u8, preferredcolor);
                buffer_write(buffer, buffer_u8, global.sax);
                bufferSize = buffer_tell(buffer);
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_s32, bufferSize);
                buffer_write(buffer, buffer_u8, 200);
                buffer_write(buffer, buffer_u8, global.clientID);
                buffer_write(buffer, buffer_u8, preferredcolor);
                buffer_write(buffer, buffer_u8, global.sax);
                var result = network_send_packet(socket, buffer, buffer_tell(buffer));
                break;
            
            case 1:
                ds_grid_read(global.onlineReceived, strict_decompress(buffer_read(_buffer, buffer_string)));
                global.receivedClientID = buffer_read(_buffer, buffer_u8);
                global.receivedPacketID++;
                
                if (global.receivedClientID != global.clientID)
                {
                    update_variables("disablesame");
                    update_variables("replaceglobalvars");
                    update_variables("updateprev");
                    alarm[0] = 10;
                    ds_grid_clear(global.onlineReceived, -1);
                }
                
                break;
            
            case 2:
                ds_grid_read(global.onlineReceived, strict_decompress(buffer_read(_buffer, buffer_string)));
                global.receivedClientID = buffer_read(_buffer, buffer_u8);
                update_variables("disablesame");
                update_variables("updateprev");
                alarm[0] = 10;
                ds_grid_clear(global.onlineReceived, -1);
                break;
            
            case 3:
                queenHealth = buffer_read(_buffer, buffer_s32);
                var clientID = buffer_read(_buffer, buffer_u8);
                phase = buffer_read(_buffer, buffer_s8);
                state = buffer_read(_buffer, buffer_s8);
                
                if (clientID != global.clientID)
                {
                    if (instance_exists(oQueen) && instance_exists(oQueenHead) && !is_undefined(oQueenHead.myhealth) && !is_undefined(oQueen.phase))
                    {
                        if (oQueen.phase == phase)
                        {
                            if (global.queenhealthPrev != queenHealth)
                            {
                                if (queenHealth == 999999)
                                {
                                    queenHealth = 0;
                                    oQueenHead.myhealth = queenHealth;
                                    
                                    if (queenHealth <= 0)
                                    {
                                        with (oQueenHead)
                                        {
                                            if (myhealth <= 0 && state != 100 && state != 50)
                                            {
                                                if (oQueen.phase < 3)
                                                    head_damage = 1;
                                                
                                                if (oQueen.phase == 3)
                                                    head_damage = 2;
                                                
                                                if (oQueen.phase < 5)
                                                {
                                                    state = 50;
                                                    statetime = 0;
                                                    myhealth = 999999;
                                                    
                                                    with (oQueen)
                                                    {
                                                        state = 6;
                                                        statetime = 0;
                                                    }
                                                }
                                                
                                                if (oQueen.phase == 5)
                                                {
                                                    with (oQueen)
                                                    {
                                                        state = 100;
                                                        statetime = 0;
                                                    }
                                                    
                                                    state = 100;
                                                }
                                            }
                                        }
                                        
                                        queenHealth = 999999;
                                    }
                                }
                                
                                global.queenhealthPrev = queenHealth;
                                oQueenHead.myhealth = queenHealth;
                            }
                        }
                        
                        if (global.queenphasePrev != phase)
                            global.queenphasePrev = phase;
                    }
                }
                else if (instance_exists(oQueen) && instance_exists(oQueenHead) && !is_undefined(oQueenHead.myhealth) && !is_undefined(oQueen.phase))
                {
                    global.queenhealthPrev = oQueenHead.myhealth;
                    global.queenphasePrev = oQueen.phase;
                }
                
                break;
            
            case 4:
                var _seed = buffer_read(_buffer, buffer_f64);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID)
                {
                    if (seed != _seed)
                    {
                        seed = _seed;
                        show_debug_message("seed received");
                        popup_seed("Seed received");
                    }
                }
                
                oControl.mod_bombs = buffer_read(_buffer, buffer_s16);
                oControl.mod_spider = buffer_read(_buffer, buffer_s16);
                oControl.mod_jumpball = buffer_read(_buffer, buffer_s16);
                oControl.mod_hijump = buffer_read(_buffer, buffer_s16);
                oControl.mod_varia = buffer_read(_buffer, buffer_s16);
                oControl.mod_spacejump = buffer_read(_buffer, buffer_s16);
                oControl.mod_speedbooster = buffer_read(_buffer, buffer_s16);
                oControl.mod_screwattack = buffer_read(_buffer, buffer_s16);
                oControl.mod_gravity = buffer_read(_buffer, buffer_s16);
                oControl.mod_charge = buffer_read(_buffer, buffer_s16);
                oControl.mod_ice = buffer_read(_buffer, buffer_s16);
                oControl.mod_wave = buffer_read(_buffer, buffer_s16);
                oControl.mod_spazer = buffer_read(_buffer, buffer_s16);
                oControl.mod_plasma = buffer_read(_buffer, buffer_s16);
                oControl.mod_52 = buffer_read(_buffer, buffer_s16);
                oControl.mod_53 = buffer_read(_buffer, buffer_s16);
                oControl.mod_54 = buffer_read(_buffer, buffer_s16);
                oControl.mod_55 = buffer_read(_buffer, buffer_s16);
                oControl.mod_56 = buffer_read(_buffer, buffer_s16);
                oControl.mod_57 = buffer_read(_buffer, buffer_s16);
                oControl.mod_60 = buffer_read(_buffer, buffer_s16);
                oControl.mod_100 = buffer_read(_buffer, buffer_s16);
                oControl.mod_101 = buffer_read(_buffer, buffer_s16);
                oControl.mod_102 = buffer_read(_buffer, buffer_s16);
                oControl.mod_104 = buffer_read(_buffer, buffer_s16);
                oControl.mod_105 = buffer_read(_buffer, buffer_s16);
                oControl.mod_106 = buffer_read(_buffer, buffer_s16);
                oControl.mod_107 = buffer_read(_buffer, buffer_s16);
                oControl.mod_109 = buffer_read(_buffer, buffer_s16);
                oControl.mod_111 = buffer_read(_buffer, buffer_s16);
                oControl.mod_150 = buffer_read(_buffer, buffer_s16);
                oControl.mod_151 = buffer_read(_buffer, buffer_s16);
                oControl.mod_152 = buffer_read(_buffer, buffer_s16);
                oControl.mod_153 = buffer_read(_buffer, buffer_s16);
                oControl.mod_154 = buffer_read(_buffer, buffer_s16);
                oControl.mod_155 = buffer_read(_buffer, buffer_s16);
                oControl.mod_156 = buffer_read(_buffer, buffer_s16);
                oControl.mod_159 = buffer_read(_buffer, buffer_s16);
                oControl.mod_161 = buffer_read(_buffer, buffer_s16);
                oControl.mod_163 = buffer_read(_buffer, buffer_s16);
                oControl.mod_202 = buffer_read(_buffer, buffer_s16);
                oControl.mod_203 = buffer_read(_buffer, buffer_s16);
                oControl.mod_204 = buffer_read(_buffer, buffer_s16);
                oControl.mod_205 = buffer_read(_buffer, buffer_s16);
                oControl.mod_208 = buffer_read(_buffer, buffer_s16);
                oControl.mod_210 = buffer_read(_buffer, buffer_s16);
                oControl.mod_211 = buffer_read(_buffer, buffer_s16);
                oControl.mod_214 = buffer_read(_buffer, buffer_s16);
                oControl.mod_250 = buffer_read(_buffer, buffer_s16);
                oControl.mod_252 = buffer_read(_buffer, buffer_s16);
                oControl.mod_255 = buffer_read(_buffer, buffer_s16);
                oControl.mod_257 = buffer_read(_buffer, buffer_s16);
                oControl.mod_259 = buffer_read(_buffer, buffer_s16);
                oControl.mod_303 = buffer_read(_buffer, buffer_s16);
                oControl.mod_304 = buffer_read(_buffer, buffer_s16);
                oControl.mod_307 = buffer_read(_buffer, buffer_s16);
                oControl.mod_308 = buffer_read(_buffer, buffer_s16);
                oControl.mod_309 = buffer_read(_buffer, buffer_s16);
                oControl.mod_51 = buffer_read(_buffer, buffer_s16);
                oControl.mod_110 = buffer_read(_buffer, buffer_s16);
                oControl.mod_162 = buffer_read(_buffer, buffer_s16);
                oControl.mod_206 = buffer_read(_buffer, buffer_s16);
                oControl.mod_207 = buffer_read(_buffer, buffer_s16);
                oControl.mod_209 = buffer_read(_buffer, buffer_s16);
                oControl.mod_215 = buffer_read(_buffer, buffer_s16);
                oControl.mod_256 = buffer_read(_buffer, buffer_s16);
                oControl.mod_300 = buffer_read(_buffer, buffer_s16);
                oControl.mod_305 = buffer_read(_buffer, buffer_s16);
                oControl.mod_50 = buffer_read(_buffer, buffer_s16);
                oControl.mod_103 = buffer_read(_buffer, buffer_s16);
                oControl.mod_108 = buffer_read(_buffer, buffer_s16);
                oControl.mod_157 = buffer_read(_buffer, buffer_s16);
                oControl.mod_158 = buffer_read(_buffer, buffer_s16);
                oControl.mod_200 = buffer_read(_buffer, buffer_s16);
                oControl.mod_201 = buffer_read(_buffer, buffer_s16);
                oControl.mod_251 = buffer_read(_buffer, buffer_s16);
                oControl.mod_254 = buffer_read(_buffer, buffer_s16);
                oControl.mod_306 = buffer_read(_buffer, buffer_s16);
                oControl.mod_58 = buffer_read(_buffer, buffer_s16);
                oControl.mod_59 = buffer_read(_buffer, buffer_s16);
                oControl.mod_112 = buffer_read(_buffer, buffer_s16);
                oControl.mod_160 = buffer_read(_buffer, buffer_s16);
                oControl.mod_212 = buffer_read(_buffer, buffer_s16);
                oControl.mod_213 = buffer_read(_buffer, buffer_s16);
                oControl.mod_253 = buffer_read(_buffer, buffer_s16);
                oControl.mod_258 = buffer_read(_buffer, buffer_s16);
                oControl.mod_301 = buffer_read(_buffer, buffer_s16);
                oControl.mod_302 = buffer_read(_buffer, buffer_s16);
                break;
            
            case 5:
                var monstersLeft = buffer_read(_buffer, buffer_s8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (global.clientID != clientID && global.monstersleft != monstersLeft)
                {
                    global.monstersleft = monstersLeft;
                    global.monstersleftPrev = global.monstersleft;
                }
                else if (global.clientID == clientID)
                {
                    global.monstersleftPrev = global.monstersleft;
                }
                
                alarm[2] = 10;
                break;
            
            case 6:
                var monstersArea = buffer_read(_buffer, buffer_s8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (global.clientID != clientID && global.monstersarea != monstersArea)
                {
                    global.monstersarea = monstersArea;
                    global.monstersareaPrev = global.monstersarea;
                }
                else if (global.clientID == clientID)
                {
                    global.monstersareaPrev = global.monstersarea;
                }
                
                alarm[2] = 10;
                break;
            
            case 7:
                var ITEMM = ds_list_create();
                ds_list_read(ITEMM, strict_decompress(buffer_read(_buffer, buffer_string)));
                var clientID = buffer_read(_buffer, buffer_u8);
                var itemArr = ds_list_find_value(ITEMM, 0);
                
                if (is_array(itemArr) && is_array(global.item) && is_array(global.itemPrev))
                {
                    for (var i = 0; i < array_length_1d(global.item); i++)
                    {
                        for (var f = 0; f < array_height_2d(itemArr); f++)
                        {
                            if (i == itemArr[f, 1])
                            {
                                global.itemPrev[i] = itemArr[f, 0];
                                
                                if (global.item[i] != itemArr[f, 0])
                                {
                                    global.item[i] = itemArr[f, 0];
                                    
                                    if (i == 0)
                                    {
                                        global.bomb = 1;
                                        global.bombPrev = global.bomb;
                                        popup_text(get_text("Items", "Bombs") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 1)
                                    {
                                        global.powergrip = 1;
                                        global.powergripPrev = global.powergrip;
                                        popup_text(get_text("Items", "PowerGrip") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 2)
                                    {
                                        global.spiderball = 1;
                                        global.spiderballPrev = global.spiderball;
                                        popup_text(get_text("Items", "SpiderBall") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 3)
                                    {
                                        global.jumpball = 1;
                                        global.jumpballPrev = global.jumpball;
                                        popup_text(get_text("Items", "JumpBall") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 4)
                                    {
                                        global.hijump = 1;
                                        global.hijumpPrev = global.hijump;
                                        popup_text(get_text("Items", "HiJump") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 5)
                                    {
                                        if (global.currentsuit != 2)
                                        {
                                            global.currentsuit = 1;
                                            global.currentsuitPrev = global.currentsuit;
                                        }
                                        
                                        global.icemissiles = 1;
                                        popup_text("Varia suit and Ice Missiles " + get_text("GlobalOptions", "Enabled"));
                                        
                                        if (sfx_isplaying(4))
                                            sfx_stop(4);
                                        
                                        if (sfx_isplaying(5))
                                            sfx_stop(5);
                                        
                                        if (sfx_isplaying(6))
                                            sfx_stop(6);
                                        
                                        if (sfx_isplaying(7))
                                            sfx_stop(7);
                                    }
                                    
                                    if (i == 6)
                                    {
                                        global.spacejump = 1;
                                        global.spacejumpPrev = global.spacejump;
                                        popup_text(get_text("Items", "SpaceJump") + " " + get_text("GlobalOptions", "Enabled"));
                                        
                                        if (sfx_isplaying(4))
                                            sfx_stop(4);
                                        
                                        if (sfx_isplaying(5))
                                            sfx_stop(5);
                                        
                                        if (sfx_isplaying(6))
                                            sfx_stop(6);
                                        
                                        if (sfx_isplaying(7))
                                            sfx_stop(7);
                                    }
                                    
                                    if (i == 7)
                                    {
                                        global.speedbooster = 1;
                                        global.speedboosterPrev = global.speedbooster;
                                        popup_text(get_text("Items", "SpeedBooster") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 8)
                                    {
                                        global.screwattack = 1;
                                        global.screwattackPrev = global.screwattack;
                                        popup_text(get_text("Items", "ScrewAttack") + " " + get_text("GlobalOptions", "Enabled"));
                                        
                                        if (sfx_isplaying(4))
                                            sfx_stop(4);
                                        
                                        if (sfx_isplaying(5))
                                            sfx_stop(5);
                                        
                                        if (sfx_isplaying(6))
                                            sfx_stop(6);
                                        
                                        if (sfx_isplaying(7))
                                            sfx_stop(7);
                                    }
                                    
                                    if (i == 9)
                                    {
                                        global.currentsuit = 2;
                                        global.currentsuitPrev = global.currentsuit;
                                        popup_text(get_text("Items", "GravitySuit") + " " + get_text("GlobalOptions", "Enabled"));
                                        
                                        if (sfx_isplaying(4))
                                            sfx_stop(4);
                                        
                                        if (sfx_isplaying(5))
                                            sfx_stop(5);
                                        
                                        if (sfx_isplaying(6))
                                            sfx_stop(6);
                                        
                                        if (sfx_isplaying(7))
                                            sfx_stop(7);
                                    }
                                    
                                    if (i == 10)
                                    {
                                        global.cbeam = 1;
                                        global.cbeamPrev = global.cbeam;
                                        popup_text(get_text("Items", "ChargeBeam") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 11)
                                    {
                                        global.ibeam = 1;
                                        global.ibeamPrev = global.ibeam;
                                        popup_text(get_text("Items", "IceBeam") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 12)
                                    {
                                        global.wbeam = 1;
                                        global.wbeamPrev = global.wbeam;
                                        popup_text(get_text("Items", "WaveBeam") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 13)
                                    {
                                        global.sbeam = 1;
                                        global.sbeamPrev = global.sbeam;
                                        popup_text(get_text("Items", "SpazerBeam") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                    
                                    if (i == 14)
                                    {
                                        global.pbeam = 1;
                                        global.pbeamPrev = global.pbeam;
                                        popup_text(get_text("Items", "PlasmaBeam") + " " + get_text("GlobalOptions", "Enabled"));
                                    }
                                }
                            }
                        }
                    }
                }
                
                alarm[3] = 10;
                
                if (global.clientID == clientID)
                {
                    ds_list_clear(global.onlineItem);
                    global.itemChanges = 0;
                }
                
                ds_list_destroy(ITEMM);
                break;
            
            case 8:
                var metdead = ds_list_create();
                ds_list_read(metdead, strict_decompress(buffer_read(_buffer, buffer_string)));
                var clientID = buffer_read(_buffer, buffer_u8);
                var metdeadArr = ds_list_find_value(metdead, 0);
                
                if (is_array(metdeadArr) && is_array(global.metdead) && is_array(global.metdeadPrev))
                {
                    for (var i = 0; i < array_length_1d(global.metdead); i++)
                    {
                        for (var f = 0; f < array_height_2d(metdeadArr); f++)
                        {
                            if (i == metdeadArr[f, 1])
                            {
                                global.metdeadPrev[i] = metdeadArr[f, 0];
                                
                                if (global.metdead[i] != metdeadArr[f, 0])
                                {
                                    global.metdead[i] = metdeadArr[f, 0];
                                    
                                    if (metdeadArr[f, 0] == 1 && global.clientID != clientID)
                                        popup_text("Metroid killed");
                                }
                            }
                        }
                    }
                }
                
                alarm[4] = 10;
                
                if (global.clientID == clientID)
                {
                    ds_list_clear(global.onlineMetdead);
                    global.metdeadChanges = 0;
                }
                
                ds_list_destroy(metdead);
                break;
            
            case 9:
                var event = ds_list_create();
                ds_list_read(event, strict_decompress(buffer_read(_buffer, buffer_string)));
                var clientID = buffer_read(_buffer, buffer_u8);
                var eventArr = ds_list_find_value(event, 0);
                
                if (is_array(eventArr) && is_array(global.event) && is_array(global.eventPrev))
                {
                    for (var i = 0; i < array_length_1d(global.event); i++)
                    {
                        for (var f = 0; f < array_height_2d(eventArr); f++)
                        {
                            if (i == eventArr[f, 1] && eventArr[f, 1] != 102)
                            {
                                global.eventPrev[i] = eventArr[f, 0];
                                
                                if (global.event[i] != eventArr[f, 0])
                                    global.event[i] = eventArr[f, 0];
                                
                                if (eventArr[f, 1] == 200)
                                    popup_text("Tower Activated");
                                
                                if (eventArr[f, 1] == 250)
                                    popup_text("EMP Activated");
                                
                                if (eventArr[f, 1] == 304)
                                {
                                    popup_text("Hatchling Secured");
                                    
                                    if (instance_exists(oCharacter) && !instance_exists(oHatchling) && !instance_exists(oHatchlingIntro))
                                        instance_create(oCharacter.x, oCharacter.y, oHatchling);
                                }
                            }
                        }
                    }
                }
                
                alarm[5] = 10;
                
                if (global.clientID == clientID)
                {
                    ds_list_clear(global.onlineEvent);
                    global.eventChanges = 0;
                }
                
                ds_list_destroy(event);
                break;
            
            case 10:
                var tileCount = buffer_read(_buffer, buffer_u16);
                
                if (tileCount > 0)
                {
                    for (var i = 0; i < tileCount; i++)
                    {
                        var tileX = buffer_read(_buffer, buffer_u8);
                        var tileY = buffer_read(_buffer, buffer_u8);
                        var tileData = buffer_read(_buffer, buffer_u8);
                        if (is_array(global.dmapPrev))
                            global.dmapPrev[tileX, tileY] = tileData;
                        
                        if (is_array(global.dmap))
                        {
                            if (global.dmap[tileX, tileY] != tileData)
                            {
                                global.dmap[tileX, tileY] = tileData;
                                
                                if (global.ingame)
                                {
                                    with (oControl)
                                        event_user(2);
                                }
                                
                                if (instance_exists(oMapCursor) && surface_exists(oSS_Control.s_map))
                                    surface_free(oSS_Control.s_map);
                            }
                        }
                    }
                    
                    var clientID = buffer_read(_buffer, buffer_u8);
                }
                
                alarm[6] = 10;
                break;
            
            case 11:
                var itemstaken = buffer_read(_buffer, buffer_u8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID && itemstaken != global.itemstaken)
                {
                    global.itemstakenPrev = itemstaken;
                    global.itemstaken = itemstaken;
                }
                else if (clientID == global.clientID)
                {
                    global.itemstakenPrev = global.itemstaken;
                }
                
                alarm[7] = 1;
                break;
            
            case 12:
                var maxmissiles = buffer_read(_buffer, buffer_u16);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID && maxmissiles != global.maxmissiles)
                {
                    global.maxmissilesPrev = maxmissiles;
                    global.maxmissiles = maxmissiles;
                }
                else if (clientID == global.clientID)
                {
                    global.maxmissilesPrev = global.maxmissiles;
                }
                
                global.missilesPrev = maxmissiles;
                global.missiles = maxmissiles;
                alarm[8] = 1;
                break;
            
            case 13:
                var maxsmissiles = buffer_read(_buffer, buffer_u8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID && maxsmissiles != global.maxsmissiles)
                {
                    global.maxsmissilesPrev = maxsmissiles;
                    global.maxsmissiles = maxsmissiles;
                }
                else if (clientID == global.clientID)
                {
                    global.maxsmissilesPrev = global.maxsmissiles;
                }
                
                global.smissilesPrev = maxsmissiles;
                global.smissiles = maxsmissiles;
                alarm[9] = 1;
                break;
            
            case 14:
                var maxpbombs = buffer_read(_buffer, buffer_u8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID && maxpbombs != global.maxpbombs)
                {
                    global.maxpbombsPrev = maxpbombs;
                    global.maxpbombs = maxpbombs;
                }
                else if (clientID == global.clientID)
                {
                    global.maxpbombsPrev = global.maxpbombs;
                }
                
                global.pbombsPrev = maxpbombs;
                global.pbombs = maxpbombs;
                maxpbombsTimer = 1;
                break;
            
            case 15:
                var maxhealth = buffer_read(_buffer, buffer_u16);
                var clientID = buffer_read(_buffer, buffer_u8);
                var oldMax = global.maxhealth;
                
                if (clientID != global.clientID && maxhealth != global.maxhealth)
                {
                    global.maxhealth = maxhealth;

                    if (global.exp_gradualetanks)
                    {
                        if (instance_exists(oCharacter))
                            oCharacter.fillhp = 1;

                        global.playerhealth += (global.maxhealth - oldMax);
                    }
                    else
                    {
                        global.playerhealth = maxhealth;
                    }
                }
                global.maxhealthPrev = global.maxhealth;

                global.playerhealthPrev = global.playerhealth;
                maxhealthTimer = 1;
                break;
            
            case 16:
                var etanks = buffer_read(_buffer, buffer_u8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID && etanks != global.etanks)
                {
                    global.etanksPrev = etanks;
                    global.etanks = etanks;
                }
                else if (clientID == global.clientID)
                {
                    global.etanksPrev = global.etanks;
                }
                
                etanksTimer = 1;
                break;
            
            case 17:
                var mtanks = buffer_read(_buffer, buffer_u8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID && mtanks != global.mtanks)
                {
                    global.mtanksPrev = mtanks;
                    global.mtanks = mtanks;
                }
                else if (clientID == global.clientID)
                {
                    global.mtanksPrev = global.mtanks;
                }
                
                mtanksTimer = 1;
                break;
            
            case 18:
                var stanks = buffer_read(_buffer, buffer_u8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID && stanks != global.stanks)
                {
                    global.stanksPrev = stanks;
                    global.stanks = stanks;
                }
                else if (clientID == global.clientID)
                {
                    global.stanksPrev = global.stanks;
                }
                
                stanksTimer = 1;
                break;
            
            case 19:
                var ptanks = buffer_read(_buffer, buffer_u8);
                var clientID = buffer_read(_buffer, buffer_u8);
                
                if (clientID != global.clientID && ptanks != global.ptanks)
                {
                    global.ptanksPrev = ptanks;
                    global.ptanks = ptanks;
                }
                else if (clientID == global.clientID)
                {
                    global.ptanksPrev = global.ptanks;
                }
                
                ptanksTimer = 1;
                break;
            
            case 20:
                var time = buffer_read(_buffer, buffer_s32);
                global.gametime = time;
                break;
            
            case 21:
                var clientID = buffer_read(_buffer, buffer_u8);
                var dir = buffer_read(_buffer, buffer_s16);
                var sprX = buffer_read(_buffer, buffer_s16);
                var sprY = buffer_read(_buffer, buffer_s16);
                var charge = buffer_read(_buffer, buffer_u8);
                var sax = buffer_read(_buffer, buffer_u8);
                
                if (ds_list_size(roomListData) > 0 && clientID != global.clientID)
                {
                    for (var i = 0; i < ds_list_size(roomListData); i++)
                    {
                        var arrDraw = ds_list_find_value(roomListData, i);
                        if (is_array(arrDraw))
                        {
                            var arrID = arrDraw[0];
                            
                            if (clientID == arrID)
                            {
                                if (instance_exists(oCharacter))
                                {
                                    with (oCharacter)
                                        shoot_beam_receive(sprX, sprY, dir, charge, sax, clientID);
                                }
                            }
                        }
                    }
                }
                
                break;
            
            case 22:
                var clientID = buffer_read(_buffer, buffer_u8);
                var bombX = buffer_read(_buffer, buffer_s16);
                var bombY = buffer_read(_buffer, buffer_s16);
                var sax = buffer_read(_buffer, buffer_u8);
                
                if (ds_list_size(roomListData) > 0 && clientID != global.clientID)
                {
                    for (var i = 0; i < ds_list_size(roomListData); i++)
                    {
                        var arrDraw = ds_list_find_value(roomListData, i);
                        if (is_array(arrDraw))
                        {
                            var arrID = arrDraw[0];
                            
                            if (clientID == arrID)
                            {
                                if (instance_exists(oCharacter))
                                {
                                    var bomb = instance_create(bombX, bombY, oBombMulti);
                                    bomb.sax = sax;
                                    bomb.myid = clientID;
                                    sfx_play(89);
                                }
                            }
                        }
                    }
                }
                
                break;
            
            case 23:
                var clientID = buffer_read(_buffer, buffer_u8);
                var currentWeapon = buffer_read(_buffer, buffer_u8);
                var dir = buffer_read(_buffer, buffer_s16);
                var missileX = buffer_read(_buffer, buffer_s16);
                var missileY = buffer_read(_buffer, buffer_s16);
                var sax = buffer_read(_buffer, buffer_u8);
                var velX = buffer_read(_buffer, buffer_s8);
                var velY = buffer_read(_buffer, buffer_s8);
                var icemissiles = buffer_read(_buffer, buffer_u8);
                
                if (ds_list_size(roomListData) > 0 && clientID != global.clientID)
                {
                    for (var i = 0; i < ds_list_size(roomListData); i++)
                    {
                        var arrDraw = ds_list_find_value(roomListData, i);
                        if (is_array(arrDraw))
                        {
                            var arrID = arrDraw[0];
                            
                            if (clientID == arrID)
                            {
                                if (instance_exists(oCharacter))
                                {
                                    with (oCharacter)
                                        shoot_missile_receive(dir, currentWeapon, missileX, missileY, sax, clientID, velX, velY, icemissiles);
                                }
                            }
                        }
                    }
                }
                
                break;
            
            case 24:
                var clientID = buffer_read(_buffer, buffer_u8);
                var pbombX = buffer_read(_buffer, buffer_s16);
                var pbombY = buffer_read(_buffer, buffer_s16);
                var sax = buffer_read(_buffer, buffer_u8);
                
                if (ds_list_size(roomListData) > 0 && clientID != global.clientID)
                {
                    for (var i = 0; i < ds_list_size(roomListData); i++)
                    {
                        var arrDraw = ds_list_find_value(roomListData, i);
                        if (is_array(arrDraw))
                        {
                            var arrID = arrDraw[0];
                            
                            if (clientID == arrID)
                            {
                                if (instance_exists(oCharacter))
                                {
                                    pbomb = instance_create(pbombX, pbombY, oPBombMulti);
                                    pbomb.enemy = 0;
                                    pbomb.sax = sax;
                                    pbomb.myid = clientID;
                                    sfx_play(128);
                                }
                            }
                        }
                    }
                }
                
                break;
            
            case 29:
                var syncDiff = buffer_read(_buffer, buffer_u8);
                
                if (syncDiff != syncedDifficulty)
                {
                    syncedDifficulty = syncDiff;
                    var str;
                    
                    switch (syncedDifficulty)
                    {
                        case 0:
                            str = "Easy";
                            break;
                        
                        case 1:
                            str = "Normal";
                            break;
                        
                        case 2:
                            str = "Hard";
                            break;
                        
                        case 3:
                            str = "Fusion";
                            break;
                    }
                    
                    popup_text(str);
                }
                
                if (instance_exists(oOptionsMod) && oOptionsMod.menuDifficulty != syncedDifficulty)
                    oOptionsMod.menuDifficulty = syncedDifficulty;
                
                break;
            
            case 30:
                var syncELM = buffer_read(_buffer, buffer_u8);
                
                if (syncELM != elm)
                {
                    elm = syncELM;
                    var str;
                    
                    switch (elm)
                    {
                        case 0:
                            str = "ELM Disabled";
                            break;
                        
                        case 1:
                            str = "ELM Enabled";
                            break;
                    }
                    
                    popup_text(str);
                }
                
                if (instance_exists(oOptionsMod) && oOptionsMod.elm != elm)
                    oOptionsMod.elm = elm;
                
                break;
            
            case 31:
                var otherAbsorbRelativeX = buffer_read(_buffer, buffer_s16);
                var otherAbsorbRelativeY = buffer_read(_buffer, buffer_s16);
                var otherAbsorbSpriteHeight = buffer_read(_buffer, buffer_u8);
                global.absorbRelativeX = otherAbsorbRelativeX;
                global.absorbRelativeY = otherAbsorbRelativeY;
                global.absorbSpriteHeight = otherAbsorbSpriteHeight;
                global.beingAbsorbed = 1;
                break;
            
            case 32:
                var mapposx = buffer_read(_buffer, buffer_s16);
                var mapposy = buffer_read(_buffer, buffer_s16);
                global.mapmarker = 1;
                global.mapmarkerx = mapposx;
                global.mapmarkery = mapposy;
                global.playerMapPosTimer = 600;
                break;
            
            case 33:
                var mirror = buffer_read(_buffer, buffer_s8);
                var sentRoom = buffer_read(_buffer, buffer_s16);
                var playerX = buffer_read(_buffer, buffer_s16);
                var playerY = buffer_read(_buffer, buffer_s16);
                var sax = buffer_read(_buffer, buffer_s8);
                
                if (room == sentRoom && !sax)
                {
                    seq = instance_create(playerX, playerY, oDeathSequenceMulti);
                    seq.facing = mirror;
                }
                
                break;
            
            case 45:
                var pRoom = buffer_read(_buffer, buffer_s16);
                var pX = buffer_read(_buffer, buffer_s16);
                var pY = buffer_read(_buffer, buffer_s16);
                
                if (room == pRoom)
                {
                    var nearP = instance_nearest(pX, pY, oPickup);
                    if (nearP != noone)
                    {
                        if (point_distance(pX, pY, nearP.x, nearP.y) < 64)
                        {
                            with (nearP)
                                instance_destroy();
                        }
                    }
                    var nearX = instance_nearest(pX, pY, oXPickup);
                    if (nearX != noone)
                    {
                        if (point_distance(pX, pY, nearX.x, nearX.y) < 64)
                        {
                            with (nearX)
                                instance_destroy();
                        }
                    }
                }
                break;
            
            case 81: // Enemy Defeated / Dead
                var eRoom = buffer_read(_buffer, buffer_s16);
                var eXStart = buffer_read(_buffer, buffer_s16);
                var eYStart = buffer_read(_buffer, buffer_s16);
                
                if (room == eRoom)
                {
                    with (oEnemy)
                    {
                        if (round(xstart) == eXStart && round(ystart) == eYStart)
                        {
                            var idx = ds_list_find_index(other.activeEnemyIds, id);
                            if (idx != -1)
                            {
                                ds_list_delete(other.activeEnemyIds, idx);
                                ds_list_delete(other.activeEnemyX, idx);
                                ds_list_delete(other.activeEnemyY, idx);
                            }
                            if (other.isRoomHost)
                                spawn_rnd_pickup(100);
                            myhealth = 0;
                            instance_destroy();
                        }
                    }
                }
                break;
            
            case 82: // Enemy HP sync
                var eRoom = buffer_read(_buffer, buffer_s16);
                var eXStart = buffer_read(_buffer, buffer_s16);
                var eYStart = buffer_read(_buffer, buffer_s16);
                var eHP = buffer_read(_buffer, buffer_s16);
                
                if (room == eRoom)
                {
                    with (oEnemy)
                    {
                        if (round(xstart) == eXStart && round(ystart) == eYStart)
                        {
                            if (myhealth > eHP)
                                myhealth = eHP;
                        }
                    }
                }
                break;
            
            case 83: // Server sets room authority status (room, isHost)
                var authRoom = buffer_read(_buffer, buffer_s16);
                var authIsHost = buffer_read(_buffer, buffer_u8);
                if (room == authRoom)
                {
                    isRoomHost = authIsHost;
                }
                break;

            case 84: // Enemy Position Batch sync (applied by follower)
                var eRoom = buffer_read(_buffer, buffer_s16);
                var eCount = buffer_read(_buffer, buffer_u16);
                
                if (room == eRoom && !isRoomHost)
                {
                    for (var k = 0; k < eCount; k++)
                    {
                        var eXStart = buffer_read(_buffer, buffer_s16);
                        var eYStart = buffer_read(_buffer, buffer_s16);
                        var curX = buffer_read(_buffer, buffer_s16);
                        var curY = buffer_read(_buffer, buffer_s16);
                        var curScale = buffer_read(_buffer, buffer_s8);
                        var curHP = buffer_read(_buffer, buffer_s16);
                        
                        var ek = string(eXStart) + "_" + string(eYStart);
                        if (ds_map_exists(activeEnemyMap, ek))
                        {
                            var eid = ds_map_find_value(activeEnemyMap, ek);
                            if (instance_exists(eid))
                            {
                                with (eid)
                                {
                                    sync_target_x = curX;
                                    sync_target_y = curY;
                                    sync_target_scale = curScale;
                                    myhealth = curHP;
                                    
                                    if (!sync_active || point_distance(x, y, curX, curY) > 48)
                                    {
                                        x = curX;
                                        y = curY;
                                        sync_active = 1;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    for (var k = 0; k < eCount; k++)
                    {
                        buffer_read(_buffer, buffer_s16);
                        buffer_read(_buffer, buffer_s16);
                        buffer_read(_buffer, buffer_s16);
                        buffer_read(_buffer, buffer_s16);
                        buffer_read(_buffer, buffer_s8);
                        buffer_read(_buffer, buffer_s16);
                    }
                }
                break;

            case 86: // Server requests immediate enemy sync from host
                var reqRoom = buffer_read(_buffer, buffer_s16);
                if (room == reqRoom && isRoomHost)
                {
                    enemySyncTimer = 5;
                    var eCount = instance_number(oEnemy);
                    if (eCount <= 60)
                    {
                        var posBuf = buffer_create(1024, buffer_grow, 1);
                        buffer_seek(posBuf, buffer_seek_start, 0);
                        buffer_write(posBuf, buffer_s32, 0);
                        buffer_write(posBuf, buffer_u8, 84);
                        buffer_write(posBuf, buffer_s16, room);
                        buffer_write(posBuf, buffer_u16, eCount);
                        if (eCount > 0)
                        {
                            with (oEnemy)
                            {
                                buffer_write(posBuf, buffer_s16, round(xstart));
                                buffer_write(posBuf, buffer_s16, round(ystart));
                                buffer_write(posBuf, buffer_s16, round(x));
                                buffer_write(posBuf, buffer_s16, round(y));
                                buffer_write(posBuf, buffer_s8, round(image_xscale));
                                buffer_write(posBuf, buffer_s16, myhealth);
                            }
                        }
                        buffer_poke(posBuf, 0, buffer_s32, buffer_tell(posBuf) - 4);
                        network_send_packet(socket, posBuf, buffer_tell(posBuf));
                        buffer_delete(posBuf);
                    }
                }
                break;
            
            case 85: // Dead enemies list on room entry
                var eRoom = buffer_read(_buffer, buffer_s16);
                var deadCount = buffer_read(_buffer, buffer_u16);
                
                for (var k = 0; k < deadCount; k++)
                {
                    var dXStart = buffer_read(_buffer, buffer_s16);
                    var dYStart = buffer_read(_buffer, buffer_s16);
                    if (room == eRoom)
                    {
                        with (oEnemy)
                        {
                            if (round(xstart) == dXStart && round(ystart) == dYStart)
                            {
                                var idx = ds_list_find_index(other.activeEnemyIds, id);
                                if (idx != -1)
                                {
                                    ds_list_delete(other.activeEnemyIds, idx);
                                    ds_list_delete(other.activeEnemyX, idx);
                                    ds_list_delete(other.activeEnemyY, idx);
                                }
                                instance_destroy();
                            }
                        }
                    }
                }
                break;
            
            case 87: // Spawn Pickup / Virus Sync (received from room authority)
                var pRoom = buffer_read(_buffer, buffer_s16);
                var pType = buffer_read(_buffer, buffer_u8);
                var pX = buffer_read(_buffer, buffer_s16);
                var pY = buffer_read(_buffer, buffer_s16);
                
                if (room == pRoom)
                {
                    var pObj = noone;
                    switch (pType)
                    {
                        case 1: pObj = oHPickup; break;
                        case 2: pObj = oHPickupBig; break;
                        case 3: pObj = oMPickup; break;
                        case 4: pObj = oSMPickup; break;
                        case 5: pObj = oPBPickup; break;
                        case 6: pObj = oHXPickup; break;
                        case 7: pObj = oHXPickupBig; break;
                        case 8: pObj = oMXPickup; break;
                        case 9: pObj = oSMXPickup; break;
                        case 10: pObj = oPBXPickup; break;
                    }
                    
                    if (pObj != noone)
                    {
                        var spawned = instance_create(pX, pY, pObj);
                        if (pType >= 6 && pType <= 10)
                        {
                            spawned.reform = -1;
                            spawned.lastEnemy = -1;
                            spawned.sizeX = 5.8;
                            spawned.sizeY = 4.2;
                            spawned.state = 1;
                            spawned.statetime = 40;
                            spawned.counter = 0;
                            spawned.collectable = 1;
                        }
                    }
                }
                break;
            
            case 50:
                writelog("NET 50 START");
                var resend = 0;
                if (!is_array(global.item) || !is_array(global.itemPrev))
                {
                    load_character_vars();
                    update_variables("initprev");
                }
                
                if (is_array(global.item))
                {
                    for (var i = 0; i < array_length_1d(global.item); i++)
                {
                    var receivedItem = buffer_read(_buffer, buffer_u8);
                    
                    if (receivedItem == 1 && global.item[i] == 0)
                    {
                        global.item[i] = receivedItem;
                        global.itemPrev[i] = global.item[i];
                        
                        if (i == 0)
                        {
                            global.bomb = 1;
                            global.bombPrev = global.bomb;
                            popup_text(get_text("Items", "Bombs") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 1)
                        {
                            global.powergrip = 1;
                            global.powergripPrev = global.powergrip;
                            popup_text(get_text("Items", "PowerGrip") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 2)
                        {
                            global.spiderball = 1;
                            global.spiderballPrev = global.spiderball;
                            popup_text(get_text("Items", "SpiderBall") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 3)
                        {
                            global.jumpball = 1;
                            global.jumpballPrev = global.jumpball;
                            popup_text(get_text("Items", "JumpBall") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 4)
                        {
                            global.hijump = 1;
                            global.hijumpPrev = global.hijump;
                            popup_text(get_text("Items", "HiJump") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 5)
                        {
                            global.currentsuit = 1;
                            global.currentsuitPrev = global.currentsuit;
                            global.icemissiles = 1;
                            popup_text("Varia suit and Ice Missiles " + get_text("GlobalOptions", "Enabled"));
                            
                            if (sfx_isplaying(4))
                                sfx_stop(4);
                            
                            if (sfx_isplaying(5))
                                sfx_stop(5);
                            
                            if (sfx_isplaying(6))
                                sfx_stop(6);
                            
                            if (sfx_isplaying(7))
                                sfx_stop(7);
                        }
                        
                        if (i == 6)
                        {
                            global.spacejump = 1;
                            global.spacejumpPrev = global.spacejump;
                            popup_text(get_text("Items", "SpaceJump") + " " + get_text("GlobalOptions", "Enabled"));
                            
                            if (sfx_isplaying(4))
                                sfx_stop(4);
                            
                            if (sfx_isplaying(5))
                                sfx_stop(5);
                            
                            if (sfx_isplaying(6))
                                sfx_stop(6);
                            
                            if (sfx_isplaying(7))
                                sfx_stop(7);
                        }
                        
                        if (i == 7)
                        {
                            global.speedbooster = 1;
                            global.speedboosterPrev = global.speedbooster;
                            popup_text(get_text("Items", "SpeedBooster") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 8)
                        {
                            global.screwattack = 1;
                            global.screwattackPrev = global.screwattack;
                            popup_text(get_text("Items", "ScrewAttack") + " " + get_text("GlobalOptions", "Enabled"));
                            
                            if (sfx_isplaying(4))
                                sfx_stop(4);
                            
                            if (sfx_isplaying(5))
                                sfx_stop(5);
                            
                            if (sfx_isplaying(6))
                                sfx_stop(6);
                            
                            if (sfx_isplaying(7))
                                sfx_stop(7);
                        }
                        
                        if (i == 9)
                        {
                            global.currentsuit = 2;
                            global.currentsuitPrev = global.currentsuit;
                            popup_text(get_text("Items", "GravitySuit") + " " + get_text("GlobalOptions", "Enabled"));
                            
                            if (sfx_isplaying(4))
                                sfx_stop(4);
                            
                            if (sfx_isplaying(5))
                                sfx_stop(5);
                            
                            if (sfx_isplaying(6))
                                sfx_stop(6);
                            
                            if (sfx_isplaying(7))
                                sfx_stop(7);
                        }
                        
                        if (i == 10)
                        {
                            global.cbeam = 1;
                            global.cbeamPrev = global.cbeam;
                            popup_text(get_text("Items", "ChargeBeam") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 11)
                        {
                            global.ibeam = 1;
                            global.ibeamPrev = global.ibeam;
                            popup_text(get_text("Items", "IceBeam") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 12)
                        {
                            global.wbeam = 1;
                            global.wbeamPrev = global.wbeam;
                            popup_text(get_text("Items", "WaveBeam") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 13)
                        {
                            global.sbeam = 1;
                            global.sbeamPrev = global.sbeam;
                            popup_text(get_text("Items", "SpazerBeam") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                        
                        if (i == 14)
                        {
                            global.pbeam = 1;
                            global.pbeamPrev = global.pbeam;
                            popup_text(get_text("Items", "PlasmaBeam") + " " + get_text("GlobalOptions", "Enabled"));
                        }
                    }
                    else if (receivedItem == 0 && global.item[i] == 1)
                    {
                        if ((!global.spectator || global.sax) && !is_on_menu())
                        {
                            resend = 1;
                        }
                        else if (global.saxmode)
                        {
                            global.item[i] = receivedItem;
                            global.itemPrev[i] = global.item[i];
                        }
                    }
                }
                
                var etankCount = 0;
                
                for (var i = 0; i < array_length_1d(global.item); i++)
                {
                    if (i == 50 || i == 103 || i == 108 || i == 157 || i == 158 || i == 200 || i == 201 || i == 251 || i == 254 || i == 306)
                    {
                        if (global.item[i] == 1)
                            etankCount++;
                    }
                }
                
                if (etankCount != global.etanks)
                {
                    var oldTanks = global.etanks;
                    global.etanks = etankCount;
                    global.maxhealth = (99 + (100 * global.etanks)) * oControl.mod_etankhealthmult;
                    if (global.exp_gradualetanks)
                    {
                        if (instance_exists(oCharacter))
                            oCharacter.fillhp = 1;

                        global.playerhealth += ((global.etanks - oldTanks) * 100);
                    }
                    else
                    {
                        global.playerhealth = global.maxhealth;
                    }
                    if (etankCount > oldTanks)
                        popup_text("Energy Tank +100");
                }
                
                var stankCount = 0;
                
                for (var i = 0; i < array_length_1d(global.item); i++)
                {
                    if (i == 51 || i == 110 || i == 162 || i == 206 || i == 207 || i == 209 || i == 215 || i == 256 || i == 300 || i == 305)
                    {
                        if (global.item[i] == 1)
                            stankCount++;
                    }
                }
                
                if (stankCount != global.stanks)
                {
                    var oldSTanks = global.stanks;
                    global.stanks = stankCount;
                    
                    if (global.difficulty < 2)
                        global.maxsmissiles = 2 * global.stanks;
                    
                    if (global.difficulty == 2)
                        global.maxsmissiles = 1 * global.stanks;
                    
                    global.smissiles = global.maxsmissiles;
                    if (stankCount > oldSTanks)
                        popup_text("Super Missiles +2");
                }
                
                var ptankCount = 0;
                
                for (var i = 0; i < array_length_1d(global.item); i++)
                {
                    if (i == 58 || i == 59 || i == 112 || i == 160 || i == 212 || i == 213 || i == 253 || i == 258 || i == 301 || i == 302)
                    {
                        if (global.item[i] == 1)
                            ptankCount++;
                    }
                }
                
                if (ptankCount != global.ptanks)
                {
                    var oldPTanks = global.ptanks;
                    global.ptanks = ptankCount;
                    
                    if (global.difficulty < 2)
                        global.maxpbombs = 2 * global.ptanks;
                    
                    if (global.difficulty == 2)
                        global.maxpbombs = 1 * global.ptanks;
                    
                    global.pbombs = global.maxpbombs;
                    if (ptankCount > oldPTanks)
                        popup_text("Power Bombs +2");
                }
                
                var mtankCount = 0;
                
                for (var i = 0; i < array_length_1d(global.item); i++)
                {
                    if (i == 52 || i == 53 || i == 54 || i == 55 || i == 56 || i == 57 || i == 60 || i == 100 || i == 101 || i == 102 || i == 104 || i == 105 || i == 106 || i == 107 || i == 109 || i == 111 || i == 150 || i == 151 || i == 152 || i == 153 || i == 154 || i == 155 || i == 156 || i == 159 || i == 161 || i == 163 || i == 202 || i == 203 || i == 204 || i == 205 || i == 208 || i == 210 || i == 211 || i == 214 || i == 250 || i == 252 || i == 255 || i == 257 || i == 259 || i == 303 || i == 304 || i == 307 || i == 308 || i == 309)
                    {
                        if (global.item[i] == 1)
                            mtankCount++;
                    }
                }
                
                if (mtankCount != global.mtanks)
                {
                    var oldMTanks = global.mtanks;
                    global.mtanks = mtankCount;
                    
                    if (global.difficulty < 2)
                        global.maxmissiles = oControl.mod_Mstartingcount + (5 * global.mtanks);
                    
                    if (global.difficulty == 2)
                        global.maxmissiles = oControl.mod_Mstartingcount + (2 * global.mtanks);
                    
                    global.missiles = global.maxmissiles;
                    if (mtankCount > oldMTanks)
                        popup_text("Missiles +5");
                }
                
                // Co-op: Destroy any collected oItem in the current room
                if (instance_exists(oItem))
                {
                    with (oItem)
                    {
                        if (is_array(global.item))
                        {
                            if (itemid < array_length_1d(global.item))
                            {
                                if (global.item[itemid] == 1)
                                    instance_destroy();
                            }
                        }
                    }
                    }
                }
                
                // Invalidate map screen surface so map shows item collected
                if (instance_exists(oMapCursor) && surface_exists(oSS_Control.s_map))
                    surface_free(oSS_Control.s_map);
                
                if (resend && is_array(global.item))
                {
                    var size = 1024;
                    var type = 1;
                    var alignment = 1;
                    itemBuffer = buffer_create(size, type, alignment);
                    buffer_seek(itemBuffer, buffer_seek_start, 0);
                    buffer_write(itemBuffer, buffer_u8, 50);
                    
                    for (var i = 0; i < array_length_1d(global.item); i++)
                        buffer_write(itemBuffer, buffer_u8, global.item[i]);
                    
                    bufferSize = buffer_tell(itemBuffer);
                    buffer_seek(itemBuffer, buffer_seek_start, 0);
                    buffer_write(itemBuffer, buffer_s32, bufferSize);
                    buffer_write(itemBuffer, buffer_u8, 50);
                    
                    for (var i = 0; i < array_length_1d(global.item); i++)
                        buffer_write(itemBuffer, buffer_u8, global.item[i]);
                    
                    network_send_packet(socket, itemBuffer, buffer_tell(itemBuffer));
                    buffer_delete(itemBuffer);
                }
                writelog("NET 50 END");
                break;
            
            case 51:
                writelog("NET 51 START");
                var resend = 0;
                if (!is_array(global.event) || !is_array(global.eventPrev))
                {
                    load_character_vars();
                    update_variables("initprev");
                }
                
                if (is_array(global.event))
                {
                    for (var i = 0; i < array_length_1d(global.event); i++)
                    {
                        if (i < 350)
                        {
                            var receivedEvent = buffer_read(_buffer, buffer_u8);
                            
                            if (floor(receivedEvent) > floor(global.event[i]) && i != 102)
                            {
                                global.event[i] = receivedEvent;
                                if (is_array(global.eventPrev))
                                    global.eventPrev[i] = global.event[i];
                            }
                            else if (floor(receivedEvent) < floor(global.event[i]) && i != 102)
                            {
                                resend = 1;
                            }
                        }
                    }
                }
                
                if (resend && is_array(global.event))
                {
                    var size = 1024;
                    var type = 1;
                    var alignment = 1;
                    eventBuffer = buffer_create(size, type, alignment);
                    buffer_seek(eventBuffer, buffer_seek_start, 0);
                    buffer_write(eventBuffer, buffer_u8, 51);
                    
                    for (var i = 0; i < array_length_1d(global.event); i++)
                        buffer_write(eventBuffer, buffer_u8, global.event[i]);
                    
                    bufferSize = buffer_tell(eventBuffer);
                    buffer_seek(eventBuffer, buffer_seek_start, 0);
                    buffer_write(eventBuffer, buffer_s32, bufferSize);
                    buffer_write(eventBuffer, buffer_u8, 51);
                    
                    for (var i = 0; i < array_length_1d(global.event); i++)
                        buffer_write(eventBuffer, buffer_u8, global.event[i]);
                    
                    network_send_packet(socket, eventBuffer, buffer_tell(eventBuffer));
                    buffer_delete(eventBuffer);
                }
                writelog("NET 51 END");
                break;
            
            case 52:
                writelog("NET 52 START");
                var resend = 0;
                if (!is_array(global.metdead) || !is_array(global.metdeadPrev) || !is_array(global.event))
                {
                    load_character_vars();
                    update_variables("initprev");
                }
                
                if (is_array(global.metdead))
                {
                    for (var i = 0; i < array_length_1d(global.metdead); i++)
                    {
                        var receivedMetdead = buffer_read(_buffer, buffer_u8);
                        
                        if (receivedMetdead == 1 && global.metdead[i] == 0)
                        {
                            global.metdead[i] = receivedMetdead;
                            if (is_array(global.metdeadPrev))
                                global.metdeadPrev[i] = global.metdead[i];
                        }
                        else if (receivedMetdead == 0 && global.metdead[i] == 1)
                        {
                            resend = 1;
                        }
                    }
                }
                
                if (global.gamemode == 1)
                {
                    var countArea = 0;
                    var countLeft = 0;
                    
                    for (var i = 0; i < array_length_1d(global.metdead); i++)
                    {
                        if (i <= 45)
                        {
                            if (global.metdead[i] == 0)
                                countLeft++;
                            
                            if (global.lavastate >= 0 && global.metdead[i] == 0 && i == 0)
                                countArea++;
                            
                            if (global.lavastate >= 1 && global.metdead[i] == 0 && (i == 1 || i == 2 || i == 3 || i == 4))
                                countArea++;
                            
                            if (global.lavastate >= 2 && global.metdead[i] == 0 && (i == 5 || i == 6 || i == 7 || i == 8 || i == 9 || i == 10 || i == 11 || i == 12))
                                countArea++;
                            
                            if (global.lavastate >= 3 && global.metdead[i] == 0 && (i == 13 || i == 14 || i == 15 || i == 16 || i == 17 || i == 18 || i == 19 || i == 20 || i == 21 || i == 22))
                                countArea++;
                            
                            if (global.lavastate >= 4 && global.metdead[i] == 0 && (i == 23 || i == 24))
                                countArea++;
                            
                            if (global.lavastate >= 5 && global.metdead[i] == 0 && (i == 25 || i == 26))
                                countArea++;
                            
                            if (global.lavastate >= 6 && global.metdead[i] == 0 && (i == 27 || i == 28 || i == 29 || i == 30 || i == 31 || i == 32))
                                countArea++;
                            
                            if (global.lavastate >= 7 && global.metdead[i] == 0 && (i == 33 || i == 34 || i == 35 || i == 36 || i == 37 || i == 38 || i == 39 || i == 40))
                                countArea++;
                            
                            if (global.lavastate >= 8 && global.metdead[i] == 0 && i == 41)
                                countArea++;
                            
                            if (global.lavastate >= 9 && global.metdead[i] == 0 && i == 42)
                                countArea++;
                            
                            if (global.lavastate >= 10 && global.metdead[i] == 0 && (i == 43 || i == 44 || i == 45))
                                countArea++;
                        }
                    }
                    
                    if (global.lavastate < 11)
                    {
                        if (is_array(global.event) && global.event[303] == 0)
                            countLeft++;
                        
                        if (global.monstersleft != countLeft)
                            global.monstersleft = countLeft;
                        
                        if (global.monstersarea != countArea)
                            global.monstersarea = countArea;
                    }
                }
                else if (global.gamemode > 1)
                {
                    var countArea = 0;
                    var countLeft = 0;
                    
                    for (var i = 0; i < array_length_1d(global.metdead); i++)
                    {
                        if (i <= 45)
                        {
                            if (global.metdead[i] == 0)
                                countLeft++;
                            
                            if (global.metdead[i] == 0 && i != 11 && i != 23 && i != 24 && i != 41 && i != 42 && i != 43 && i != 44 && i != 45)
                                countArea++;
                            
                            if (global.metdead[i] == 0 && is_array(global.event) && global.event[109] == 1 && i == 11)
                                countArea++;
                            
                            if (global.metdead[i] == 0 && is_array(global.event) && global.event[171] == 1 && (i == 23 || i == 24))
                                countArea++;
                            
                            if (global.lavastate >= 8 && global.metdead[i] == 0 && i == 41)
                                countArea++;
                            
                            if (global.lavastate >= 9 && global.metdead[i] == 0 && i == 42)
                                countArea++;
                            
                            if (global.lavastate >= 10 && global.metdead[i] == 0 && (i == 43 || i == 44 || i == 45))
                                countArea++;
                        }
                    }
                    
                    if (global.lavastate < 11)
                    {
                        if (is_array(global.event) && global.event[303] == 0)
                            countLeft++;
                        
                        if (global.monstersleft != countLeft)
                            global.monstersleft = countLeft;
                        
                        if (global.monstersarea != countArea)
                            global.monstersarea = countArea;
                    }
                }
                
                if (resend && is_array(global.metdead))
                {
                    var size = 1024;
                    var type = 1;
                    var alignment = 1;
                    metdeadBuffer = buffer_create(size, type, alignment);
                    buffer_seek(metdeadBuffer, buffer_seek_start, 0);
                    buffer_write(metdeadBuffer, buffer_u8, 52);
                    
                    for (var i = 0; i < array_length_1d(global.metdead); i++)
                        buffer_write(metdeadBuffer, buffer_u8, global.metdead[i]);
                    
                    bufferSize = buffer_tell(metdeadBuffer);
                    buffer_seek(metdeadBuffer, buffer_seek_start, 0);
                    buffer_write(metdeadBuffer, buffer_s32, bufferSize);
                    buffer_write(metdeadBuffer, buffer_u8, 52);
                    
                    for (var i = 0; i < array_length_1d(global.metdead); i++)
                        buffer_write(metdeadBuffer, buffer_u8, global.metdead[i]);
                    
                    network_send_packet(socket, metdeadBuffer, buffer_tell(metdeadBuffer));
                    buffer_delete(metdeadBuffer);
                }
                writelog("NET 52 END");
                break;
            
            case 53:
                writelog("NET 53 START");
                var part = buffer_read(_buffer, buffer_u8);
                var resend = 0;
                if (!is_array(global.dmap) || !is_array(global.dmapPrev))
                {
                    reset_dmap();
                }
                
                if (is_array(global.dmap))
                {
                    for (var i = 0; i < array_height_2d(global.dmap); i++)
                    {
                        for (var j = 0; j < array_length_2d(global.dmap, i); j++)
                        {
                            if ((part == 1 && i < 20) || (part == 2 && i >= 20 && i < 40) || (part == 3 && i >= 40 && i < 60) || (part == 4 && i >= 60 && i < 80))
                            {
                                var receiveddmap = buffer_read(_buffer, buffer_u8);
                                
                                if (receiveddmap > global.dmap[i, j])
                                {
                                    global.dmap[i, j] = receiveddmap;
                                    global.dmapPrev[i, j] = global.dmap[i, j];
                                }
                                else if (receiveddmap < global.dmap[i, j])
                                {
                                    resend = 1;
                                }
                            }
                        }
                    }
                }
                
                if (resend && is_array(global.dmap))
                {
                    var size = 1024;
                    var type = 1;
                    var alignment = 1;
                    dmapBuffer = buffer_create(size, type, alignment);
                    buffer_seek(dmapBuffer, buffer_seek_start, 0);
                    buffer_write(dmapBuffer, buffer_u8, 53);
                    
                    for (var i = 0; i < array_height_2d(global.dmap); i++)
                    {
                        for (var j = 0; j < array_length_2d(global.dmap, i); j++)
                            buffer_write(dmapBuffer, buffer_u8, global.dmap[i, j]);
                    }
                    
                    bufferSize = buffer_tell(dmapBuffer);
                    buffer_seek(dmapBuffer, buffer_seek_start, 0);
                    buffer_write(dmapBuffer, buffer_s32, bufferSize);
                    buffer_write(dmapBuffer, buffer_u8, 53);
                    
                    for (var i = 0; i < array_height_2d(global.dmap); i++)
                    {
                        for (var j = 0; j < array_length_2d(global.dmap, i); j++)
                            buffer_write(dmapBuffer, buffer_u8, global.dmap[i, j]);
                    }
                    
                    network_send_packet(socket, dmapBuffer, buffer_tell(dmapBuffer));
                    buffer_delete(dmapBuffer);
                }
                
                if (global.ingame)
                {
                    with (oControl)
                        event_user(2);
                }
                
                if (instance_exists(oMapCursor) && surface_exists(oSS_Control.s_map))
                    surface_free(oSS_Control.s_map);
                
                writelog("NET 53 END");
                break;
            
            case 61:
                writelog("NET 61 START");
                var temp_is;
                temp_is[16] = 2;
                for (var k = 0; k <= 16; k++)
                {
                    var val = buffer_read(_buffer, buffer_u8);
                    temp_is[k] = val;
                }
                global.itemsyncs = temp_is;
                var temp_sm;
                temp_sm[7] = 0;
                for (var k = 0; k <= 7; k++)
                {
                    var val = buffer_read(_buffer, buffer_u8);
                    temp_sm[k] = val;
                }
                global.startingminors = temp_sm;
                global.awaitsyncs = 0;
                writelog("NET 61 END");
                break;
            
            case 62:
                if (global.ingame == 1)
                {
                    room_persistent = false;
                    oControl.quitgame = 0;
                    remove_persistent_objects();
                    sfx_stop_all();
                    global.ingame = 0;
                    global.darkness = 0;
                    global.newgame = 0;
                    global.revived = 1;
                    room_goto(rm_loading);
                }
                
                break;

            case 69:
                var clientID = buffer_read(_buffer, buffer_u8);
                var damage = buffer_read(_buffer, buffer_u16);
                
                for (var i = 0; i < ds_list_size(roomListData); i++)
                {
                    var arrDraw = ds_list_find_value(roomListData, i);
                    if (is_array(arrDraw))
                    {
                        var arrID = arrDraw[0];
                        
                        if (clientID == arrID)
                        {
                            var arrX = arrDraw[1];
                            var arrY = arrDraw[2];
                            var arrRoom = arrDraw[14];
                            
                            if (room == arrRoom)
                            {
                                var number = instance_create(arrX - 4, arrY - 64, oDamageNumber);
                                number.damage = damage;
                            }
                        }
                    }
                }
                break;

            case 72:
                global.winningTeam = buffer_read(_buffer, buffer_u8);
                if (is_array(global.event))
                    global.event[308] = 1;
                break;
        }
        buffer_seek(_buffer, buffer_seek_start, packetEnd);
    }
    break;
}
