
                ifndef _CONST_GAME_WORLD_CAMERA_
                define _CONST_GAME_WORLD_CAMERA_
SCR_CAMERA_CENTER_X EQU SCR_WORLD_POS_X + (((SCR_WORLD_SIZE_X << 1) - 1) -  (2 * 2) * 2) >> 1
SCR_CAMERA_CENTER_Y EQU SCR_WORLD_POS_Y + ((SCR_WORLD_SIZE_Y << 1) -  (2 * 2) * 2) >> 1

                endif ; ~_CONST_GAME_WORLD_CAMERA_