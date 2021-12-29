_targ       = _this select 0;   // camera target
_alt        = _this select 1;   // altitude
_rad        = _this select 2;   // radius
_ang        = _this select 3;   // relative start angle
_omega      = _this select 4;   // angular velocity
_duration   = _this select 5;   // duration of camera view

("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];
sleep 0.1;
CutText ["", "BLACK IN", 1];
("BIS_layerInterlacing" call BIS_fnc_rscLayer) cutRsc ["RscInterlacing", "PLAIN"];
enableEnvironment false;

_ppColor = ppEffectCreate ["colorCorrections", 1999];
_ppColor ppEffectEnable true;
_ppColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [0.8, 0.8, 0.8, 0.65], [1, 1, 1, 1.0]];
_ppColor ppEffectCommit 0;

_ppGrain = ppEffectCreate ["filmGrain", 2012];
_ppGrain ppEffectEnable true;
_ppGrain ppEffectAdjust [0.1, 1, 1, 0, 1];
_ppGrain ppEffectCommit 0;

UAV_cam = "camera" camcreate [0,0,0];
UAV_cam cameraeffect ["internal", "back"];
UAV_cam camsettarget _targ;
UAV_cam camsetrelpos [_rad * (cos _ang), _rad * (sin _ang), _alt];
UAV_cam camcommit 0;

[] spawn {
    private ["_sound", "_sduration"];
    _sound = "UAV_loop";
    _sduration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");
    //playSound 'FD_Start_F';
    while {!(isNull UAV_cam)} do {
        UAV_cam say _sound;
        sleep _sduration;
    };
};
[] spawn {
    while {!(isNull UAV_cam)} do {
        private ["_sound", "_sduration"];
        _sound = format ["UAV_0%1", round (1 + random 8)];
        _sduration = getNumber (configFile >> "CfgSounds" >> _sound >> "duration");
        UAV_cam say _sound;
        sleep (_sduration + (5 + random 5));
    };
};


_startTime = time;
while {time < (_startTime + _duration)} do {
    //playSound 'FD_Start_F';
    WaitUntil {(camCommitted UAV_cam) OR (isNull UAV_cam)};
    If (_omega >= 0) then {_ang = _ang + 0.5;} else {_ang = _ang - 0.5;};
    UAV_cam camsetrelpos [_rad * (cos _ang), _rad * (sin _ang), _alt];
    UAV_cam camcommit (0.5 / (abs _omega));
};

//end UAV effect

{
    private ["_layer"];
    _layer = _x call BIS_fnc_rscLayer;
    _layer cutText ["", "PLAIN"];
} forEach ["BIS_layerEstShot", "BIS_layerStatic", "BIS_layerInterlacing"];

("BIS_layerStatic" call BIS_fnc_rscLayer) cutRsc ["RscStatic", "PLAIN"];
enableEnvironment true;
ppEffectDestroy _ppColor;
ppEffectDestroy _ppGrain;
sleep 0.1;
CutText ["", "BLACK IN", 1];
UAV_cam cameraeffect ["terminate", "back"];
CamDestroy UAV_cam;
