#include "script_component.hpp"

["TLD_stageTwo_init"] call TLD_fnc_localEvent;

[
    west,
    "TLD_task_stageTwo",
    "TLD_task_stageTwo",
    objNull,
    "CREATED",
    1,
    true,
    "move2",
    false
] call BIS_fnc_taskCreate;
TLD_task_stageTwo_handle = ["TLD_task_stateUpdated", {
    if (TLD_STAGE_TWO_TASKS findIf {_x call BIS_fnc_taskState isNotEqualTo "SUCCEEDED"} < 0) then {
        ["TLD_task_stateUpdated", TLD_task_stageTwo_handle] call TLD_fnc_eventHandler_remove;
        ["TLD_task_stageTwo", "SUCCEEDED"] call TLD_fnc_task_updateState;
        // [TLD_fnc_task_stageThree, TLD_NEXT_STAGE_DELAY] call TLD_fnc_waitAndExecute;
        ["TLD_playMusic", "LeadTrack01a_F"] call TLD_fnc_globalEvent;
        [{"EveryoneWon" call BIS_fnc_endMissionServer}, TLD_END_DELAY] call TLD_fnc_waitAndExecute;
    };
}] call TLD_fnc_eventHandler_add;

"TLD_killCollabs" setMarkerAlpha 1;
[
    west,
    ["TLD_task_killCollabs", "TLD_task_stageTwo"],
    "TLD_task_killCollabs",
    getMarkerPos "TLD_killCollabs",
    "CREATED",
    1,
    true,
    "kill",
    false
] call BIS_fnc_taskCreate;
TLD_STAVRO addEventHandler ["Killed", {["TLD_task_killCollabs", "SUCCEEDED"] call TLD_fnc_task_updateState}];

"TLD_destroyComms" setMarkerAlpha 1;
[
    west,
    ["TLD_task_destroyComms", "TLD_task_stageTwo"],
    "TLD_task_destroyComms",
    getMarkerPos "TLD_destroyComms",
    "CREATED",
    0,
    true,
    "destroy",
    false
] call BIS_fnc_taskCreate;
{
    private _handle = _x  addEventHandler ["Killed", {
        if (TLD_COMMS findIf {alive _x} >= 0) exitWith {};
        ["TLD_task_destroyComms", "SUCCEEDED"] call TLD_fnc_task_updateState;
    }];
    _x setVariable ["TLD_killedHandle", _handle];

} forEach TLD_COMMS;

"TLD_destroyVarsuks" setMarkerAlpha 1;
[
    west,
    ["TLD_task_destroyVarsuks", "TLD_task_stageTwo"],
    "TLD_task_destroyVarsuks",
    getMarkerPos "TLD_destroyVarsuks",
    "CREATED",
    0,
    true,
    "destroy",
    false
] call BIS_fnc_taskCreate;
{
    private _handle = _x  addEventHandler ["Killed", {
        if (TLD_VARSUKS findIf {alive _x} >= 0) exitWith {};
        ["TLD_task_destroyVarsuks", "SUCCEEDED"] call TLD_fnc_task_updateState;
    }];
    _x setVariable ["TLD_killedHandle", _handle];

} forEach TLD_VARSUKS;
