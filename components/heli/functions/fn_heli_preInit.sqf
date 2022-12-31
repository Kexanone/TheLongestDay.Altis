#include "script_component.hpp"

// Client side pre init
if (hasInterface) then {
    // Reassign heli actions on player respawn
    ["TLD_playerRespawned", {
        params ["_newUnit", "_oldUnit"];

        if ((["RestrictPilotSeat", 1] call BIS_fnc_getParamValue) isEqualTo 1) then {
            if (_newUnit isKindOf TLD_HELI_PILOT_CLASS) then {
                [_newUnit, TLD_USS_FREEDOM] call TLD_fnc_heli_addMaintainanceAction;
            };
        } else {
            [_newUnit, TLD_USS_FREEDOM] call TLD_fnc_heli_addMaintainanceAction;
        };

        _newUnit addEventhandler ["GetOutMan", {
            params ["_unit"];
            if (getPos _unit select 2 >= TLD_MIN_ALTITUDE_FOR_CHUTE) then {
                _unit spawn TLD_fnc_heli_chute;
            };
        }];
    }] call TLD_fnc_eventHandler_add;
};

// Server side pre init
if (isServer) then {
    // Reassign heli action and customizations on heli respawn
    ["TLD_vehicleRespawned", {
        params ["_newHeli"];
    
        // Set textures
        private _texturing = switch (typeOf _newHeli) do {
            case "B_Heli_Transport_01_F": {["Green", 1]};
            case "B_Heli_Transport_03_unarmed_F": {["Green", 1]};
            case "B_T_VTOL_01_infantry_F": {["Blue", 1],};
            default {[]};
        };
        [_newHeli, _texturing, true] call BIS_fnc_initVehicle;

        // Add arsenal
        _newHeli setVariable ["bis_fnc_arsenal_action", nil, true]; // Fixes arsenal on respawn
        ["AmmoboxInit", [_newHeli, true]] call BIS_fnc_arsenal;

        if ((["RestrictPilotSeat", 1] call BIS_fnc_getParamValue) isEqualTo 1) then {
            // Restrict driver seat to pilots
            ["TLD_enableCopilot", [_newHeli, false], _newHeli] call TLD_fnc_globalEvent;
            _newHeli addEventHandler ["GetIn", {
                params ["_heli", "_role", "_unit"];
                [_heli, _role, _unit] remoteExecCall ["TLD_fnc_heli_restrictDriver", _unit];
            }];
            _newHeli addEventHandler ["SeatSwitched", {
                params ["_heli", "_unit"];
                (assignedVehicleRole _unit) params ["_role", ""];
                [_heli, _role, _unit] remoteExecCall ["TLD_fnc_heli_restrictDriver", _unit];
            }];
        };
    }] call TLD_fnc_eventHandler_add;
};
