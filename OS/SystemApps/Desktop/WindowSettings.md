## StartupSettings Info

When user runs program, UwU calls config file, where developer can state some settings for launching, like Size of window or name of program. 

## Settings
"width" and "height" - width and height of window

"name" - name that will be shown in bar and other components

"executable" - file to launch in App folder

"bar" - if false, bar will be hidden.

"buttonPosX" and "buttonPosY" - you can set position of buttons that placed in bar by default. 

**Important: when stating ButtonPosX - position of close button, not fullscreen.**

"disableFullScreen" - currently fullscreen is in dev. dont mind it.

"disableHide" - for programs where folding/unfolding works incorrectly, you can just turn this ability off.

## Template

{
    width,
    height,
    "name",
    executable,
    bar,
    buttonPosX,
    buttonPosY,
    disableFullScreen,
    disableHide,
}