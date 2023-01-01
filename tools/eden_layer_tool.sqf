// [] call ELT_fnc_dumpSpawnPosLayers;
// [] call ELT_fnc_loadSpawnPosLayers;

ELT_fnc_get3DENLayer = {
	params ["_name"];
	private _layerIds = all3DENEntities select 6;
	private _layerNames = _layerIds apply {(_x get3DENAttribute "name") select 0};
	private _idx = _layerNames find _name;
	if (_idx >= 0) then {
		_layerIds select _idx // Return value
	} else {
		nil // Return value
	};
};

ELT_fnc_dumpSpawnPosLayers = {
	// Dump "Unit Spawn" layers to clipboard and delete them in Eden
	private _out = [];
	{
		private _parentLayerId = _x;
		private _parentLayerName = (_x get3DENAttribute "name") select 0;
		if ("TLD_" isEqualTo (_parentLayerName select [0, 4])) then {
			private _entities = get3DENLayerEntities _parentLayerId;
			private _idx = _entities findIf {_x isEqualType 0 && {_x get3DENAttribute "name" isEqualTo ["Unit Spawn"]}};
			if (_idx >= 0) then {
				private _spawnPosLayerId = _entities select _idx;
				private _spawnPosLayerEntities = get3DENLayerEntities _spawnPosLayerId;
				private _subout = [];
				{
					private _subsubout = [];
					private _unitClasses = [];
					private _entities = get3DENLayerEntities _x;
					{
						{
							private _unit = vehicle _x;
							if (unitPos _unit isEqualTo "Auto") then {
								_subsubout pushBackUnique format ["            [%1, %2]", (_unit get3DENAttribute "position") select 0, (_unit get3DENAttribute "rotation") select 0 select 2];
							} else {
								_subsubout pushBackUnique format ["            [%1, %2, ""%3""]", (_unit get3DENAttribute "position") select 0, (_unit get3DENAttribute "rotation") select 0 select 2, unitPos _unit];
							};
							_unitClasses pushBackUnique typeOf _unit;
						} forEach units _x;
					} forEach _entities;
					_subout pushBack (format ["        [%1, [", _unitClasses] + endl + (_subsubout joinString ("," + endl)) + endl + "        ]]");
				} forEach _spawnPosLayerEntities;
				delete3DENEntities _spawnPosLayerEntities;
				remove3DENLayer _spawnPosLayerId;
				_out pushBack (format["    [""%1"", [", _parentLayerName] + endl + (_subout joinString ("," + endl)) + endl + "    ]]");
			};
		};
	} forEach (all3DENEntities select 6);
	copyToClipboard ("[" + endl + (_out joinString ("," + endl)) + endl + "]");
};


ELT_fnc_loadSpawnPosLayers = {
	// Load "Unit Spawn" layers from clipboard
	private _layers = parseSimpleArray copyFromClipboard;
	{
		_x params ["_parentLayerName", "_sublayers"];
		private _parentLayerId = [_parentLayerName] call ELT_fnc_get3DENLayer;
		private _spawnPosLayerId = _parentLayerId add3DENLayer "Unit Spawn";
		{
			private _groupLayerId = _spawnPosLayerId add3DENLayer format ["Group %1", _forEachIndex];
			private _unit = objNull;
			_x params ["_unitClasses", "_locations"];
			{
				_x params ["_pos", "_dir", ["_unitPos", "Auto"]];
				_unit = (group _unit) create3DENEntity ["Object", _unitClasses select (_forEachIndex % count _unitClasses), _pos];
				_unit set3DENAttribute ["position", _pos];
				_unit set3DENAttribute ["rotation", [0, 0, _dir]];
				_unit set3DENAttribute ["unitpos", ["UP","MIDDLE","DOWN","AUTO"] find toUpper _unitPos];
				_unit set3DENLayer _groupLayerId;
			} forEach _locations;
		} forEach _sublayers;
	} forEach _layers;
};
