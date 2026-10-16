target = 0;

// 1. Check local player (oCharacter)
if (instance_exists(oCharacter))
{
    if (argument1 == 1)
    {
        if (distance_to_object(oCharacter) <= argument0)
            target = 1;
    }
    else if (argument1 == 0)
    {
        if (distance_to_object(oCharacter) <= argument0)
        {
            if (facing == 1 && x < oCharacter.x)
                target = 1;
            if (facing == -1 && x > oCharacter.x)
                target = 1;
        }
    }
}

// 2. In co-op, if local player is not in range, check other players in room
if (target == 0 && instance_exists(oClient))
{
    if (oClient.connected && ds_list_size(oClient.roomListData) > 0)
    {
        var _numP = ds_list_size(oClient.roomListData);
        for (var _p = 0; _p < _numP; _p++)
        {
            var _pData = ds_list_find_value(oClient.roomListData, _p);
            if (is_array(_pData))
            {
                var _px = _pData[1];
                var _py = _pData[2];
                var _pDist = point_distance(x, y, _px, _py);
                if (argument1 == 1)
                {
                    if (_pDist <= argument0)
                    {
                        target = 1;
                        break;
                    }
                }
                else if (argument1 == 0)
                {
                    if (_pDist <= argument0)
                    {
                        if (facing == 1 && x < _px)
                        {
                            target = 1;
                            break;
                        }
                        if (facing == -1 && x > _px)
                        {
                            target = 1;
                            break;
                        }
                    }
                }
            }
        }
    }
}
