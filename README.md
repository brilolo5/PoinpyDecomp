# PoinpyDecomp


A decompilation of Ojiro Fumoto's former Netflix game, POINPY, for modding and porting access.<br>

## How do I use this?
1. You will need to own a copy of the latest Netflix version (1.1.1) for Android (the iOS/Google Play release is not supported due to using YYC, whereas the Netflix version is VM). This can be acquired if you downloaded the game through the Google Play Store while it was there, in combination with tools like [SAI](https://github.com/aefyr/SAI) to extract the APK.
2. Clone the repo.
3. Download the latest version of [UndertaleModTool](https://github.com/UnderminersTeam/UndertaleModTool) (GUI, NOT CLI), you will need it to run the asset extractor script.<br>
4. In the place you extracted the game's data to, locate the ``game.droid`` file and load it with UndertaleModTool.<br>
5. After loading the file, in UndertaleModTool, go to ``Scripts -> Run other script...`` and load the ``PoinpyDecompiler.csx`` script that can be found in the project's root.<br>
6. Once the script is done running, just simply open ``Poinpy.yyp`` inside of the latest version of Gamemaker Studio 2!

## Special Thanks
[UnderminersTeam](https://github.com/UnderminersTeam) - Made [UndertaleModTool](https://github.com/UnderminersTeam/UndertaleModTool).<br>
[danielah05](https://github.com/danielah05), [TeamBlossomDevs](https://github.com/TeamBlossomDevs/), and [femloy](https://github.com/femloy/) - Made various decomps of GameMaker Studio 2 games that inspired me to make my own.<br>
[Ojiro Fumoto](https://x.com/OjiroFumoto) - Made POINPY.

## Notes
1. This might not be complete and need some patching in the future, but most of the game is fixed. Keep in mind this was only tested on Windows, I have no idea if it works on other platforms. Contributions and forks are welcome!

### Known issues
1. oGimBubble does not render in the game at all; no fix found.
