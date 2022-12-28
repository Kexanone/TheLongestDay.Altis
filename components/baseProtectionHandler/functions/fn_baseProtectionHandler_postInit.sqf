#include "script_component.hpp"

// Server side post init
if !(isServer) exitWith {};

// Base protection per frame handler
[
    {
        {
            private _entity = _x;
            private _protectionEnabled = _entity getVariable ["TLD_baseProtection_enabled", false];
            if (_protectionEnabled) then {
                if (TLD_USS_FREEDOM distance2D _entity > TLD_BASE_PROTECTION_RADIUS) then {
                    // Turn off protection
                    ["TLD_baseProtection_disable", _entity, _entity] call TLD_fnc_remoteEvent;
                    ["TLD_baseProtection_stillDisabled", _entity] call TLD_fnc_localEvent;
                    _entity setVariable ["TLD_baseProtection_enabled", false];

                    if (isPlayer _entity && {_entity isKindOf "Man"}) then {
                        ["TLD_localizedHint", "STR_TLD_baseProtection_disabled", _entity] call TLD_fnc_remoteEvent;
                    };
                } else {
                    ["TLD_baseProtection_stillEnabled", _entity] call TLD_fnc_localEvent;
                };
            } else {
                if (TLD_USS_FREEDOM distance2D _entity <= TLD_BASE_PROTECTION_RADIUS) then {
                    // Turn on protection
                    ["TLD_baseProtection_enable", _entity, _entity] call TLD_fnc_remoteEvent;
                    ["TLD_baseProtection_stillEnabled", _entity] call TLD_fnc_localEvent;
                    _entity setVariable ["TLD_baseProtection_enabled", true];

                    if (isPlayer _entity && {_entity isKindOf "Man"}) then {
                        ["TLD_localizedHint", "STR_TLD_baseProtection_enabled", _entity] call TLD_fnc_remoteEvent;
                    };
                } else {
                    ["TLD_baseProtection_stillDisabled", _entity] call TLD_fnc_localEvent;
                };
            };
        } forEach TLD_baseProtectionHandler_queue;
    },
    TLD_BASE_PROTECTION_HANDLER_TIMEOUT
] call TLD_fnc_perFrameHandler_add;
