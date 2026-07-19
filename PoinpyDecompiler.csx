///
/// Poinpy asset exporter.
///
/// Adapted from PTdecompiler.csx, part of https://github.com/femloy/OpenTower
/// (CC BY 4.0) - the sprite dumping, .yy generation and JSON writing machinery
/// below is that project's work, reused here under that licence.
///

using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.Drawing;
using System.Diagnostics;
using UndertaleModLib.Models;
using UndertaleModLib.Util;
using Newtonsoft.Json;
using ImageMagick;
using ImageMagick.Drawing;

#region Error handling

EnsureDataLoaded();

// Soft checks - Poinpy ships as game.droid inside the APK, and the display name
// differs between builds, so none of this is fatal.
const int EXPECTED_SPRITES = 852;
const int EXPECTED_SOUNDS = 373;

if (Data.Sprites.Count != EXPECTED_SPRITES || Data.Sounds.Count != EXPECTED_SOUNDS)
{
	if (!ScriptQuestion(
		$"This data file has {Data.Sprites.Count} sprites and {Data.Sounds.Count} sounds.\n" +
		$"The decomp was built against {EXPECTED_SPRITES} sprites and {EXPECTED_SOUNDS} sounds.\n\n" +
		"Continue anyway?"))
		return;
}

#endregion

string dataPath = $"{Path.GetDirectoryName(FilePath)}\\";
string rootPath = $"{dataPath}Export_Data\\";
TextureWorker worker = new TextureWorker();

// these are exported wrong, so the decomp includes them
var ignore = new List<string>()
{
};

#region Sorted sprite folders

public class spriteProps
{
	public spriteProps(string fName, string fPath)
	{
		folderName = fName;
		folderPath = fPath;
	}
	public string folderName {get; set;} = "Sprites";
	public string folderPath {get; set;} = "folders/Sprites.yy";
}
var folders = new Dictionary<string, spriteProps>()
{
	{"Sprite449", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"Sprite485", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"Sprite584", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"Sprite863", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"aEnFruitHolder", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"errorPalette", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"mask_16x16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"mask_8x8", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"mask_nomask", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sAbilityEquipBackButton", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sAbilityEquipBackground", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sAbilityEquipDivider", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sAbilityExtraJump_asleep", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sAlphaGradientLine", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sArea160x16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sAudioArea_fadeMusic", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sAudioArea_fadeNextMusicOut", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sAudioArea_switchAreaMusic", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sAudioController", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBallBlue", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBallGreen", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBallOrange", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBallRed", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBatTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBeastFace_delicious", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFace_fire", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFace_frustrated", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFace_glug", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFace_initialAnger", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFace_normal", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFace_sleepInLobby", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFace_taste", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFire", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastFireTail", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_Body", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_BonkLookUp", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_Ear", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceAsleep_BreatheIn", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceAsleep_BreatheOut", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceAsleep_MumbleLoop", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceAsleep_MumbleStart", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceFirstEverBonked", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGeneralAnger", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGlug_Close", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGlug_Delicious", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGlug_DeliciousA", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGlug_DeliciousA_Start", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGlug_Delicious_Start", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGlug_Receiving", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGlug_Start", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceGlug_Taste", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceMagmaRise", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceMagmaSwitchActivated_Shaking", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceMagmaSwitchLook", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceMagmaSwitchRoomLookAround", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceMagmaSwitchRoomLookAround_Start", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceMagmaSwitchShattered", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceMagmaSwitch_WorriedBlinks", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceMagmaSwitch_closeThenOpenOneEye", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FacePostAngerBreather", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceSurpriseBonked", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitJuiceReady", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel1", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel2", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel2_Start", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel3", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel3_Start", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel4", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel4_Burst", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel4_Smooth", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel4_Start", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FaceWaitLevel5", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FxFrownSmoke", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FxSparkle00", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FxSparkle01", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_FxSweat00", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeastPart_GlugMouthRect", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBeast_base", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sBench", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBgLayer_BubbleBackFog_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_BubbleFrontFog_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_CannonCloudsAfarBits", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_CannonClouds_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_CannonStars_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_CannonStructure_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_JumppadFar_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_JumppadFront_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_SpaceStars", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBgLayer_Tutorial_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLayer_VineBush_parts", new spriteProps("Backgrounds", "folders/Sprites/Backgrounds.yy")},
	{"sBgLobby", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sBgPart_OuterSpaceBack", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sBgPart_PlanetContinent", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sBgPart_PlanetHorizon", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sBgPart_ShadeOverEarth", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBgPart_SpaceFog", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sBgPart_Stars1", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sBgPart_Stars2", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sBgPart_Stars3", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sBlueSwitch", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoostHoopCollision", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoostHoopTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxBlack16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxBlue16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxBrown16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxClear16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxEyeRed16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxGray16x18", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxGreen16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxLightGray16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxOrange16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxPink16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxPink16Line", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxRed16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxRedTransparent16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxWhite", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBoxWhite16", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBubble", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBubble_neon", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBulletRed", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBumperMushroomTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBumperMushroomTest1", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sBungeeBoy_Dead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sCamera", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCameraActivateArea", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCameraArea_BottomLimit", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCameraArea_BottomLimit_lock", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCameraArea_FocusPointV", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCameraArea_TopLimit", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCameraScrollArea", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCannonParts", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCannonParts_gray", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCannonParts_gray_neon", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCannonParts_neon", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCloudWall200", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCloudWallPart", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCogWall", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sColorBall", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sColorBurnShadowBox", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sComet", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sControl", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sCosmosGacha", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sDamageBall00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sDeadSpriteDefault", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sDetailBombA", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombAs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombB", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombBs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombC", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombCs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombD", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombDs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombE", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombEs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombF", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBombFs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleA", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleA_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleB", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleB_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleC", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleC_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleD", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleD_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleE", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleE_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleF", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleF_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleFloor1", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleFloor1s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleFloor2", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleFloor2s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleFloor3", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleFloor3s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleG", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleG_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleH", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleH_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleI", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailBubbleI_e", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonA", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonAs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonB", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonBs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonC", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonCornerBlock", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonCornerBlock_s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonCs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonD", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonDs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonE", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonEs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonFloor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonFloorMiddle", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonFloorMiddle_s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonFloorSide", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonFloor_s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonPillar", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonPillar_middle", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailCannonPillar_s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadA", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadAs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadB", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadBs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadC", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadCs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadD", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadDs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadE", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadEs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadF", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadFs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadG", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadGs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadH", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadHs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadI", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailJumppadIs", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailLevel00CornerBush", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailLevel00GroundGrass", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailLobbyBigBush", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyBigBush_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyBigRock", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyBigRock_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyBud", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyLeaves", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyLeaves_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyMushroomLeft", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyMushroomLeft_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyMushroomRight", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyMushroomRight_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyShadowLighter", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbyShadowLighter_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbySideRockLeft", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbySideRockLeft_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbySideRockRight", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLobbySideRockRight_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLowerBush", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailLowerBush_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sDetailPadFloorLeft", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadFloorMid", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadFloorRight", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadFloors", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadLadderFront", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadLadderFronts", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadSupportLadder2", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadSupportLadder2s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadSupportLadder3", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailPadSupportLadder3s", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineA", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineA_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineB", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineB_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineC", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineC_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineD", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineD_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineE", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineE_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineF", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineF_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineG", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineG_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineGrass", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineH", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineH_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineI", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineI_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineJ", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetailVineJ_editor", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_JungleLowerLeft", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_JungleLowerRight", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_JungleSideLeft", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_JungleSideRight", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_JungleUpperLeft", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_JungleUpperRight", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_Level00CornerBush00", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_Level00CornerBush01", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_grassBlueSet", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_grassGreenSet", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDetail_grassRedSet", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sDevNetflix", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sDevolverDigitalLogo", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sDrillfish_alert", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sDrillfish_bubbleA", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sDrillfish_bubbleB", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sDrillfish_dead_head", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sDrillfish_dead_tail", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sDrillfish_drill", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sDrillfish_idle", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEasterEgg_Error", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEasterEgg_Jizo", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEditorEnemyBox", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEditorJumppadBox1", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnAnemoneShooterBullet", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnAnemoneShooterDetail", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnBungeeTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnCannonFodderTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnChainedGraveTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnChainedSoulTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnCloudChaserTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnDrillFish", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnDrillFishDead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnFlippyPatrolTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnFruitHandler", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnFruitHandlerDead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnFruitHandlerDead2", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnFruitHandlerHand", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnFruitHandlerTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnGroundWormTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnHomingLong", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnHorizontalShooter_editor", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnJelloWithFruit", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnJellyTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnJumpingSpiderTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnPot", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnSlowHoming", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnSpikeJumper", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnTesthoming", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnWallCrawlerDead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEndBed", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEndStar", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sEndWIndow", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnd_00_PoinpuWakes", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_00_PoinpuWakes_op", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_01_LooksOutTheWindow", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_01_LooksOutTheWindow_op", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_02_00_PoinpuPOV", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_02_NussieLunges", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_02_NussieLunges_op", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_03_NussieRunsThrough", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_03_NussieRunsThrough_op", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_03_NussieRunsThrough_opBG", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_04_NussieAtFoodBowl", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_04_NussieAtFoodBowl_op", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_04_NussieAtFoodBowl_opBG", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_05_OpensCupboard", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_06_FoodIntoBow_op", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_06_FoodIntoBowl", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_07_FoodIntoBowl2", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_07_FoodIntoBowl2_op", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_08_Eating", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnd_08_Eating_op", new spriteProps("EndingCutscene", "folders/Sprites/EndingCutscene.yy")},
	{"sEnding_PlayerGlowQuarter", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnemyAnemone_Body", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyAnemone_Dead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyBungeeBoy", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyBungeeBoyRope", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyBungeeBoyRope_knot", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyFrogger", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnemyHomer_Body", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyHomer_Dead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyHomer_Eye", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyHomer_Eyelid", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyHomer_Head", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyHorizontalShooterTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sEnemyJelly_dead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyJelly_dead_jellyTop", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyJelly_flutter", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyJumper_charge", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyJumper_dead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyJumper_flutter", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyJumper_idle", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyJumper_jump", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyRedBird_dead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyRedBird_feather", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyRedBird_fly", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemySpikeBox_dead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemySpikeBox_spikeBack", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemySpikeBox_spikeBottom", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemySpikeBox_spikeFront", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemySpikeBox_spikeTop", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sEnemyWallCrawlerTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFlashCircle24", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorCloud_center", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorCloud_editor", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorCloud_left", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorCloud_right", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorCloud_single", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorGrass_center", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorGrass_left", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorGrass_right", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFloorGrass_single", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitApple", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitBanana", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitBloodGourd", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitBlue", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitBlueApple", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitBlueRed", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitBlueberry", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitBuntan", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitCherry", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitCorn", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitDewBorderWhite", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitDewLighting", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitDewWhite", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitEggplant", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitGrape", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitGreen", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitHandler_test", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitKiwi", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitLemon", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitLettuce", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitMangosteen", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitMelon", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitMushroom", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitPuzzle", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitPuzzle_alt", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitRed", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitStrawberry", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitTomato", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitWatermelon", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sFruitYellow", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitYellowGreen", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFruitYellowWatermelon", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxDownwellExplosion", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxExplosion", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxFeathersTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxFruitGet", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxFruitGet01", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxFruitGetFlash", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxFruitSplash", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxImpactStar", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxSplash", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sFxWallJumpFlash", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGacha3SliceButton", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGacha3SliceButtonHighlight", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGacha3SliceLabel", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGacha3SliceLabelBorder", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaArrow", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaArrowHighlight", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaBallOpenLid", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaBallWhite", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaBallWhite_Open", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaBalls", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGachaBody", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaBodyLever", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaBodyLever_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaBody_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaConfirm", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaConfirmHighlight", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_Light", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_LightBox", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_RockCeiling", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_RockCeiling_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_StreetLight", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_StreetLight_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_TreeLeftA", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_TreeLeftA_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_TreeLeftB", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_TreeLeftB_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_TreeRightA", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_TreeRightA_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_TreeRightB", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaDetail_TreeRightB_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaLever", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGachaNumberRed", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGachaNumberYellow", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sGameBackgroundObj", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGimCannonTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGimJumpPadTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGlassShard", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGoldenSeed", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGoldenSeedUI", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGuiBorderFruits_shadow", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGuiBorder_border", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sGuiBorder_gradientShadow", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sHacobowDead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHacobow_cry_repeat", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHacobow_cry_start", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHacobow_ops", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHacobow_tears", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHacobow_turn_arm", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHacobow_turn_body", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHacobow_walk_arm", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHacobow_walk_body", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHazardBall", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sHoodedHopper_airborneLoop", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHoodedHopper_dead", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHoodedHopper_hopBack", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHoodedHopper_idle", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHoodedHopper_land", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sHoodedHopper_leapStart", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sImomushi", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sImomushiDead", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sInitialize", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sIntervalTunnelEdge", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sItem_aim_focus_extend", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_damage_jump_recover", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_endless_mode", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_enemy_to_fruit", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_extra_jump_orb", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_final_screw_attack", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_focus_time_freeze", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_fruit_handler_dual_wield", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_fruit_pot", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_fruit_twin", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_higher_entity_bounce", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_increase_jump_power", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_instant_money", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_juice_resurrection", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_juice_resurrection_used", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_jump_fruit_suction", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_money_pot", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_more_fruit_handler", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_more_pot", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_pajama1", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_pajama2", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_pajama3", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_pajama4", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_slam_bounce_angled", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_slam_fruit_suction", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_slam_start_fruit_suction", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_slower_timescale", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_spin_fruit_suction", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_spin_wall_jump", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_wall_jump_higher", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sItem_wallkick_fruit_suction", new spriteProps("Abilities", "folders/Sprites/Abilities.yy")},
	{"sJuicebarCap", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpCounts00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpCounts01", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpCounts02", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpCounts_noneLeft", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpOrbRefill", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpPadHigh", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpPadHigh_neon", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpPadLow", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sJumpPadLow_neon", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sKickWall", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLaunchSwitch_base", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLaunchSwitch_big_switch", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLaunchSwitch_case", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLaunchSwitch_light", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLaunchSwitch_underlay", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLevelBuilder", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLevelTile00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLobbyAnemoneBlue", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyAnemoneBlue_base", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyAnemoneRed", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyAnemoneRed_base", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyAnemone_baby", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyBeast", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyBeastStompPrompt", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyBeastStompPrompt_Player", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyBeast_slamMask", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyButterflyBlue", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyButterflyBlue_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyButterflyYellow", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyButterflyYellow_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyCloudShadow", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sLobbyFlowerBlue", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyFlowerBlue_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyFlowerGreen", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyFlowerGreen_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyFlowerRed", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyFlowerRed_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyFlowerYellow", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbyFlowerYellow_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbySparkle00", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbySparkle00_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbySparkleA", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLobbySparkleB", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLobbySparkleC", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLobbySparkleD", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLobbySparkleYellow", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLobbySparkleYellow_editor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sLogo_Arabic", new spriteProps("langArabic", "folders/Sprites/langArabic.yy")},
	{"sLogo_ChineseT", new spriteProps("langChinese", "folders/Sprites/langChinese.yy")},
	{"sLogo_Default", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLogo_Default856", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sLogo_Japanese", new spriteProps("langJapanese", "folders/Sprites/langJapanese.yy")},
	{"sLogo_Korean", new spriteProps("langKorean", "folders/Sprites/langKorean.yy")},
	{"sLogo_Portuguese", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMSDF_Arabic", new spriteProps("langArabic", "folders/Sprites/langArabic.yy")},
	{"sMSDF_ChineseS", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMSDF_ChineseT", new spriteProps("langChinese", "folders/Sprites/langChinese.yy")},
	{"sMSDF_Japanese", new spriteProps("langJapanese", "folders/Sprites/langJapanese.yy")},
	{"sMSDF_Korean", new spriteProps("langKorean", "folders/Sprites/langKorean.yy")},
	{"sMSDF_Polish", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMSDF_Russian", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMSDF_Swedish", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMSDF_Thai", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMSDF_Turkish", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMSDF_default", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMSDF_fredokaOne", new spriteProps("Fonts", "folders/Sprites/Fonts.yy")},
	{"sMagma", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sMagmaBody", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sMagmaFlareHead", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sMagmaFlareTail", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sMagmaHead", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sMagmaHeadFlow", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sMagmaHeadUnder", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sMagmaSide", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sMagmaSideTop", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sMagmaStreamParticle", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sMainMenu", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sMedal_clearBy10", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_clearBy4", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_clearBy6", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_clearBy8", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessAverage10", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessAverage2", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessAverage4", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessAverage6", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessAverage8", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessHighScore10", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessHighScore2", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessHighScore4", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessHighScore6", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_endlessHighScore8", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMedal_puzzleAllClear", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sMoneyJar", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sMovingWall", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sNFSplash", new spriteProps("netflixSplash", "folders/Sprites/netflixSplash.yy")},
	{"sNFSplash_landscape", new spriteProps("netflixSplash", "folders/Sprites/netflixSplash.yy")},
	{"sNomzo", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sNotifRabbit_Asleep", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_Asleep_Eyes", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_Blink", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_Blink_Eyes", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_Dance_Oneway", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_Dance_Oneway_Eyes", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_Jump", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_Jump_Eyes", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_WalkIn", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotifRabbit_WalkIn_Eyes", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sNotificationMark", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sNotificationMark_left", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sNotificationRabbit_dev", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sObakeWanderingTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sObakeWanderingTestLarge", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sObjectiveBar3Slice_inside", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sObjectiveBar3Slice_outline", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sOnewayPlatform", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sOnewayPlatformLeft", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sOnewayPlatformMiddle", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sOnewayPlatformRight", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sOrderExcludeSign", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sPauseButton", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sPill3SliceOutline", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPill3SliceWhite", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPlayerBox", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerDamage", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerDead", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerGround", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerGroundAsleep", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerGroundPuzzleChair", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerHeu", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerSlam", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerSpin16", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPlayerSpin8", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sPot00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sPotFullAnimation00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sPotWithFruit", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sPuzzle3SliceHeader", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzle3SlicePlay", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleCameraArrow", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleChair", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleChairHung", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleChairRope", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleChair_", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleChair_wallCollision", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleFlower", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleFrames", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleFramesSelected", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleHighlight", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleReturnButton", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleReturnButtonHighlight", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleRock00", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleRock01", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleRock02", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleRock03", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleRock04", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleRock05", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleRock06", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleRock07", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleRoomSetter", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sPuzzleStepFloor", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeBack00", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeBack01", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeBack02", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeBack03", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeBack04", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeBack05", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeFront00", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeFront01", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeFront02", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeFront03", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleTreeFront04", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sPuzzleViewVignette", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleViewVignette_backup853", new spriteProps("UI_Puzzle", "folders/Sprites/UI_Puzzle.yy")},
	{"sPuzzleWall00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sRainbowBar00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sRecipeControl", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sRedSwitch", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sResults3SliceGrey", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResults3SliceYellow", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsBody", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsLobbyButton", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsMeter", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsMeterBubblesTexture", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sResultsMeterCloud", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sResultsMeterMax", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsMeterWavesTexture", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sResultsPadlock", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsReward", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsRewardSplash", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sResultsRewardTutorial", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sResultsScoreText", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsSignA", new spriteProps("ResultsScreen", "folders/Sprites/ResultsScreen.yy")},
	{"sResultsSignA_3slice", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sRouncCornerCrop", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSatisfactionIcon", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sShooterWormTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSlamStake", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSlamStakeGray", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSmallFruitBlue", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSmallFruitGreen", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSmallFruitRed", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSmallFruitYellow", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSoftPadding", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSoftPaddingTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSparkle", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSpiderSpringWeb", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSpikeTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSplashEffectTest00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSplashEffectTest00_out", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSplashEffectTest00outline", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSplashEffectTest01", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSplashEffectTest02", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sStarFruit_00", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sStarFruit_01", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sStarFruit_02", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sStarFruit_03", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sStarFruit_04", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sStarFruit_05", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sStarJuiceDew", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sStarJuiceDew_border", new spriteProps("Player", "folders/Sprites/Player.yy")},
	{"sSwitchPillarBlue", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSwitchPillarRed", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSymbolJungleLowerCorner", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSymbolJungleSide", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sSymbolJungleUpperCorner", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTentoBall_DeadInner", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sTentoBall_DeadShellParts1", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sTentoBall_InnerBody", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sTentoBall_Shell", new spriteProps("Enemies", "folders/Sprites/Enemies.yy")},
	{"sTestBallEnemy", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestBeastFire", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestBoostPlatform", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestBubble", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestBubble32", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestBuddy", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestCoin", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestDreamBgObject", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestDreamWindow", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestMushroom", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestSign", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestSpikeEnemy", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestSpikyHead", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestTranscendedBeastFace", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sTestWindowBackground", new spriteProps("Lobby", "folders/Sprites/Lobby.yy")},
	{"sTestWood", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTestX", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sThinPlatform", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sThinkingChair_test", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sThinkingChair_test_floorCol", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sThumbsUp", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTouchControlMarker", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTrajectoryDash", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTranBeast_ThirdEyeLight", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sTransBeastFace_Delicious", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sTransBeastFace_Transcended", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sTransBeast_AuraSparkFx", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sTransBeast_Body", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sTransBeast_Ear", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sTransBeast_EyeLight", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sTranscendedBeast_CropBlack", new spriteProps("FinalArea", "folders/Sprites/FinalArea.yy")},
	{"sTranscendenceWave", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sTranslucentBox16Blue", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTranslucentBox16Red", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTrophy3SliceHeader", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sTrophyCase", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sTrophyRoomTrophy", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTrophyTextbox", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sTrophyTextboxHighlight", new spriteProps("UI_Trophy", "folders/Sprites/UI_Trophy.yy")},
	{"sTrophy_test", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTunnelBackgroundParts", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutFruitRespawnArea", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutJuiceAltar", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutSeqFadeArea", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutSeqStartArea", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialAppearOnewayPlatform", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialArrow", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialBall", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialDetail_cloud00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialDetail_cloud01", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialDetail_cloud02", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialDetail_cloud03", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialDetail_cloud04", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialDetail_rock00", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialDetail_rock01", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialDetail_rock02", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialDetail_rock03", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialFingerSwipeBlue", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialFingerSwipeRed", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialFingerTap", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialJumpArrow1", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialJumpOrb", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialPlatformSpawn", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialPressurePlateGreen", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialRepeatSwipeTest", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialSlamTest", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialSwipeTest", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialSwitch", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sTutorialSwitchL", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialSwitchL613", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialSwitchM", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sTutorialWallBounceTrajectory", new spriteProps("Tutorial", "folders/Sprites/Tutorial.yy")},
	{"sUI160circle", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUI160line", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUI320circle", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIBackpack_", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIFingerTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIGacha_", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIPixel", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIRecipeCloudOutline", new spriteProps("BeastInGame", "folders/Sprites/BeastInGame.yy")},
	{"sUIequipmentCollectionBox", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIequipmentSlot", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIheart", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIpauseButton", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUItestThoughtCloud", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUIthoughtCloudWhite", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUItoggleSwitchTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sUiSmallBeast", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sVineFlower", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sVineFlowerL", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sVineFlowerR", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sVineFlower_neon", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sVineL", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sVinePart", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sVinePart_neon", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sVineR", new spriteProps("Details", "folders/Sprites/Details.yy")},
	{"sWallCrawlerTest", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sWallCrawlerTestDead", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sWallet", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sWalletVariation", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"softwall_01", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"softwall_02", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sprite118", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"sprite167", new spriteProps("Sprites", "folders/Sprites.yy")},
	{"switch_on", new spriteProps("Sprites", "folders/Sprites.yy")},
};

#endregion





#region Sprite dumper

int missingManifests = 0;
int frameCountMismatch = 0;

// The project's sprite .yy files are already correct for this IDE version, so we
// read the frame/layer names out of them and only write images. Nothing about the
// manifest format is assumed, which keeps this working across GameMaker versions.
void DumpSprite(UndertaleSprite sprite)
{
	string name = sprite.Name.Content;
	string dir = $"{rootPath}sprites\\{name}\\";
	string yyPath = $"{dir}{name}.yy";

	if (!File.Exists(yyPath))
	{
		Interlocked.Increment(ref missingManifests);
		return;
	}

	// .yy files are JSON with trailing commas, which Newtonsoft rejects by default.
	string text = Regex.Replace(File.ReadAllText(yyPath), @",(\s*[}\]])", "$1");
	var data = JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JToken>(text);

	var frames = data["frames"].Select(f => (string)f["name"]).ToList();
	var layers = data["layers"].Select(l => (string)l["name"]).ToList();
	string layerName = layers.Count > 0 ? layers[0] : "default";

	if (frames.Count != sprite.Textures.Count)
		Interlocked.Increment(ref frameCountMismatch);

	int count = Math.Min(frames.Count, sprite.Textures.Count);

	for (int j = 0; j < count; j++)
	{
		var frame = sprite.Textures[j];
		IMagickImage<byte> image;

		try
		{
			if ((int)sprite.SSpriteType != 0 || frame.Texture is null)
				throw new Exception();

			image = worker.GetTextureFor(frame.Texture, frames[j] + ".png", true);
		}
		catch
		{
			// Missing source texture - emit a magenta marker at the sprite's size
			// so it's obvious in the IDE rather than silently blank.
			image = new MagickImage(MagickColors.Magenta,
				(uint)Math.Max(1, sprite.Width), (uint)Math.Max(1, sprite.Height));
		}

		string layerDir = $"{dir}layers\\{frames[j]}\\";
		Directory.CreateDirectory(layerDir);

		TextureWorker.SaveImageToFile(image, $"{dir}{frames[j]}.png");
		TextureWorker.SaveImageToFile(image, $"{layerDir}{layerName}.png");
	}
}

public void SetupProgress(string current, double maxValue) => SetProgressBar(null, current, 0, maxValue);
public void IncrementProgress() => IncrementProgressParallel();
public void UpdateStatus(string status) => SetUMTConsoleText(status);

public async Task DumpSprites()
{
	SetupProgress("Sprites", Data.Sprites.Count);
	int count = 0;
	
	await Parallel.ForEachAsync(Data.Sprites, (source, token) =>
	{
		if (!ignore.Contains(source.Name.Content))
		{
			UpdateStatus($"({count} / {Data.Sprites.Count}) {source.Name.Content}");
			DumpSprite(source);
		}
		Interlocked.Increment(ref count);
		IncrementProgress();
		return ValueTask.CompletedTask;
	});
}

#endregion


#region Sound dumper

// Audio-group loading is lifted from UndertaleModTool's own export scripts:
// sounds in a non-default group live in audiogroupN.dat beside the data file.
string DEFAULT_AUDIOGROUP_NAME = "audiogroup_default";
byte[] EMPTY_WAV_FILE_BYTES = System.Convert.FromBase64String("UklGRiQAAABXQVZFZm10IBAAAAABAAIAQB8AAAB9AAAEABAAZGF0YQAAAAA=");
Dictionary<string, IList<UndertaleEmbeddedAudio>> loadedAudioGroups;

IList<UndertaleEmbeddedAudio> GetAudioGroupData(UndertaleSound sound)
{
	if (loadedAudioGroups is null)
		loadedAudioGroups = new Dictionary<string, IList<UndertaleEmbeddedAudio>>();

	string groupName = sound.AudioGroup is not null ? sound.AudioGroup.Name.Content : DEFAULT_AUDIOGROUP_NAME;

	// Cache misses too, otherwise a bad group re-reports once per sound.
	if (loadedAudioGroups.ContainsKey(groupName))
		return loadedAudioGroups[groupName];

	string groupPath = Path.Combine(dataPath, "audiogroup" + sound.GroupID + ".dat");
	if (!File.Exists(groupPath))
	{
		loadedAudioGroups[groupName] = null;
		ScriptMessage($"Audio group file not found:\n{groupPath}\n\nSounds in \"{groupName}\" will be written as silence.");
		return null;
	}

	try
	{
		// UndertaleIO.Read's signature has changed across UTMT versions, so resolve
		// the overload at runtime and fill anything past the stream with its default.
		var read = typeof(UndertaleIO)
			.GetMethods(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Static)
			.Where(m => m.Name == "Read"
				&& m.GetParameters().Length >= 1
				&& typeof(Stream).IsAssignableFrom(m.GetParameters()[0].ParameterType))
			.OrderBy(m => m.GetParameters().Length)
			.FirstOrDefault();

		if (read is null)
		{
			loadedAudioGroups[groupName] = null;
			ScriptMessage("Could not find UndertaleIO.Read - your UndertaleModTool version may be unsupported.");
			return null;
		}

		UndertaleData data;
		var pars = read.GetParameters();
		var args = new object[pars.Length];

		using (var stream = new FileStream(groupPath, FileMode.Open, FileAccess.Read))
		{
			args[0] = stream;
			for (int i = 1; i < pars.Length; i++)
				args[i] = pars[i].HasDefaultValue ? pars[i].DefaultValue : null;

			data = (UndertaleData)read.Invoke(null, args);
		}

		loadedAudioGroups[groupName] = data.EmbeddedAudio;
		return data.EmbeddedAudio;
	}
	catch (Exception e)
	{
		loadedAudioGroups[groupName] = null;
		ScriptMessage($"Error loading {groupName}:\n{(e.InnerException ?? e).Message}");
		return null;
	}
}

byte[] GetSoundData(UndertaleSound sound)
{
	if (sound.AudioFile is not null)
		return sound.AudioFile.Data;

	if (sound.GroupID > Data.GetBuiltinSoundGroupID())
	{
		var group = GetAudioGroupData(sound);
		if (group is not null)
			return group[sound.AudioID].Data;
	}
	return EMPTY_WAV_FILE_BYTES;
}

// Poinpy's sound .yy files stay in the repo; only the audio payload is dumped.
// soundFile is always "<name>.<ext>", so the name is derived from the flags.
void DumpSound(UndertaleSound sound)
{
	bool compressed = sound.Flags.HasFlag(UndertaleSound.AudioEntryFlags.IsCompressed);
	bool embedded = sound.Flags.HasFlag(UndertaleSound.AudioEntryFlags.IsEmbedded);
	string name = sound.Name.Content;
	string ext = (embedded && !compressed) ? ".wav" : ".ogg";
	string dir = $"{rootPath}sounds\\{name}\\";

	Directory.CreateDirectory(dir);

	// Neither embedded nor compressed means the file sits loose beside the data file.
	if (!embedded && !compressed)
	{
		string loose = $"{dataPath}{name}{ext}";
		if (File.Exists(loose))
			File.Copy(loose, $"{dir}{name}{ext}", true);
		return;
	}

	File.WriteAllBytes($"{dir}{name}{ext}", GetSoundData(sound));
}

// Sequential on purpose - the audio-group cache above is not thread safe.
public void DumpSounds()
{
	SetupProgress("Sounds", Data.Sounds.Count);
	int count = 0;

	foreach (var sound in Data.Sounds)
	{
		UpdateStatus($"({count++} / {Data.Sounds.Count}) {sound.Name.Content}");
		DumpSound(sound);
		IncrementProgress();
	}
}

#endregion

#region Font dumper

// Same idea as sounds - the .yy stays put, only the texture is dumped.
void DumpFonts()
{
	SetupProgress("Fonts", Data.Fonts.Count);

	foreach (var font in Data.Fonts)
	{
		string name = font.Name.Content;
		string dir = $"{rootPath}fonts\\{name}\\";
		Directory.CreateDirectory(dir);

		if (font.Texture != null)
		{
			var image = worker.GetTextureFor(font.Texture, name + ".png", true);
			TextureWorker.SaveImageToFile(image, $"{dir}{name}.png");
		}

		IncrementProgress();
	}
}

#endregion

ScriptMessage("Choose the folder containing Poinpy.yyp.");

var dialog = new FolderBrowserDialog();
dialog.ShowNewFolderButton = false;

if (dialog.ShowDialog() != DialogResult.OK)
	return;
rootPath = $"{dialog.SelectedPath}\\";

// do it
StartProgressBarUpdater();

await Task.Run(DumpSprites);
await Task.Run(DumpSounds);
await Task.Run(DumpFonts);

await StopProgressBarUpdater();
HideProgressBar();
SetUMTConsoleText("");

// Included files
var includedFiles = new List<string>()
{
	"BlurredBoxShot_Landscape.jpg",
	"BlurredBoxShot_Portrait.jpg",
	"GameCredentials_Android.jwe",
	"androidrumble.ext",
	"controllerblacklist.csv",
	"controllertypes.csv",
	"fillblacksplash.png",
	"fontchineses_arteyuangbheavy.json",
	"fontchineset_aryuanb5extrabold.json",
	"fontjapanese_seuratpron_eb.json",
	"fontkorean_yoongulimpro760.json",
	"fontrussian_rubikmedium.json",
	"fredokaone.json",
	"gamecontrollerdb.txt",
	"gamecontrollerdblicense.txt",
	"netflix.ext",
	"poinpy_loc_kit_2022.03.31+lqa_edits_thai_zws_2022.04.14.xlsx",
	"poinpytext_languagenames.csv",
	"poinpytext_loc_041922.csv",
	"portrait_splash.png",
	"rounded-x.json",
	"smsdf_arabic.json",
	"smsdf_chineses.json",
	"smsdf_chineset.json",
	"smsdf_default.json",
	"smsdf_fredokaone.json",
	"smsdf_japanese.json",
	"smsdf_korean.json",
	"smsdf_polish.json",
	"smsdf_russian.json",
	"smsdf_swedish.json",
	"smsdf_thai.json",
	"smsdf_turkish.json",
	"smsdf_udmarugosmall.json",
	"splash.png",
	"udmarugosmall__unused.json",
	"udmarugosmall_ch__unused.json",
};

var includedFolders = new List<string>()
{
	"dexopt",
	"gmlive",
	"include",
};

Directory.CreateDirectory($"{rootPath}datafiles");
foreach (var i in includedFiles)
{
	if (File.Exists($"{dataPath}{i}"))
		File.Copy($"{dataPath}{i}", $"{rootPath}datafiles\\{i}", true);
}

void includeFolder(string source, string dest)
{
	if (!Directory.Exists(source))
		return;
	Directory.CreateDirectory(dest);
	foreach (var file in Directory.GetFiles(source))
		File.Copy(file, Path.Combine(dest, Path.GetFileName(file)), true);
}
foreach (var i in includedFolders)
	includeFolder($"{dataPath}{i}", $"{rootPath}datafiles\\{i}");

// done
if (missingManifests > 0 || frameCountMismatch > 0)
	ScriptMessage(
		$"{missingManifests} sprites had no .yy in the project (skipped).\n" +
		$"{frameCountMismatch} sprites had a different frame count than the data file.");

worker.Dispose();

if (File.Exists($"{rootPath}Poinpy.yyp"))
	ScriptMessage("Done! You can open Poinpy.yyp in GameMaker now.");
else
	ScriptMessage("Done! Move the exported files into the Poinpy project folder. Replace all files if asked.");

Process.Start("explorer.exe", rootPath);
