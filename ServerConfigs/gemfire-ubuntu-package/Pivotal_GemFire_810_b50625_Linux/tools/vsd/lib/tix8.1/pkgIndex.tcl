# Tcl package index file, version 1.0
#
# $Id: pkgIndex.tcl.in,v 1.1.1.1 2001/06/15 23:23:51 darrel Exp $
#

package ifneeded Tix 8.1.8.3 [list load "[file join [file dirname $dir] libtix8.1.8.3.a]" Tix]
package ifneeded Tixsam 8.1.8.3 [list load "[file join [file dirname $dir] libtixsam8.1.8.3.a]" Tixsam]
