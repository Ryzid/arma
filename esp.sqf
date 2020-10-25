
if (isNil "Ryzid_ESP") then {Ryzid_ESP = 0;};
if (Ryzid_ESP == 0) then {
	hint "ESP ON";
	Ryzid_ESP1 =	{
		disableSerialization;
		//id/006Rehwald
		if (isNil "RyzidID_Setter") then {RyzidID_Setter = 2733;};
		RyzidID_Setter cutRsc ["rscDynamicText", "PLAIN"];
		RyzidID_Setter = RyzidID_Setter + 1;
		_Ryzid1 = ((uiNamespace getvariable "BIS_dynamicText") displayctrl 9999);
		_Ryzid1 ctrlShow true; 
		_Ryzid1 ctrlEnable true; 
		_Ryzid1 ctrlSetFade 0;
		
		_uniiit = _this select 0;
		while {((((positionCameraToWorld [0,0,0]) distance _Uniiit) < RyzidID_FNC_ESP_distance) && (Ryzid_ESP == 1))} do
		{
			if ((isNull _Uniiit) || !(alive _Uniiit)) exitWith {};
		    if (getPlayerUID _Uniiit == '') exitWith {};
        
			_ryzidpos = (positionCameraToWorld [0,0,0]);
			_ryzidposU = getPos _Uniiit;
			_ryziddist = round(_ryzidpos distance _ryzidposU);
			
			_vih = vehicle _Uniiit;
			_ryzidposU2 = [(getPosATL _vih) select 0, (getPosATL _vih) select 1, ((getPosATL _vih) select 2) + (((boundingBox _vih) select 1) select 2) + 0.5];
			_ryzidpos2D = worldToScreen _ryzidposU2;

			if (count _ryzidpos2D > 0) then	{
				if (_ryziddist <= 50) then {_Ryzid1 ctrlSetFade 0;};
				if (_ryziddist > 50) then {_Ryzid1 ctrlSetFade 0.05;};
				if (_ryziddist > 75) then {_Ryzid1 ctrlSetFade 0.1;};
				if (_ryziddist > 100) then {_Ryzid1 ctrlSetFade 0.15;};
				if (_ryziddist > 200) then {_Ryzid1 ctrlSetFade 0.2;};	
				if (_ryziddist > 300) then {_Ryzid1 ctrlSetFade 0.25;};
				if (_ryziddist > 400) then {_Ryzid1 ctrlSetFade 0.3;};
				if (_ryziddist > 500) then {_Ryzid1 ctrlSetFade 0.35;};
				if (_ryziddist > 600) then {_Ryzid1 ctrlSetFade 0.4;};
				if (_ryziddist > 700) then {_Ryzid1 ctrlSetFade 0.45;};		
				if (_ryziddist > 800) then {_Ryzid1 ctrlSetFade 0.5;};
				if (_ryziddist > 900) then {_Ryzid1 ctrlSetFade 0.55;};	
				if (_ryziddist > 1000) then {_Ryzid1 ctrlSetFade 0.6;};
				if (_ryziddist > 1100) then {_Ryzid1 ctrlSetFade 0.65;};
				if (_ryziddist > 1200) then {_Ryzid1 ctrlSetFade 0.7;};
				if (_ryziddist > 1300) then {_Ryzid1 ctrlSetFade 0.75;};
				if (_ryziddist > 1400) then {_Ryzid1 ctrlSetFade 0.8;};	

				_T_size = 0.35;	
				_RyzidSelected = format['<t size=''%3'' font=''Zeppelin33'' color=''#FD1D18''>%1 (%2m)</t>',name _uniiit,round _ryziddist,_T_size];
				if (name _uniiit == name player) then {_RyzidSelected = ''};
				if (_uniiit != _vih) then {
					_crewnames = [];
					{
						_crewnames = _crewnames + [name _x];
					} forEach crew _vih;
					_ryzidposU2 = [_ryzidposU2 select 0,_ryzidposU2 select 1,(_ryzidposU2 select 2) + 1.5];
					_ryzidpos2D = worldToScreen _ryzidposU2;
					_RyzidSelected = format['<t size=''%3'' font=''Zeppelin33'' color=''#1593F0''>%1 (%2m) %4</t>',_crewnames,round _ryziddist,_T_size,typeOf _vih];
				};
				_Ryzid1 ctrlSetStructuredText (parseText _RyzidSelected);
				if (count _ryzidpos2D > 1) then {
					_Ryzid1 ctrlSetPosition [(_ryzidpos2D select 0) - (safezoneW / 2), (_ryzidpos2D select 1), safezoneW, safezoneH];
				};
				_Ryzid1 ctrlCommit 0;
			};
			uisleep 0.001;
		};
		_Ryzid1 ctrlShow false;
		_Ryzid1 ctrlEnable false;
		_a = _a - [_uniiit];
	};
	Ryzid_ESP = 1;
	RyzidID_FNC_ESP_distance = 1500;
	_a = [];
	
	while {Ryzid_ESP == 1} do
	{
       	{       
			_ryzidpos = (positionCameraToWorld [0,0,0]);
			_ryzidposX = getPos _x;
			_ryziddist = (_ryzidpos distance _ryzidposX);
			if ((_x != player) && (name _x != "") && !(_x in _a) && ((player distance _x) < RyzidID_FNC_ESP_distance)) then {
				_a = _a + [_x];
				[_x] spawn Ryzid_ESP1;
			};
			if ((_x in _a) && (_ryziddist > RyzidID_FNC_ESP_distance)) then {
				_a = _a - [_x];
			};
		} forEach ([1,2,3] nearEntities ['AllVehicles',25000]); /*  ||||||||||  } forEach playableUnits;  */
		uisleep 1;
	};
} else {
	Ryzid_ESP = 0;
	hint "ESP OFF";
	};
