class edn_fortification_dialogMenu
{
	idd = -1;
	movingenable = false;

	class controls
	{
		class RscText000 : RscText
		{
			text = "Fortification menu";
			x = 0.25;
			y = 0.14;
			h = 0.1;
			w = 0.5;
			colorBackground[] = {1,0.5,0,1};
			SizeEx = "2 * 0.024";
			style = ST_CENTER;
		};
		class GUIBack000 : IGUIBack
		{    
			x = 0.25; 
			y = 0.25;
			h = 0.5;
			w = 0.5;
			colorBackground[] = {0,0,0,0.75};
		};
		class RscButton000 : RscButton
		{
			text = "construction menu";
			x = 0.27; 
			y = 0.29;
			h = 0.10;
			w = 0.21;
			style = ST_CENTER;
			action = "closeDialog 0; [player] call edn_fnc_openconstructionmenu;";
		};
		class RscButton001 : RscButton
		{
			idc = 1500;
			text = "build from chest";
			x = 0.52; 
			y = 0.29;
			h = 0.10;
			w = 0.21;
			style = ST_CENTER;
			action = "closeDialog 0; [cursorTarget] call edn_fnc_openconstructionmenu";
		};
		class RscButton002 : RscButton
		{
			idc = 1501;
			text = "move object";
			x = 0.27; 
			y = 0.45;
			h = 0.10;
			w = 0.21;
			style = ST_CENTER;
			action = "[cursorTarget] call edn_fnc_moveObject; closeDialog 0;";
		};
		class RscButton003 : RscButton
		{
			idc = 1502;
			text = "remove object";
			x = 0.52; 
			y = 0.45;
			h = 0.10;
			w = 0.21;
			style = ST_CENTER;
			action = "[cursorTarget] call edn_fnc_removeObject; closeDialog 0;";
		};
		class RscButton004 : RscButton
		{
			idc = 1503;
			text = "align to ground";
			x = 0.27; 
			y = 0.61;
			h = 0.10;
			w = 0.21;
			style = ST_CENTER;
			action = "[] call edn_fnc_alignObject; closeDialog 0;";
		};
		class RscButton005 : RscButton
		{
			text = "cancel";
			x = 0.52; 
			y = 0.61;
			h = 0.10;
			w = 0.21;
			style = ST_CENTER;
			action = "closeDialog 0;";
		};
	};
};

class edn_fortification_dialogConstructionMenu
{
	idd = -1;
	movingenable = false;
	enableSimulation = 1;
	
	onLoad = "uiNamespace setVariable ['edn_fortification_display',_this select 0];";
	
	class Objects
	{
		class Object
		{
			idc = 1503; 
			type = 82;
			model = "A3\Structures_F\Mil\BagFence\BagFence_Long_F.p3d";
			scale = 1;
			
			direction[] = {0, 0, 1};
			up[] = {0, 1, 1};
 
			x = 0.5;
			y = 0.5;
			z = 4.5;
 
			xBack = 0.825;
			yBack = 0.5;
			zBack = 1.2;
 
			inBack = 0;
			enableZoom = 1;
			zoomDuration = 0.001;
		};
	};
	class controls
	{
		class GUIBack001 : IGUIBack
		{    
			x = safeZoneX + 0.01 * 3 / 4; 
			y = safeZoneY + 0.12;
			h = safeZoneH - 0.13;
			w = 0.75 * 3 / 4;
			colorBackground[] = {0,0,0,0.7};
		};
		
		class RscText000 : RscText
		{
			text = "Construction menu";
			x = safeZoneX + 0.01 * 3 / 4; 
			y = safeZoneY + 0.01;
			h = 0.1;
			w = 0.75 * 3 / 4;
			colorBackground[] = {1,0.5,0,1};
			SizeEx = "2 * 0.024";
			style = ST_CENTER;
		};
		
		class RscButton000 : RscButton
		{
			text = "cancel";
			x = safeZoneX + 0.035 * 3 / 4; 
			y = safeZoneY + safeZoneH - 0.12;
			h = 0.075;
			w = 0.3 * 3 / 4;
			style = ST_CENTER;
			action = "closeDialog 0";
		};
		class RscButton001 : RscButton
		{
			text = "build";
			x = safeZoneX + 0.425 * 3 / 4; 
			y = safeZoneY + safeZoneH - 0.12;
			h = 0.075;
			w = 0.3 * 3 / 4;
			style = ST_CENTER;
			action = "[] call edn_fnc_buildObject; closeDialog 0;";
		};
		
		class RscText002 : RscText
		{
			text = "Categorie:";
			x = safeZoneX + 0.02 * 3 / 4; 
			y = safeZoneY + 0.15;
			h = 0.04;
			w = 0.13 * 3 / 4;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			style = ST_LEFT;
		};
		
		class RscCombo000 : RscCombo
		{
			idc = 1500;
			x = safeZoneX + 0.15 * 3 / 4; 
			y = safeZoneY + 0.15;
			h = 0.04;
			w = 0.56 * 3 / 4;
			colorBackground[] = {0.1,0.1,0.1,1};
			
			onLBSelChanged = "[_this select 1,'Categorie'] call edn_fnc_updateConstructionMenu;";
		};
		class RscListBox000 : RscListBox
		{
			idc = 1501;
			x = safeZoneX + 0.04 * 3 / 4; 
			y = safeZoneY + 0.22;
			h = safeZoneH - 0.40;
			w = 0.68 * 3 / 4;
			colorBackground[] = {0,0,0,1};
			
			onLBSelChanged = "[_this select 1,'Classname'] call edn_fnc_updateConstructionMenu;";
			onLBDblClick = "[] call edn_fnc_buildObject; closeDialog 0;";
		};
		
		class GUIBack000 : RscListBox
		{    
			x = safeZoneX + 0.76 * 3 / 4; 
			y = safeZoneY;
			h = safeZoneH;
			w = safeZoneW - 0.76 * 3 / 4;
			colorBackground[] = {0,0,0,0};
		};
	};
	class controlsBackground
	{
		class GUIBack000 : IGUIBack
		{    
			x = safeZoneX; 
			y = safeZoneY;
			h = safeZoneH;
			w = safeZoneW;
			colorBackground[] = {0.5,0.5,0.5,1};
		};
	};
};

class jjx_menu
{
	idd = 999;
	movingenable = false;

	class controls 
	{
		class GUIBack220: IGUIBack
		{
			idc = 2200;
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.226932 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class txtName: RscText
		{
			idc = 1000;
			text = "BEAR Menu";
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.216617 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnClose: RscButton
		{
			onMouseButtonClick = "closeDialog 0;";
			idc = 1600;
			text = "X";
			x = 0.603151 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Close the menu.";
		};
		class btnBackpack: RscButton
		{
			onMouseButtonClick = "if (isObjectHidden unitBackpack player) then {[unitBackpack player, false] remoteExec ['hideObjectGlobal', 2];} else {[unitBackpack player, true] remoteExec ['hideObjectGlobal', 2];};";
			idc = 1601;
			text = "Toggle backpack";
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Toggle the visability of you backpack.";
		};
		class btnGrass: RscButton
		{
			onMouseButtonClick = "_this call jjx_fnc_grass;";
			idc = 1602;
			text = "Toggle Grass";
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Toggle the visability of grass.";
		};
		class btnVisability: RscButton
		{
			onMouseButtonClick = "closeDialog 0;_this call CHVD_fnc_openDialog;";
			idc = 1603;
			text = "Change view";
			x = 0.54126 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Change your view distance.";
		};
		class btnAdmin: RscButton
		{
			onMouseButtonClick = "closeDialog 0;call jjx_fnc_adminMenu;";
			idc = 1604;
			text = "Admin";
			x = 0.54126 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Options for admins";
		};
		class btnSycn: RscButton
		{
			idc = 1605;
			text = "Sync";
			onMouseButtonClick = "player setUnitLoadout (getUnitLoadout player);";
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "If someone says you have no clothes when you do, click me.";
		};
		class btnZeus: RscButton
		{
			idc = 1606;
			text = "Zeus";
			onMouseButtonClick = "_this call jjx_fnc_openZeus;";
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Options for zeus";
		};
	};
};

class jjx_timerMenu
{
	idd = 998;
	movingenable = false;

	class controls 
	{
		class GUIBack220: IGUIBack
		{
			idc = 2200;
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.226932 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class txtName: RscText
		{
			idc = 1000;
			text = "JJ's Timer Menu";
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.216617 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnClose: RscButton
		{
			onMouseButtonClick = "closeDialog 0;";
			idc = 1600;
			text = "X";
			x = 0.603151 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Close the menu.";
		};
		class edtInput: RscEdit
		{
			idc = 1400;
			text = "3";
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Input the number of minutes for the safezone to last.";
		};
		class btnTimer: RscButton
		{
			text = "Set Safe Timer";
			onMouseButtonClick = "[parseNumber ctrlText 1400] remoteExec ['jjx_fnc_setTimer', 2];_this spawn {hintsilent format ['Timer set to %1 minutes', parseNumber ctrlText 1400];uiSleep 3; hintsilent '';};";
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Set the number of minutes input above.";
		};
		class btnEnableSafe: RscButton
		{
			onMouseButtonClick = "[true] remoteExec ['jjx_fnc_safety', 0, true];_this spawn {hintsilent 'Silently enabled safestart';uiSleep 3; hintsilent '';};";
			text = "Enable Safety";
			x = 0.54126 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "(SILENT) Enable safemode without a countdown.";
		};
		class btnDisableSafe: RscButton
		{
			onMouseButtonClick = "missionNamespace setVariable ['f_var_mission_timer', -1, true];[false] remoteExec ['jjx_fnc_safety', 0, true];_this spawn {hintsilent 'Silently disabled safestart';uiSleep 3; hintsilent '';};";
			text = "Disable safety";
			x = 0.54126 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "(SILENT) Disable safemode and stop countdown.";
		};
		class btnStart: RscButton
		{
			text = "Start the timer";
			onMouseButtonClick = "'f\safeStart\f_safeStart.sqf' remoteExec ['execVM', 0];_this spawn {hintsilent 'Safestart timer has started';uiSleep 3; hintsilent '';};";
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Make sure you set the timer first (Left)";
		};
		class btnEnd: RscButton
		{
			text = "End the timer";
			onMouseButtonClick = "missionNamespace setVariable ['f_var_mission_timer', -1, true];[['SafeStartMissionStarting',['Safe Start ended by admin!']],'bis_fnc_showNotification',true] call BIS_fnc_MP;[false] remoteExec ['jjx_fnc_safety', 0, true];";
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "End Safe Start and notify players.";
		};
	};
};

class jjx_adminMenu
{
	idd = 997;
	movingenable = false;

	class controls 
	{
		class GUIBack220: IGUIBack
		{
			idc = 2200;
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.226932 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class txtName: RscText
		{
			idc = 1000;
			text = "JJ's Admin Menu";
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.216617 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnClose: RscButton
		{
			onMouseButtonClick = "closeDialog 0;";
			idc = 1600;
			text = "X";
			x = 0.603151 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Close the menu.";
		};
		class btnHealAll: RscButton
		{
			text = "Heal all";
			onMouseButtonClick = "[] remoteExec ['jjx_fnc_healAll', 0, true];_this spawn {hintsilent 'Healed all!';uiSleep 3; hintsilent '';};";
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Ace heal all players.";
		};
		class btnNotification: RscButton
		{
			text = "Notification";
			onMouseButtonClick = "_this call jjx_fnc_openNotification;";
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Open notification handler.";
		};
		class btnTimer: RscButton
		{
			text = "Timer";
			onMouseButtonClick = "_this call jjx_fnc_openTimer;"
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Open timer menu.";
		};
		class btnGroups: RscButton
		{
			onMouseButtonClick = "_this call jjx_fnc_openGroups;";
			idc = 1602;
			text = "Group Menu";
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Open the group management menu.";
		};
	};
};

class jjx_zeusMenu
{
	idd = 996;
	movingenable = false;

	class controls 
	{
		class GUIBack220: IGUIBack
		{
			idc = 2200;
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.226932 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class txtName: RscText
		{
			idc = 1000;
			text = "Bear Zeus Menu";
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.216617 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnClose: RscButton
		{
			onMouseButtonClick = "closeDialog 0;";
			idc = 1600;
			text = "X";
			x = 0.603151 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Close the menu.";
		};
		class btnHealAll: RscButton
		{
			text = "Heal all";
			onMouseButtonClick = "[] remoteExec ['jjx_fnc_healAll', 0, true];_this spawn {hintsilent 'Healed all!';uiSleep 3; hintsilent '';};";
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Ace heal all players.";
		};
		class btnToggleFPS: RscButton
		{
			text = "Toggle FPS";
			onMouseButtonClick = "call jjx_fnc_toggleFPS;";
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Toggle the FPS overlay";
		};
	};
};

class jjx_groupMenu
{
	idd = 995;
	movingenable = false;

	class controls 
	{
		class GUIBackground: IGUIBack
		{
			idc = 2200;
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.226932 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class txtName: RscText
		{
			idc = 1000;
			text = "JJ's Group Menu";
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.216617 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnClose: RscButton
		{
			onMouseButtonClick = "closeDialog 0;";
			idc = 1600;
			text = "X";
			x = 0.603151 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Close the menu.";
		};
		class lstPlayers: RscListbox
		{
			idc = 1520;
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class lstGroups: RscListbox
		{
			idc = 1521;
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.132 * safezoneH;
		};
		class btnRename: RscButton
		{
			idc = 1602;
			text = "Rename";
			onMouseButtonClick = "call jjx_group_rename;";
			x = 0.54126 * safezoneW + safezoneX;
			y = 0.445 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Select a group and wright the name below";
		};
		class guiRename: IGUIBack
		{
			idc = 2201;
			x = 0.54126 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class edtRename: RscEdit
		{
			idc = 1420;
			x = 0.54126 * safezoneW + safezoneX;
			y = 0.511 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
		};
	};
};

class jjx_notificationMenu
{
	idd = 994;
	movingenable = false;

	class controls 
	{
		class GUIBack220: IGUIBack
		{
			idc = 2200;
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.226932 * safezoneW;
			h = 0.176 * safezoneH;
		};
		class txtName: RscText
		{
			idc = 1000;
			text = "JJ's Notification Menu";
			x = 0.386534 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.216617 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnClose: RscButton
		{
			onMouseButtonClick = "closeDialog 0;";
			idc = 1600;
			text = "X";
			x = 0.603151 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Close the menu.";
		};
		class edtTitle: RscEdit
		{
			idc = 1401;
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.206302 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Input the title for the notification.";
		};
		class edtDescription: RscEdit
		{
			idc = 1402;
			x = 0.396849 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.144411 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Input the description for the notification.";
		};
		class btnSend: RscButton
		{
			text = "Send";
			onMouseButtonClick = "['Custom',[format['%1',ctrlText 1401],format['%1',ctrlText 1402]]] remoteExec ['bis_fnc_showNotification', 0, true];";
			x = 0.551575 * safezoneW + safezoneX;
			y = 0.522 * safezoneH + safezoneY;
			w = 0.0515754 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Send the notification";
		};
	};
};

class adminMenu 
{
	idd = -1;
	enablemoving = false;

	class controls
	{
		class guiBackground: IGUIBack
		{
			idc = 2200;
			x = 0.314328 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.288822 * safezoneW;
			h = 0.374 * safezoneH;
		};
		class txtMenu: RscText
		{
			idc = 1000;
			text = "BearZ Admin Menu";
			x = 0.314328 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.278507 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnClose: RscButton
		{
			idc = 1600;
			onMouseButtonClick = "closeDialog 2;";
			text = "X";
			x = 0.592836 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {1,0,0,0};
			tooltip = "Close the menu";
		};
		class lstPlayers: RscListBox
		{
			idc = 1500;
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.0928357 * safezoneW;
			h = 0.22 * safezoneH;
		};
		class txtPlayers: RscText
		{
			idc = 1001;
			text = "Players";
			x = 0.319486 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0979933 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class lstFeatures: RscListBox
		{
			idc = 1501;
			x = 0.427794 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.165041 * safezoneW;
			h = 0.22 * safezoneH;
		};
		class txtFeatures: RscText
		{
			idc = 1002;
			text = "Features";
			x = 0.427794 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.165041 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnSelect: RscButton
		{
			idc = 1601;
			onMouseButtonClick = "[(lbCurSel 1500), (lbCurSel 1501)] call jjx_admin_exec;";
			text = "Execute";
			x = 0.324644 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class btnVariables: RscButton
		{
			idc = 1604;
			text = "Variable Menu";
			x = 0.391692 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class btnSpawn: RscButton
		{
			idc = 1606;
			onMouseButtonClick = "closeDialog 2;call jjx_fnc_openTimer;";
			text = "Timer Menu";
			x = 0.463897 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class btnDebug: RscButton
		{
			idc = 1605;
			onMouseButtonClick = "closeDialog 2;call jjx_fnc_openGroups;";
			text = "Group Menu";
			x = 0.530945 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class guiBackgroundRight: IGUIBack
		{
			idc = 2201;
		
			x = 0.613466 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.374 * safezoneH;
		};
		class txtLoadouts: RscText
		{
			idc = 1005;
			text = "Loadouts";
			x = 0.613466 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0722056 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class lstLoadouts: RscListBox
		{
			idc = 1502;
			x = 0.618623 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.198 * safezoneH;
		};
		class edtLoadoutName: RscEdit
		{
			idc = 1400;
			x = 0.618623 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnLoad: RscButton
		{
			idc = 1602;
			onMouseButtonClick = "call jjx_loadout_load;";
			text = "Load";
			x = 0.618623 * safezoneW + safezoneX;
			y = 0.621 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnSave: RscButton
		{
			idc = 1603;
			onMouseButtonClick = "call jjx_loadout_save;";
			text = "Save";
			x = 0.618623 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnDelete: RscButton
		{
			idc = 1607;
			onMouseButtonClick = "call jjx_loadout_delete;";
			text = "Delete";
			x = 0.618623 * safezoneW + safezoneX;
			y = 0.654 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class guiBackgroundEdit: IGUIBack
		{
			idc = 2201;
			x = 0.618623 * safezoneW + safezoneX;
			y = 0.555 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};

class debugMenu 
{
	idd = -10;
	enablemoving = false;

	class controls
	{
		class guiBackground: IGUIBack
		{
			idc = 2200;
		
			x = 0.355589 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.288822 * safezoneW;
			h = 0.374 * safezoneH;
		};
		class txtDebugMenu: RscText
		{
			idc = 1000;
			text = "BearZ Debug Menu";
			x = 0.355589 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.278507 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnClose: RscButton
		{
			idc = 1600;
			text = "X";
			x = 0.634096 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0103151 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txtPlayers: RscText
		{
			idc = 1001;
			text = "Players";
			x = 0.365904 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class lstPlayers: RscListbox
		{
			idc = 1500;
			x = 0.365904 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class txtDebug: RscText
		{
			idc = 1002;
			text = "Debug Console";
			x = 0.438109 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.195987 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class guiBackgroundCode: IGUIBack
		{
			idc = 2201;
			x = 0.438109 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.195987 * safezoneW;
			h = 0.253 * safezoneH;
			colorText[] = {0.133,0.133,0.133,1};
		};
		class edtCode: RscEdit
		{
			idc = 1400;
			x = 0.438109 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.195987 * safezoneW;
			h = 0.253 * safezoneH;
		};
		class btnLocal: RscButton
		{
			idc = 1601;
			onMouseButtonClick = "[(ctrlText 1400)] call jjx_debug_localExec;";
			text = "Local Execute";
			x = 0.572207 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.033 * safezoneH;
			tooltip = "You execute this code";
		};
		class btnServer: RscButton
		{
			idc = 1602;
			onMouseButtonClick = "[(ctrlText 1400), 2] call jjx_debug_serverExec;";
			text = "Server Execute";
			x = 0.505158 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.033 * safezoneH;
			tooltip = "Server execute this code";
		};
		class btnGlobal: RscButton
		{
			idc = 1603;
			onMouseButtonClick = "[(ctrlText 1400), 0] call jjx_debug_serverExec;";
			text = "Global Execute";
			x = 0.438109 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.033 * safezoneH;
			tooltip = "All players and server execute this code";
		};
		class btnRemote: RscButton
		{
			idc = 1604;
			onMouseButtonClick = "[(ctrlText 1400), (lbCurSel 1500)] call jjx_debug_remoteExec;";
			text = "Remote Execute";
			x = 0.365904 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.033 * safezoneH;
			tooltip = "Execute this code on the selected player";
		};
	};
};

class spawnMenu 
{
	idd = -20;
	enablemoving = false;

	class controls
	{
		class guiBag: IGUIBack
		{
			idc = 2200;
			x = 0.195705 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class guiVeh: IGUIBack
		{
			idc = 2201;
			x = 0.319486 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class guiObj: IGUIBack
		{
			idc = 2202;
		
			x = 0.443267 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class guiWep: IGUIBack
		{
			idc = 2203;
		
			x = 0.567048 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class guiMag: IGUIBack
		{
			idc = 2204;
		
			x = 0.690829 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class txtBag: RscText
		{
			idc = 1000;
			text = "Backpacks";
			x = 0.195705 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txtVeh: RscText
		{
			idc = 1001;
			text = "Vehicles";
			x = 0.319486 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txtObj: RscText
		{
			idc = 1002;
			text = "Objects";
			x = 0.443267 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txtWep: RscText
		{
			idc = 1003;
			text = "Weapons";
			x = 0.567048 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class txtMag: RscText
		{
			idc = 1004;
			text = "Magazines";
			x = 0.690829 * safezoneW + safezoneX;
			y = 0.203 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class lstBag: RscListbox
		{
			idc = 1510;
			x = 0.195705 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class lstVeh: RscListbox
		{
			idc = 1511;
			x = 0.319486 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class lstObj: RscListbox
		{
			idc = 1512;
			x = 0.443267 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class lstWep: RscListbox
		{
			idc = 1513;
			x = 0.567048 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class lstMag: RscListbox
		{
			idc = 1514;
			x = 0.690829 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.113466 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class btnBag: RscButton
		{
			idc = 1600;
			text = "Spawn";
			x = 0.221493 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnVeh: RscButton
		{
			idc = 1601;
			text = "Spawn";
			x = 0.345274 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnObj: RscButton
		{
			idc = 1602;
			text = "Spawn";
			x = 0.469055 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnWep: RscButton
		{
			idc = 1603;
			text = "Spawn";
			x = 0.592836 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class btnMag: RscButton
		{
			idc = 1604;
			text = "Spawn";
			x = 0.716617 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0618905 * safezoneW;
			h = 0.022 * safezoneH;
		};
	};
};