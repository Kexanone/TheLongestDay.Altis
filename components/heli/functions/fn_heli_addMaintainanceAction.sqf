#include "script_component.hpp"

params ["_unit", "_base"];
[
    _unit,
    "Maintainance", 
    "data\images\holdAction_wrench_ca.paa", 
    "data\images\holdAction_wrench_ca.paa", 
    "(" + str _base + " distance2D vehicle _this < 180) && {speed vehicle _this < 0.3} && {_this isNotEqualTo vehicle _this} && {_this isEqualTo driver vehicle _this} && {isTouchingGround vehicle _this || vehicle _this getVariable [""TLD_maintainance_vehPosATL"", [0,0,0]] distance getPosATL vehicle _this < 1}", 
    "(_caller isNotEqualTo vehicle _caller) && {_caller isEqualTo driver vehicle _caller} && {!(vehicle _caller getVariable [""TLD_maintainance_failed"", false])} && {vehicle _caller getVariable [""TLD_maintainance_vehPosATL"", [0,0,0]] distance getPosATL vehicle _caller < 1}",
    {
        params ["_unit"];
        private _vehicle = vehicle _unit;
        _vehicle setVariable ["TLD_maintainance_failed", false];
        _vehicle setVariable ["TLD_maintainance_vehPosATL", getPosATL _vehicle];
    }, 
    {
        params ["_unit", "", "", "_params", "_tick", "_maxTick"];
        _params params ["_base"];
        private _vehicle = vehicle _unit;
        if (_tick >= 3) then
        {
            private _curFuel = fuel _vehicle;
            if (_curFuel < 1) then
            {
                private _updatedFuel = _curFuel + TLD_REFUEL_RATE * _stepDuration;
                if (_updatedFuel > 1) then {_updatedFuel = 1};
                _vehicle setFuel _updatedFuel;
            };
            private _curDamage = damage _vehicle;
            if (_curDamage > 0) then
            {
                private _updatedDamage = _curDamage - TLD_REPAIR_RATE * _stepDuration;
                if (_updatedDamage < 0) then {_updatedDamage = 0};
                _vehicle setDamage _updatedDamage;
            };
            private _currentMagIdx = _vehicle getVariable ["TLD_maintainance_currentMagIdx", 0];
            private _timeForNextMag = _vehicle getVariable ["TLD_maintainance_timeForNextMag", 0];
            private _magCnt = _vehicle getVariable ["TLD_maintainance_magCnt", 0];
            if (_currentMagIdx < _magCnt && {time >= _timeForNextMag}) then
            {
                private _magazineData = _vehicle getVariable ["TLD_maintainance_magazineData", []];
                private _maintainanceHints = _vehicle getVariable ["TLD_maintainance_maintainanceHints", ""];
                while {_currentMagIdx < _magCnt && {time >= _timeForNextMag}} do
                {
                    (_magazineData select _currentMagIdx) params ["_magClass", "_magDisplayName", "_maxAmmoCnt", "_turretPath", "_pylonIdx"];
                    if (_pylonIdx >= 0) then
                    {
                        _vehicle setAmmoOnPylon [_pylonIdx, _maxAmmoCnt];
                    }
                    else
                    {
                        _vehicle setMagazineTurretAmmo [_magClass, _maxAmmoCnt, _turretPath];
                    };
                    _timeForNextMag = TLD_REARM_DURATION_PER_MAG + time;
                    _currentMagIdx = _currentMagIdx + 1;
                    _maintainanceHints = _maintainanceHints + format ["Loaded %1<br />", _magDisplayName];
                };
                hint parseText _maintainanceHints;
                playSound "FD_CP_Clear_F";
                _vehicle setVariable ["TLD_maintainance_maintainanceHints", _maintainanceHints];
                _vehicle setVariable ["TLD_maintainance_timeForNextMag", _timeForNextMag];
                _vehicle setVariable ["TLD_maintainance_currentMagIdx", _currentMagIdx];
            };
        };
        if (_tick == 3) then
        {
            if !(_vehicle getVariable ["TLD_maintainance_failed", false]) then
            {
                private _refuelDuration = (1 - fuel _vehicle) / TLD_REFUEL_RATE;
                private _repairDuration = (damage _vehicle) / TLD_REPAIR_RATE;
                private _rearmDuration = 0;
                private _magazineData = [];
                private _pylonMagazines = getPylonMagazines _vehicle;
                private _pylonMagazinesCnt = count _pylonMagazines;
                {
                    _x params ["_magClass", "_turretPath", "_curAmmoCnt"];
                    private _maxAmmoCnt = getNumber (configfile >> "CfgMagazines" >> _magClass >> "count");
                    private _magDisplayName = getText (configfile >> "CfgMagazines" >> _magClass >> "displayName");
                    if (_magDisplayName == "") then {_magDisplayName = getText (configfile >> "CfgMagazines" >> _magClass >> "ammo")};
                    if (_maxAmmoCnt > _curAmmoCnt) then
                    {
                        _rearmDuration = _rearmDuration + TLD_REARM_DURATION_PER_MAG;
                        private _pylonIdx = -1;
                        for "_i" from 1 to _pylonMagazinesCnt do
                        {
                            if (_pylonMagazines select (_i-1) == _magClass && {_vehicle ammoOnPylon _i == _curAmmoCnt}) exitWith
                            {
                                _pylonIdx = _i;
                            };
                        };
                        if (_pylonIdx >= 0) then {_pylonMagazines set [(_pylonIdx-1), ""]};
                        _magazineData pushBack [_magClass, _magDisplayName, _maxAmmoCnt, _turretPath, _pylonIdx];
                    };
                } forEach magazinesAllTurrets _vehicle;
                _vehicle setVariable ["TLD_maintainance_magazineData", _magazineData];
                _vehicle setVariable ["TLD_maintainance_magCnt", count _magazineData];
                private _duration = selectMax [_refuelDuration, _repairDuration , _rearmDuration];
                // reset the step duration variable in BIS_fnc_holdActionAdd
                _stepDuration = _duration / (_maxTick - 3);
                private _maintainanceHints = "Starting maintainance ...<br />";
                hint parseText _maintainanceHints;
                _vehicle setVariable ["TLD_maintainance_maintainanceHints", _maintainanceHints];
            };
        };
    }, 
    {
        params["_unit"];
        private _vehicle = vehicle _unit;   
        _vehicle setVehicleAmmo 1;
        _vehicle setFuel 1;
        _vehicle setDamage 0;
        private _maintainanceHints = _vehicle getVariable ["TLD_maintainance_maintainanceHints", ""];
        hint parseText (_maintainanceHints + "Maintainance completed!");
        playSound "FD_Finish_F";
        _vehicle setVariable ["TLD_maintainance_failed", nil];
        _vehicle setVariable ["TLD_maintainance_currentMagIdx", nil];
        _vehicle setVariable ["TLD_maintainance_magazineData", nil];
        _vehicle setVariable ["TLD_maintainance_magCnt", nil];
        _vehicle setVariable ["TLD_maintainance_timeForNextMag", nil];
        _vehicle setVariable ["TLD_maintainance_maintainanceHints", nil];
        _vehicle setVariable ["TLD_maintainance_vehPosATL", nil];
    }, 
    {
        params["_unit"];
        private _vehicle = vehicle _unit;
        private _maintainanceHints = _vehicle getVariable ["TLD_maintainance_maintainanceHints", ""];
        hint parseText (_maintainanceHints + "Cancelled maintainance!");
        playSound "FD_Start_F";
        _vehicle setVariable ["TLD_maintainance_failed", nil];
        _vehicle setVariable ["TLD_maintainance_currentMagIdx", nil];
        _vehicle setVariable ["TLD_maintainance_magazineData", nil];
        _vehicle setVariable ["TLD_maintainance_magCnt", nil];
        _vehicle setVariable ["TLD_maintainance_timeForNextMag", nil];
        _vehicle setVariable ["TLD_maintainance_maintainanceHints", nil];
        _vehicle setVariable ["TLD_maintainance_vehPosATL", nil];
    }, 
    [_base], 
    24, 
    500, 
    false, 
    false 
] call BIS_fnc_holdActionAdd;
