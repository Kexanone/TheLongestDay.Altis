#include "script_component.hpp"

params ["_vehicle"];

// Exit if handler is already running
if !(isNil {_vehicle getVariable "TLD_desertedHandle"}) exitWith {};

private _handle = _vehicle spawn {
    private _curCond = false;
    private _prevCond = false;
    waitUntil {
        _prevCond = _curCond;
        private _delay = _this getVariable "TLD_desertedDelay";
        sleep _delay;
        private _distance = _this getVariable "TLD_desertedDistance";
        private _respawnPos = _this getVariable "TLD_respawnPos";
        _curCond = (allPlayers findIf {_x distance _this < _distance}) < 0;
        _curCond = _curCond && {_respawnPos distance getPosWorld _this > 1.5};
        _prevCond && _curCond
    };
    [TLD_fnc_respawnVehicle, _this] call TLD_fnc_directCall;
};
_vehicle setVariable ["TLD_desertedHandle", _handle];
