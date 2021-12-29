#include "script_component.hpp";

// Server side pre init
if !(isServer) exitWith {};

["TLD_stageOne_init", {
    params ["", "", "_handle"];
    [] call TLD_fnc_spawn_stageOne;
    ["TLD_stageOne_init", _handle] call TLD_fnc_eventHandler_remove;
}] call TLD_fnc_eventHandler_add;

["TLD_stageTwo_init", {
    params ["", "", "_handle"];
    [] call TLD_fnc_spawn_stageTwo;
    ["TLD_stageTwo_init", _handle] call TLD_fnc_eventHandler_remove;
}] call TLD_fnc_eventHandler_add;

["TLD_stageThree_init", {
    params ["", "", "_handle"];
    [] call TLD_fnc_spawn_stageThree;
    ["TLD_stageThree_init", _handle] call TLD_fnc_eventHandler_remove;
}] call TLD_fnc_eventHandler_add;
