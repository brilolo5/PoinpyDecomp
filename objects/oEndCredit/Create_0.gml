if (live_call())
    return global.live_result;

partOfEnding = 1;

if (room == rmPlayableMainMenu)
    partOfEnding = -1;

logoSprite = getLogoSprite();
logoScale = getLogoScale();
outline_init();
creditString = "";

addTitle = function(arg0, arg1 = "ER_BLUE", arg2 = "0.7")
{
    creditString += ("[scale," + arg2 + "][" + arg1 + "]" + arg0 + "[scale,0.2]\n\n[/scale]");
};

addDevName = function(arg0, arg1 = "ER_BLACK", arg2 = "1")
{
    creditString += ("[scale," + arg2 + "][" + arg1 + "]" + arg0 + "[scale,0.4]\n");
};

addSNS = function(arg0, arg1 = "ER_GREY2", arg2 = "0.7")
{
    creditString += ("[scale," + arg2 + "][" + arg1 + "]" + arg0 + "\n[/scale]");
};

addGroupTitle = function(arg0, arg1 = "ER_BLACK", arg2 = "1.0")
{
    creditString += ("[scale," + arg2 + "][" + arg1 + "]" + arg0 + "[scale,0.4]\n");
};

addGroupNames = function(arg0, arg1 = "ER_GREY1", arg2 = "0.7")
{
    creditString += ("[scale," + arg2 + "][" + arg1 + "]" + arg0 + "\n[/scale]");
};

addSprite = function(arg0, arg1, arg2 = "0.1", arg3 = "pin_left")
{
    creditString += ("[scale," + arg2 + "]" + "[" + arg3 + "]" + "[" + arg0 + "," + arg1 + "]");
};

addSpaceBetweenMainDev = function()
{
    creditString += "\r\n\r\n\r\n\r\n\r\n\r\n";
};

scrollSpeed = 0.5;
scrollSpeed_default = 0.5;
scrollHoldBuffer = 0;
logoBoingTime = 0;
musicFading = 0;
creditMusic = -1;
endSkipHold = -1;
creditScrollY = 0;
currentSequence = "title appear";
sequenceTimer = 0;
springSpeed = 0;
sequenceInit = 0;
stopScroll = -1;
cropSurface = -1;
creditSurface = -1;
debug = 1;
global.playerControlLock = 1;
var _spaceBetweenMainStaff = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n";
creditScrollY = 0;

generateCreditString = function()
{
    creditString = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n";
    addTitle("[pin_left]\r\n\r\n\r\nGame Director\r\nGame Designer\r\nLevel Designer\r\nPlanner\r\nProgrammer");
    addDevName("Ojiro Fumoto");
    addSNS("@OjiroFumoto");
    addSpaceBetweenMainDev();
    addTitle("[pin_right]\r\nArt Director\r\nArtist", "ER_GREEN");
    addDevName("error403");
    addSNS("@2nd_error403");
    addSpaceBetweenMainDev();
    addTitle("[pin_left]\r\nComposer", "ER_YELLOW");
    addDevName("Calum Bowen");
    addSNS("@boenyeah");
    addSpaceBetweenMainDev();
    addTitle("[pin_center]\r\nSound Design", "ER_RED");
    addGroupTitle("A Shell in the Pit");
    addSNS("@AShellinthePit\r\n");
    
    addTeamTitle = function(arg0, arg1 = "ER_GREY1", arg2 = "0.6")
    {
        creditString += ("[scale," + arg2 + "][" + arg1 + "]" + arg0 + "[scale,0.2]\n[/scale]");
    };
    
    addTeamName = function(arg0, arg1 = "ER_GREY1", arg2 = "0.8")
    {
        creditString += ("[scale," + arg2 + "][" + arg1 + "]" + arg0 + "[scale,0.6]\n[/scale]");
    };
    
    addTeamTitle("[pin_center]\r\nAudio Direction", "ER_RED");
    addTeamName("Joey Van Alten");
    addTeamTitle("[pin_center]\r\nSound Design\r\nTechnical Audio", "ER_RED");
    addTeamName("Preston Wright");
    addTeamTitle("[pin_center]\r\nSound Design", "ER_RED");
    addTeamName("Michelle del Mundo");
    addTeamTitle("[pin_center]\r\nAudio Production", "ER_RED");
    addTeamName("Rachel Sim");
    addSpaceBetweenMainDev();
    addTitle("[pin_right]\r\nAdditional Programming", "ER_BLUE");
    addDevName("Juju Adams");
    addSNS("@jujuadams");
    addSpaceBetweenMainDev();
    addTitle("[pin_left]\r\nAdditional Artwork", "ER_GREEN");
    addDevName("Gobo3D");
    addSNS("@gobo3D");
    addSpaceBetweenMainDev();
    addTitle("[pin_right]\r\nLogo Design", "ER_YELLOW");
    addDevName("Cory Schmitz");
    addSNS("@CorySchmitz");
    addSpaceBetweenMainDev();
    addTitle("[pin_center]\r\nPublishing", "ER_RED");
    addGroupTitle("[ER_BLACK]Devolver Digital");
    addSNS("@devolverdigital\r\n");
    addGroupNames("Fork Parker\r\nRick Stults\r\nGraeme Struthers\r\nAndrew Parsons\r\nHarry Miller\r\nMike Wilson\r\nNigel Lowrie\r\nAnna Sajecka\r\nKate Ludlow\r\nKert Gartner\r\nTena Zigmundovac\r\nVieko Franetovic\r\nJM Specht\r\nJared Stults\r\nRobbie Paterson\r\nJonathan \"JR\" Rosales\r\nHazel Yang\r\nSimon Chang\r\nJohn Bartkiw\r\nMark Hickey\r\nAbby Kuo\r\nKaren Marshall\r\nLuke Vernon\r\nJuan de la Torre\r\nJeff \"Smitty\" Smith\r\nAdoné Kitching\r\nMatt Nickerson\r\nMark Lloyd\r\nRodrigo Batelli\r\nDouglas Morin\r\nClara Sia\r\nMarcus Iremonger\r\nJohn Tyrrell\r\nBrian Chadwick\r\nDaniel Widdicombe\r\nDaniel Lucic\r\nKeith Chaudhary\r\nViraj Bihal\r\nSarah Seaby\r\nEli Penner\r\nJoshua Cauller\r\nBridie Roman\r\nLilac Chang\r\nDilip Patel");
    addSpaceBetweenMainDev();
    addTitle("[pin_center]\r\nPublic Relations\r\n", "ER_BLUE");
    addGroupTitle("[ER_BLACK]Tinsley PR");
    addSNS("");
    addGroupNames("Stephanie Tinsley\r\nThomas Schulenberg\r\nColby Tortorici\r\n");
    addGroupTitle("\r\nCosmocover");
    addSNS("");
    addGroupNames("Salima Bessahraoui\r\nJohn Tyrrell\r\nNyssa Woznicki\r\nMatej Samide\r\nAnouchka Besson\r\nMaxence, Fredi, Carlos and Davide\r\nFabian Mario Doehla\r\nKinga Delimat\r\nJens JJ Fernando Jacobsen\r\nFrimousse and Misty\r\n");
    addGroupTitle("\r\nIndigo Pearl");
    addSNS("");
    addGroupNames("Anita Wong\r\nLuke Bennett\r\n");
    addGroupTitle("\r\nEasy Mode Agency");
    addSNS("");
    addGroupNames("Danis Kuchin\r\n");
    addGroupTitle("\r\nPOWER UP PR");
    addSNS("");
    addGroupNames("Doug Johns\r\nVanessa Johns\r\nJayden Perry\r\n");
    addGroupTitle("\r\nKakehashi Games");
    addSNS("");
    addGroupNames("Zach Huntley\r\n");
    addSpaceBetweenMainDev();
    addTitle("[pin_center]\r\nLocalization\r\n", "ER_GREEN");
    addGroupTitle("Loc & Load");
    addSNS("");
    addGroupNames("Sophie Cristobal\r\nPatrick Baron\r\nFred Muller\r\n");
    addSNS("");
    addGroupTitle("Keywords Studios");
    addSpaceBetweenMainDev();
    addSpaceBetweenMainDev();
    addTitle("[pin_center]\r\nQuality Assurance\r\n", "ER_YELLOW");
    addGroupTitle("Lionbridge");
    addSNS("");
    addSNS("");
    addGroupTitle("Testronic");
    addSNS("");
    addSNS("");
    addGroupTitle("DAQA");
    addSNS("");
    addGroupNames("Devin Seto\r\nTim Hudson\r\nBen Wibberley\r\nEdd Buffery\r\n");
    addSNS("");
    addGroupTitle("Keywords Studios");
    addSpaceBetweenMainDev();
    addSpaceBetweenMainDev();
    addTitle("[pin_center]\r\nAdditional Programming", "ER_RED");
    addGroupTitle("22nd Century Toys");
    addSNS("");
    addGroupNames("Tony Bratton\r\nSean Barton\r\nAndy Arizpe\r\nJoe Barton\r\nCory Jackson\r\nTim Godwin\r\nMatt Scates\r\nJeremy Jorgenson\r\nCullen Sturdivant\r\nEdwin Silerio\r\nKeola Silva\r\nDelaney Bannon");
    addSpaceBetweenMainDev();
    addTitle("[pin_center]\r\nSpecial Thanks\r\n", "ER_BLUE");
    addGroupNames("Yuki Fumoto\r\nMegazaru\r\nHasya\r\nSentaqu\r\nKazuya Kikkawa\r\nAsobu\r\nNama Takahashi\r\nMakoto Goto\r\nThe Poppenkast\r\nZach Gage\r\nMartin Jonasson\r\nDerek Yu\r\nEirik Suhrke");
    addSpaceBetweenMainDev();
    addSpaceBetweenMainDev();
};

generateCreditString();
