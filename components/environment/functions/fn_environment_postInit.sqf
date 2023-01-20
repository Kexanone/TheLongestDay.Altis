#include "script_component.hpp"

// Server side post init
if (isServer) then {
    0 setOvercast (["Weather", 0] call BIS_fnc_getParamValue);
    0 setFog 0;
    forceWeatherChange;
    [{
        0 setOvercast (["Weather", 0] call BIS_fnc_getParamValue);
        0 setFog 0;
    }, TLD_OVERCAST_SETTER_TIMEOUT] call TLD_fnc_perFrameHandler_add;
};
