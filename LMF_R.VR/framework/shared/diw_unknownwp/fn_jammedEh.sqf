/*
  Function: diwako_unknownwp_fnc_jammedEh

  Description:
    ACE weapon jammed evenhandler function

  Parameters:
    _unit   - Unit for which the weapon jammed
    _weapon - Weapon class that currently jammed

  Returns:
    nothing

  Author:
  diwako 2018-10-26
*/
params["_unit","_weapon"];
if (_unit == ace_player) then {
  if !(primaryWeapon ace_player == _weapon) exitWith {};
  if (isNil "diwako_unknownwp_weapon_whitelist") exitWith {};

  private _weaponUpper = toUpper(_weapon);
  if !(_weaponUpper in diwako_unknownwp_weapon_whitelist || {_weaponUpper in diwako_unknownwp_local_weapons}) then {
    if ((random 100) < diwako_unknownwp_jam_explosion) then {
      // get model patch of current weapon for simplemobject
      private _model = getText(configfile >> "cfgweapons" >> _weapon >> "model");
      if (_model find "." == -1) then {
        _model = _model + ".p3d";
      };
      if (_model find "\" == 0) then {
        _model = [_model, 1] call CBA_fnc_substr;
      };
      // spawn a simulated ground holder near the player
      private _groundHolder = createVehicle ["WeaponHolderSimulated", position ace_player, [], 0.5, "CAN_COLLIDE"];

      // add attachements and some near empty magazine to the ground holder
      {
        _groundHolder addMagazineAmmoCargo [_x, 1, 1];
      } forEach (primaryWeaponMagazine ace_player);

      {
        if (_x != "") then {
          _groundHolder addItemCargoGlobal [_x,1];
        };
      } forEach (primaryWeaponItems ace_player);

      // spawn simple object
      private _dummy = createSimpleObject[_model,getPosATL ace_player];
      _dummy hideSelection ["zasleh",true];
      _dummy hideSelection ["magazine",true];
      _dummy hideSelection ["bolt",true];
      _dummy hideSelection ["magrelease",true];
      _dummy attachTo [_groundHolder,[0,0,-0.5]];

      private _dir = getdir ace_player;
      _groundHolder disableCollisionWith ace_player;
      _groundHolder setPos (ace_player modelToWorld [0.25,0.4,1.2]);
      _groundHolder setDir (_dir + 90);

      // make the ground weapon hold fly away from the player in a small arc
      private _speed = 2.5;
      _groundHolder setVelocity [_speed * sin(_dir), _speed * cos(_dir),1];

      // remove players weapon
      ace_player removeWeapon _weapon;

      // despawn the broken weapon after 5 minutes
      [{
        params ["_dummy"];
        deleteVehicle _dummy;
      }, [_dummy], 300] call CBA_fnc_waitAndExecute;

      // kablamm
      playSound3D["A3\Sounds_F\arsenal\explosives\mines\Mine_closeExp_0" + str( (floor random 3) + 1 ) + ".wss",objNull,false,getPosATL ace_player,10,1,150];
      addCamShake[20,2,2];
      ["Weapon has been destroyed"] call ace_common_fnc_displayTextStructured;

      // hurt the player
      if !(isNil "ace_medical_fnc_addDamageToUnit") then {
        // Ace medical is enabled
        private _dam = 1;
        if (isPlayer ace_player) then {
          _dam = (missionNamespace getVariable ["ace_medical_playerDamageThreshold", 1]) / 2;
        } else {
          private _res = ace_player getVariable ["ace_medical_unitDamageThreshold", [1, 1, 1]];
          _dam = (_res#0 + _res#1 + _res#2) / 3;
        };
        [ace_player, _dam, selectRandom ["head", "body", "hand_l", "hand_r"], "stab"] call ace_medical_fnc_addDamageToUnit;
      } else {
        // Ace medical is not enabled
        ace_player setDamage (damage ace_player + 0.1);
      };
    };
  };
};