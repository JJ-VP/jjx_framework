// --Fortification Open Construction Menu
#define EDN_FORTIFICATION_OPENCONSTRUCTIONMENU_KEY 60 // By default 60 = "F2"
#define EDN_FORTIFICATION_OPENCONSTRUCTIONMENU_SHIFT false
#define EDN_FORTIFICATION_OPENCONSTRUCTIONMENU_CTRL false
#define EDN_FORTIFICATION_OPENCONSTRUCTIONMENU_ALT false
// --Fortification Open Construction Menu
#define EDN_FORTIFICATION_TURNLEFT_KEY 36 // By default 36 = "J"
#define EDN_FORTIFICATION_TURNLEFT_SHIFT false
#define EDN_FORTIFICATION_TURNLEFT_CTRL false
#define EDN_FORTIFICATION_TURNLEFT_ALT false
// --Fortification Open Construction Menu
#define EDN_FORTIFICATION_TURNRIGHT_KEY 38 // By default 38 = "L"
#define EDN_FORTIFICATION_TURNRIGHT_SHIFT false
#define EDN_FORTIFICATION_TURNRIGHT_CTRL false
#define EDN_FORTIFICATION_TURNRIGHT_ALT false
// --Fortification Open Construction Menu
#define EDN_FORTIFICATION_MINUSDISTANCE_KEY 37 // By default 37 = "K"
#define EDN_FORTIFICATION_MINUSDISTANCE_SHIFT false
#define EDN_FORTIFICATION_MINUSDISTANCE_CTRL false
#define EDN_FORTIFICATION_MINUSDISTANCE_ALT false
// --Fortification Open Construction Menu
#define EDN_FORTIFICATION_PLUSDISTANCE_KEY 23 // By default 23 = "I"
#define EDN_FORTIFICATION_PLUSDISTANCE_SHIFT false
#define EDN_FORTIFICATION_PLUSDISTANCE_CTRL false
#define EDN_FORTIFICATION_PLUSDISTANCE_ALT false

[] execVM "f\safeStart\f_safeStart.sqf";

jjx_admin = ["76561198119540788"];
jjx_timer = ["76561198119540788"];
compileFinal "jjx_admin = jjx_admin";
compileFinal "jjx_timer = jjx_timer";

if (isDedicated) exitWith {};
if (!(isnil "edn_fortification_keydown")) exitwith {};

edn_fortification_zeus_array = [];

edn_fortification_array = [
["Sandbag Walls",
["Land_BagFence_Long_F",[]],
["Land_BagFence_Short_F",[]],
["Land_BagFence_End_F",[]],
["Land_BagFence_Round_F",[]],
["Land_BagFence_Corner_F",[]]
],
["H-Barriers",
["Land_HBarrier_1_F",[]],
["Land_HBarrier_3_F",[]],
["Land_HBarrier_5_F",[]],
["Land_HBarrier_Big_F",[]]
],
["Bunker",
["Land_BagBunker_Small_F",[]],
["Land_BagBunker_Large_F",[]],
["Land_BagBunker_Tower_F",[]],
["Land_fort_rampart",[]]
],
["Camping",
["Land_Campfire_F",[]],
["Land_CampingChair_V2_F",[]],
["Land_CampingTable_F",[]],
["Land_CampingTable_small_F",[]]
]
];

edn_fortification_categorieId = 0;
edn_fortification_classnameId = 0;
EDN_Fortification_alignToGround = false;
edn_fortification_inventoryHolder = objNull;

//Get Data from Userconfig
EDN_FORTIFICATION_KEYBINDINGS = [
[EDN_FORTIFICATION_OPENCONSTRUCTIONMENU_KEY,EDN_FORTIFICATION_OPENCONSTRUCTIONMENU_SHIFT,EDN_FORTIFICATION_OPENCONSTRUCTIONMENU_CTRL,EDN_FORTIFICATION_OPENCONSTRUCTIONMENU_ALT],
[EDN_FORTIFICATION_TURNLEFT_KEY,EDN_FORTIFICATION_TURNLEFT_SHIFT,EDN_FORTIFICATION_TURNLEFT_CTRL,EDN_FORTIFICATION_TURNLEFT_ALT],
[EDN_FORTIFICATION_TURNRIGHT_KEY,EDN_FORTIFICATION_TURNRIGHT_SHIFT,EDN_FORTIFICATION_TURNRIGHT_CTRL,EDN_FORTIFICATION_TURNRIGHT_ALT],
[EDN_FORTIFICATION_MINUSDISTANCE_KEY,EDN_FORTIFICATION_MINUSDISTANCE_SHIFT,EDN_FORTIFICATION_MINUSDISTANCE_CTRL,EDN_FORTIFICATION_MINUSDISTANCE_ALT],
[EDN_FORTIFICATION_PLUSDISTANCE_KEY,EDN_FORTIFICATION_PLUSDISTANCE_SHIFT,EDN_FORTIFICATION_PLUSDISTANCE_CTRL,EDN_FORTIFICATION_PLUSDISTANCE_ALT]
];