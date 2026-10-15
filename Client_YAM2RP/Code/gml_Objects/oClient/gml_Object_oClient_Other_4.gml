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

// Co-Op Difficulty Rebalance (User Decision 3D)
scr_coop_update_scaling();

if (global.coop_enemy_mult > 1.0)
{
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
