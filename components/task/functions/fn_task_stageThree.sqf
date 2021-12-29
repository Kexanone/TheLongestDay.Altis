#include "script_component.hpp"

["TLD_stageThree_init"] call TLD_fnc_localEvent;

[
    west,
    "TLD_task_stageThree",
    "TLD_task_stageThree",
    objNull,
    "CREATED",
    1,
    true,
    "move3",
    false
] call BIS_fnc_taskCreate;
["TLD_task_stateUpdated", {
    params ["", "", "_handle"];
    if (TLD_STAGE_THREE_TASKS findIf {_x call BIS_fnc_taskState isNotEqualTo "SUCCEEDED"} < 0) then {
        ["TLD_task_stateUpdated", _handle] call TLD_fnc_eventHandler_remove;
        ["TLD_task_stageThree", "SUCCEEDED"] call TLD_fnc_task_updateState;
        "LeadTrack01a_F" remoteExecCall ["playMusic", 0];
        [{"EveryoneWon" call BIS_fnc_endMissionServer}, TLD_END_DELAY] call TLD_fnc_waitAndExecute;
    };
}] call TLD_fnc_eventHandler_add;

"TLD_freeKavala" setMarkerAlpha 1;
[
    west,
    ["TLD_task_freeKavala", "TLD_task_stageThree"],
    "TLD_task_freeKavala",
    getMarkerPos "TLD_freeKavala",
    "CREATED",
    1,
    true,
    "attack",
    false
] call BIS_fnc_taskCreate;

"TLD_captureAirbase" setMarkerAlpha 1;
[
    west,
    ["TLD_task_captureAirbase", "TLD_task_stageThree"],
    "TLD_task_captureAirbase",
    getMarkerPos "TLD_captureAirbase",
    "CREATED",
    0,
    true,
    "attack",
    false
] call BIS_fnc_taskCreate;
