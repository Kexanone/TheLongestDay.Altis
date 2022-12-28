#include "script_component.hpp"

["TLD_baseProtection_enable", {
    params ["_entity"];
    switch (true) do {
        case (_entity isKindOf "Man"): {
            if (isNil {_entity getVariable "TLD_baseProtection_fireHandle"}) then {
                // Delete projectiles
                _handle = _entity addEventHandler ["FiredMan", {deleteVehicle param [6]}];
                _entity setVariable ["TLD_baseProtection_fireHandle", _handle];
            };
            ["TLD_allowDamage", [_entity, false]] call TLD_fnc_localEvent;
        };
        case (_entity isKindOf "AllVehicles"): {
            ["TLD_allowDamage", [_entity, false], _entity] call TLD_fnc_globalEvent;
        };
    };
}] call TLD_fnc_eventHandler_add;

["TLD_baseProtection_disable", {
    params ["_entity"];

    switch (true) do {
        case (_entity isKindOf "Man"): {
            private _handle = _entity getVariable "TLD_baseProtection_fireHandle";
            if !(isNil "_handle") then {
                _entity removeEventHandler ["FiredMan", _handle];
                _entity setVariable ["TLD_baseProtection_fireHandle", nil];
            };
            ["TLD_allowDamage", [_entity, true]] call TLD_fnc_localEvent;
        };
        case (_entity isKindOf "AllVehicles"): {
            ["TLD_allowDamage", [_entity, true], _entity] call TLD_fnc_globalEvent;
        };
    };
}] call TLD_fnc_eventHandler_add;

// Client side pre init
if (hasInterface) then {
    // Reassign base protection on player respawn
    ["TLD_playerRespawned", {
        params ["_newUnit", "_oldUnit"];

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
        params ["_newVehicle", ["_oldVehicle", objNull]];

        _oldVehicle call TLD_fnc_baseProtectionHandler_remove;
        _newVehicle setVariable ["TLD_baseProtection_enabled", nil];
        _newVehicle call TLD_fnc_baseProtectionHandler_add;
    }] call TLD_fnc_eventHandler_add;
};
