#include "..\script_component.hpp"

#define TLD_NEXT_STAGE_DELAY 30
#define TLD_END_DELAY 72

#define TLD_STAGE_ONE_TASKS ["TLD_task_destroyRadar", "TLD_task_destroyFactory", "TLD_task_destroyXians"]
#define TLD_FACTORY_PARTS [TLD_FACTORY_PART_1, TLD_FACTORY_PART_2, TLD_FACTORY_PART_3, TLD_FACTORY_PART_4, TLD_FACTORY_PART_5, TLD_FACTORY_PART_6, nearestBuilding [6213, 16277, 0]]
#define TLD_XIANS [TLD_XIAN_1, TLD_XIAN_2, TLD_XIAN_3, TLD_XIAN_4]

#define TLD_STAGE_TWO_TASKS ["TLD_task_killCollabs", "TLD_task_destroyComms", "TLD_task_destroyVarsuks"]
#define TLD_COMMS [TLD_COMM_1, TLD_COMM_2, TLD_COMM_3, TLD_COMM_4]
#define TLD_VARSUKS [TLD_VARSUK_1, TLD_VARSUK_2, TLD_VARSUK_3, TLD_VARSUK_4]

#define TLD_STAGE_THREE_TASKS ["TLD_task_freeKavala", "TLD_task_captureAirbase"]
