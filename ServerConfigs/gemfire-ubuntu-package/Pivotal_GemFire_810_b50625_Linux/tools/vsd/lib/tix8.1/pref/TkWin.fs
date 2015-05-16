#
# $Id: TkWin.fs,v 1.1.1.1 2001/06/15 23:23:47 darrel Exp $
#

proc tixSetFontset {} {

    global tixOption

    set tixOption(font)         "windows-message"
    set tixOption(bold_font)    "windows-status"
    set tixOption(menu_font)    "windows-menu"
    set tixOption(italic_font)  "windows-message"
    set tixOption(fixed_font)   "systemfixed"
    set tixOption(border1)      1
}

