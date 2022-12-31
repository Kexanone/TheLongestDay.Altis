#include "script_component.hpp"

if ((["PlayerMarker", 1] call BIS_fnc_getParamValue) isEqualTo 0) exitWith {};

// Client side pre init
if (hasInterface) then {
    TLD_playerMarker_markers = [];
    [
        {
            private _markers = [];
            {
                private _markerId = getPlayerUID _x;
                private _playerName = name _x;
                private _vehicle = vehicle _x;

                // If player on foot or driver
                if (_x isEqualTo effectiveCommander _vehicle) then {
                    if (markerShape _markerId isEqualTo "") then {
                        createMarkerLocal [_markerId, getPos _vehicle];
                    };

                    if (_x isEqualTo _vehicle) then {
                        // Handle infantry
                        if (_x getUnitTrait "Medic") then {
                            _markerId setMarkerTypeLocal "b_med";
                        } else {
                            _markerId setMarkerTypeLocal "b_inf";
                        };

                        _markerId setMarkerTextLocal (" " + _playerName);

                        switch (lifeState _x) do {
                            case "HEALTHY": {_markerId setMarkerColorLocal "colorBLUFOR"};
                            case "INJURED": {_markerId setMarkerColorLocal "ColorOrange"};
                            case "INCAPACITATED": {_markerId setMarkerColorLocal "ColorRed"};
                            default {_markerId setMarkerColorLocal "ColorGrey"};
                        };
                    } else {
                        // Handle vehicles
                        if (_vehicle isKindOf "Air") then {
                            _markerId setMarkerTypeLocal "b_air";
                        } else {
                            _markerId setMarkerTypeLocal "b_naval";
                        };

                        private _extraCounter = count crew _vehicle - 1;
                        private _vehicleName = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
                        if (_extraCounter > 0) then {
                            _markerId setMarkerTextLocal format[" %1 (%2) +%3", _vehicleName, _playerName, _extraCounter];
                        } else {
                            _markerId setMarkerTextLocal format[" %1 (%2)", _vehicleName, _playerName];
                        };

                        _markerId setMarkerColorLocal "colorBLUFOR";
                    };
                    _markers pushBack [_markerId, _vehicle];
                };
            } forEach allPlayers;

            {
                deleteMarkerLocal (_x select 0);
            } forEach (TLD_playerMarker_markers - _markers);
            TLD_playerMarker_markers = _markers;
        },
        TLD_PLAYER_MARKER_HANDLER_TIMEOUT
    ] call TLD_fnc_perFrameHandler_add;

    [
        {
            {
                (_x select 0) setMarkerPosLocal (_x select 1);
            } forEach TLD_playerMarker_markers;
        }
    ] call TLD_fnc_perFrameHandler_add;
};
