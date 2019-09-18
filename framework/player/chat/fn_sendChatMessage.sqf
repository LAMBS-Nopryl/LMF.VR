///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	* Author: Cuel
	*
	* Description:
	* Sends a custom chat command
	*
	* Arguments:
	*
	* Public: No
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
params ["_msg", "_type", "_receiver"];

private _callsign = switch (toLower _type) do {
  case "zeus": {"to Zeus:"};
  case "whisper": {format ["Whisper to %1:", _receiver]};
  default {"Chat:"}
};

lmf_chatChannel radioChannelAdd [ACE_player];
lmf_chatChannel radioChannelSetCallsign _callsign;
player customChat [lmf_chatChannel, _msg];
lmf_chatChannel radioChannelRemove [ACE_player];

["lmf_chatMessage",[profileName, _msg, _type, _receiver]] call CBA_fnc_globalEvent;

playSound "3DEN_notificationDefault";