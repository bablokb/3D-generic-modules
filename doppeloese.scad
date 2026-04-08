// ---------------------------------------------------------------------------
// 3D-Model (OpenSCAD): Doppelöse
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/3D-generic-modules
// ---------------------------------------------------------------------------

include <BOSL2/std.scad>
include <dimensions.scad>

H     = 1.6;
DI    = 2.8;
DO    = 7.5;
WIDTH = 2*DO;

module oese(mask=false) {
  if (mask) {
    zmove(-FUZZ) cyl(d=DI, h=H+2*FUZZ, anchor=BOTTOM+CENTER);
  } else {
    cyl(d=DO, h=H, anchor=BOTTOM+CENTER);
  }
}

module doppel_oese() {
  difference() {
    hull() xflip_copy() xmove(DO/2+GAP) oese();
    xflip_copy() xmove(DO/2+GAP) oese(true);
  }
}

doppel_oese();
