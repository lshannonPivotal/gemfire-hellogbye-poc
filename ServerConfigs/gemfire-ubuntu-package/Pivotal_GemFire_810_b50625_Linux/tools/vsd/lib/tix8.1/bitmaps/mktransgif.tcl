#
#	$Id: mktransgif.tcl,v 1.1.1.1 2001/06/15 23:23:47 darrel Exp $
#
#!/usr/local/bin/tclsh

set dont(plusarm.gif)  1
set dont(minusarm.gif) 1

foreach file [glob *.gif] {
    if ![info exists dont($file)] {
	puts "giftool -1 -B $file"
    }
}

