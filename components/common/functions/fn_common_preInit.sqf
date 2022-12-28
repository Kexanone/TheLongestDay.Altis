#include "script_component.hpp"

["TLD_addCuratorEditableObjects", {
    {_x addCuratorEditableObjects [_this, true]} forEach allCurators;
}] call TLD_fnc_eventHandler_add;

["TLD_allowDamage", {
    params ["_unit", "_allow"];
    _unit allowDamage _allow;
}] call TLD_fnc_eventHandler_add;

["TLD_assignCurator", {
    params ["_unit", "_curatorLogic"];
    unassignCurator _curatorLogic;
    _unit assignCurator _curatorLogic;
}] call TLD_fnc_eventHandler_add;

["TLD_enableCopilot", {
    params ["_unit", "_enable"];
    _unit enableCopilot _enable;
}] call TLD_fnc_eventHandler_add;

["TLD_localizedHint", {
    params ["_identifier"];
    hint localize _identifier;
}] call TLD_fnc_eventHandler_add;

["TLD_playMusic", {
    params ["_name", ["_start", 0]];
    playMusic [_name, _start];
}] call TLD_fnc_eventHandler_add;

["TLD_setIdentity", {
    params ["_unit", "_identity"];
    _unit setIdentity _identity;
}] call TLD_fnc_eventHandler_add;
