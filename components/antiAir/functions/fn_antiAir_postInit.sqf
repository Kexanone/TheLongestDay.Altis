#include "script_component.hpp"

// Server side post init
if !(isServer) exitWith {};

// Hide targets from AA while base protection is up
["TLD_baseProtection_stillEnabled", {
    params ["_entity"];
    if (_entity isKindOf "Air") then {
        // Forget as AA target
        {_x forgetTarget _entity} forEach TLD_AA_LIST;
    };
}] call TLD_fnc_eventHandler_add;

// Reveal targets outside base while radar is up
TLD_revealAATargetHandle = ["TLD_baseProtection_stillDisabled", {
    params ["_entity"];
    if (_entity isKindOf "Air") then {
        east reportRemoteTarget [_entity, TLD_DATA_LINK_TIMEOUT];
        {_x reveal [_entity, 4]} forEach TLD_AA_LIST;
    };
}] call TLD_fnc_eventHandler_add;

TLD_RADAR addEventHandler ["Killed", {
    // Deactivate target revealing
    ["TLD_baseProtection_stillDisabled", TLD_revealAATargetHandle] call TLD_fnc_eventHandler_remove;
    {
        // Deactivate SAM sites
        if (_x isKindOf TLD_SAM_CLASS) then {deleteVehicleCrew _x};
    } forEach TLD_AA_LIST;
}];
