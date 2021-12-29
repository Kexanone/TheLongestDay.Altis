#include "script_component.hpp";

["TLD_baseProtection_enable", {
    params ["", "_entity"];

    if (isNil {_entity getVariable "TLD_baseProtection_handle"}) then {
        private _handle = _entity addEventHandler ["HandleDamage", {false}];
        _entity setVariable ["TLD_baseProtection_handle", _handle];
    };
    diag_log ["Adding EH", _entity, _entity getVariable "TLD_baseProtection_fireHandle"];
    if (isNil {_entity getVariable "TLD_baseProtection_fireHandle"}) then {
        // Delete projectiles
        _handle = _entity addEventHandler ["Fired", {deleteVehicle param [6]}];
        _entity setVariable ["TLD_baseProtection_fireHandle", _handle];
    };
}] call TLD_fnc_eventHandler_add;

["TLD_baseProtection_disable", {
    params ["", "_entity"];

    private _handle = _entity getVariable "TLD_baseProtection_handle";
    if !(isNil "_handle") then {
        _entity removeEventHandler ["HandleDamage", _handle];
        _entity setVariable ["TLD_baseProtection_handle", nil];
    };

    _handle = _entity getVariable "TLD_baseProtection_fireHandle";
    if !(isNil "_handle") then {
        _entity removeEventHandler ["Fired", _handle];
        _entity setVariable ["TLD_baseProtection_fireHandle", nil];
    };
}] call TLD_fnc_eventHandler_add;

// Client side pre init
if (hasInterface) then {
    // Reassign base protection on player respawn
    ["TLD_playerRespawned", {
        params ["", "_eventArgs"];
        _eventArgs params ["_newUnit", "_oldUnit"];

        _oldUnit call TLD_fnc_baseProtectionHandler_remove;
        _newUnit call TLD_fnc_baseProtectionHandler_add;
    }] call TLD_fnc_eventHandler_add;
};

// Server side pre init
if (isServer) then {
    if (isNil "TLD_baseProtectionHandler_queue") then {
        TLD_baseProtectionHandler_queue = [];
    };

    // Reassign base protection on vehicle respawn
    ["TLD_vehicleRespawned", {
        params ["", "_eventArgs"];
        _eventArgs params ["_newVehicle", ["_oldVehicle", objNull]];

        _oldVehicle call TLD_fnc_baseProtectionHandler_remove;
        _newVehicle getVariable ["TLD_baseProtection_enabled", nil];
        _newVehicle setVariable ["TLD_baseProtection_handle", nil];
        _newVehicle setVariable ["TLD_baseProtection_fireHandle", nil];
        _newVehicle call TLD_fnc_baseProtectionHandler_add;
    }] call TLD_fnc_eventHandler_add;
};
