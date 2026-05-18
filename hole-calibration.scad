// ---------------------------------------------------------------------------
// 3D-Model (OpenSCAD): Hole calibration ruler.
//
// Hole calibration is specific to filament-type and color.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/3D-generic-modules
// ---------------------------------------------------------------------------

include <BOSL2/std.scad>

$fn= $preview ? 32 : 128;
FUZZ = 0.001;

X = 50;
Y = 12;
Z = 3.0;
SPACE = 10;

module hole_ruler(size) {
  difference() {
    cuboid([X, Y, Z], anchor=BOTTOM+CENTER);
    xcopies(n=5, spacing=SPACE) {
      ymove(Y/5) zmove(-FUZZ) cyl(d=size+$idx*0.1,h=Z+2*FUZZ, anchor=BOTTOM+CENTER);
      ymove(-Y/4) zmove(Z-0.2)
        linear_extrude(0.3) text(str("+0.",$idx), size=Y/5, halign="center");
    }
    // screw size on bottom
    zmove(-FUZZ) ymove(-Y/4) linear_extrude(0.4) 
      text(str(size), size=Y/3, valign="center", halign="center");
  }
}

hole_ruler(2.5);
