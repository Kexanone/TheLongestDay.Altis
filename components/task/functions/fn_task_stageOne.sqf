#include "script_component.hpp"

["TLD_stageOne_init"] call TLD_fnc_localEvent;

[
    west,
    "TLD_task_stageOne",
    "TLD_task_stageOne",
    objNull,
    "CREATED",
    1,
    true,
    "move1",
    false
] call BIS_fnc_taskCreate;
TLD_task_stageOne_handle = ["TLD_task_stateUpdated", {
    if (TLD_STAGE_ONE_TASKS findIf {_x call BIS_fnc_taskState isNotEqualTo "SUCCEEDED"} < 0) then {
        ["TLD_task_stateUpdated", TLD_task_stageOne_handle] call TLD_fnc_eventHandler_remove;
        ["TLD_task_stageOne", "SUCCEEDED"] call TLD_fnc_task_updateState;
        [TLD_fnc_task_stageTwo, TLD_NEXT_STAGE_DELAY] call TLD_fnc_waitAndExecute;
    };
}] call TLD_fnc_eventHandler_add;

[
    west,
    ["TLD_task_destroyRadar", "TLD_task_stageOne"],
    "TLD_task_destroyRadar",
    getMarkerPos "TLD_destroyRadar",
    "CREATED",
    1,
    true,
    "destroy",
    false
] call BIS_fnc_taskCreate;
TLD_RADAR addEventHandler ["Killed", {["TLD_task_destroyRadar", "SUCCEEDED"] call TLD_fnc_task_updateState}];

[
    west,
    ["TLD_task_destroyFactory", "TLD_task_stageOne"],
    "TLD_task_destroyFactory",
    getMarkerPos "TLD_destroyFactory",
    "CREATED",
    0,
    true,
    "destroy",
    false
] call BIS_fnc_taskCreate;
{
    private _handle = _x  addEventHandler ["Killed", {
        ["TLD_task_destroyFactory", "SUCCEEDED"] call TLD_fnc_task_updateState;
        {
            private _handle = _x getVariable "TLD_task_killedHandle";
            _x removeEventHandler ["Killed", _handle];
            _x setDamage 1;
        } forEach TLD_FACTORY_PARTS;
    }];
    _x setVariable ["TLD_task_killedHandle", _handle];

} forEach TLD_FACTORY_PARTS;

[
    west,
    ["TLD_task_destroyXians", "TLD_task_stageOne"],
    "TLD_task_destroyXians",
    getMarkerPos "TLD_destroyXians",
    "CREATED",
    0,
    true,
    "destroy",
    false
] call BIS_fnc_taskCreate;
{
    private _handle = _x  addEventHandler ["Killed", {
        if (TLD_XIANS findIf {alive _x} >= 0) exitWith {};
        ["TLD_task_destroyXians", "SUCCEEDED"] call TLD_fnc_task_updateState;
        {
            private _handle = _x getVariable "TLD_task_killedHandle";
            _x removeEventHandler ["Killed", _handle];
        } forEach TLD_XIANS;
    }];
    _x setVariable ["TLD_task_killedHandle", _handle];

} forEach TLD_XIANS;
