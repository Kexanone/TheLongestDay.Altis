#include "script_component.hpp"

// Client side pre init
if (hasInterface) then {
    // Reassign heli actions on player respawn
    ["TLD_playerRespawned", {
        params ["", "_eventArgs"];
        _eventArgs params ["_newUnit", "_oldUnit"];

        if (_newUnit isKindOf TLD_HELI_PILOT_CLASS) then {
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
        params ["", "_eventArgs"];
        _eventArgs params ["_newHeli", ["_oldHeli", objNull]];
    
        // Set textures
        private _texturing = switch (typeOf _newHeli) do {
            case "B_Heli_Transport_01_F": {["Green", 1]};
            case "B_Heli_Transport_03_unarmed_F": {["Green", 1]};
            case "B_T_VTOL_01_infantry_F": {["Blue", 1],};
            default {[]};
        };
        [_newHeli, _texturing, true] call BIS_fnc_initVehicle;

        // Restrict driver seat to pilots
        [_newHeli, false] remoteExecCall ["enableCopilot", 0, _newHeli];
        _newHeli addEventHandler ["GetIn", {
            params ["_heli", "_role", "_unit"];
            [_heli, _role, _unit] call TLD_fnc_heli_restrictDriver;
        }];
        _newHeli addEventHandler ["SeatSwitched", {
            params ["_heli", "_unit"];
            (assignedVehicleRole _unit) params ["_role", ""];
            [_heli, _role, _unit] call TLD_fnc_heli_restrictDriver;
        }];
    }] call TLD_fnc_eventHandler_add;
};
