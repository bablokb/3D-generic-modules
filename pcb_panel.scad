// ---------------------------------------------------------------------------
// 3D-Model (OpenSCAD): Generic model for a PCB-panel.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/3D-datalogger-v2-case
// ---------------------------------------------------------------------------

include <BOSL2/std.scad>
include <dimensions.scad>
module pcb_panel(x, y, z,
             d_screw=2.5, o_screw=3, h_screw=1.4, d2_screw=4.28,
             r=3, edges="Z", screws=true) {
  difference() {
    // solid space
    cuboid([x,y,z], rounding=r, edges=edges, anchor=BOTTOM+CENTER);
    // minus screw-holes
    if (screws) {
      move([-x/2+o_screw,+y/2-o_screw,-FUZZ]) {
          cylinder(d=d_screw, h=z,anchor=BOTTOM+CENTER);
          zmove(z-h_screw+FUZZ) 
            cylinder(d=d2_screw, h=z,anchor=BOTTOM+CENTER);
      }
      move([-x/2+o_screw,-y/2+o_screw,-FUZZ]) { 
        cylinder(d=d_screw, h=z+2*FUZZ,anchor=BOTTOM+CENTER);
        zmove(z-h_screw+FUZZ) 
          cylinder(d=d2_screw, h=z,anchor=BOTTOM+CENTER);
      }
      move([x/2-o_screw,y/2-o_screw,-FUZZ]) {
        cylinder(d=d_screw, h=z,anchor=BOTTOM+CENTER);
        zmove(z-h_screw+FUZZ) 
          cylinder(d=d2_screw, h=z,anchor=BOTTOM+CENTER);
      }
      move([x/2-o_screw,-y/2+o_screw,-FUZZ]) { 
        cylinder(d=d_screw, h=z,anchor=BOTTOM+CENTER);
        zmove(z-h_screw+FUZZ) 
          cylinder(d=d2_screw, h=z,anchor=BOTTOM+CENTER);
      }
    }
  }
}
