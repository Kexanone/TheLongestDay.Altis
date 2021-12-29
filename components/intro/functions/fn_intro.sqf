playMusic "ArmA2_Reforger";
//[getPos TLD_USS_FREEDOM, 200, 500, 270, 3, 25] spawn TLD_fnc_intro_uavCam;

[{
    [
        [
            [localize "STR_TLD_briefing_title", "<t size='1.1' font='PuristaBold'>%1</t><br/>", 5],
            ["July 2033", "<t size='1.1' font='PuristaBold'>%1</t><br/>", 5],
            [" by Kex", "<t size='1.1' font='PuristaBold'>%1</t><br/>", 30]
        ],
        -safezoneX, 0.85, "<t color='#FFFFFFFF' size='2' align='right'>%1</t>"
    ] spawn BIS_fnc_typeText;
    [{
        date apply {
            if (_x < 10) then {format ["0%1", _x]} else {_x}
        } params ["_year", "_month", "_day", "_hour", "_min"];
        _date = format ["%1-%2-%3", _year, _month, _day];
        _time = format ["%1:%2", _hour, _min];

        [
            [
                [_date, "<t size='1.1' font='PuristaMedium'>%1</t>", 0],
                [_time, "<t size='1.1' font='PuristaBold'>%1</t><br/>", 5],
                [localize "STR_TLD_marker_ussFreedom", "<t size='1.1' font='PuristaBold'>%1</t><br/>", 5],
                [localize "STR_TLD_briefing_northWestAltis", "<t size='1.1'>%1</t><br/>", 30]
            ],
            -safezoneX,0.85,"<t color='#FFFFFFFF' size='2' align='right'>%1</t>"
        ] spawn BIS_fnc_typeText;
    }, 13] call TLD_fnc_waitAndExecute;
}, 2] call TLD_fnc_waitAndExecute;
