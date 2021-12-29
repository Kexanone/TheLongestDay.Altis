#include "script_component.hpp";

// Server side post init
if !(isServer) exitWith {};

// Hide targets from AA while base protection is up
["TLD_baseProtection_stillEnabled", {
    params ["", "_entity"];
    if (_entity isKindOf "Air") then {
        // Forget as AA target
        {_x forgetTarget _entity} forEach TLD_AA_LIST;
    };
}] call TLD_fnc_eventHandler_add;

// Reveal targets outside base while radar is up
TLD_revealAaTargetHandle = ["TLD_baseProtection_stillDisabled", {
    params ["", "_entity"];
    if (_entity isKindOf "Air") then {
        east reportRemoteTarget [_entity, TLD_DATA_LINK_TIMEOUT];
        {_x reveal [_entity, 4]} forEach TLD_AA_LIST;
    };
}] call TLD_fnc_eventHandler_add;

TLD_RADAR addEventHandler ["Killed", {
    ["TLD_baseProtection_stillDisabled", TLD_revealAaTargetHandle] call TLD_fnc_eventHandler_remove;
}];
