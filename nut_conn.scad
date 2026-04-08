// ---------------------------------------------------------------------------
// 3D-Model (OpenSCAD): generic component for connectors with nuts.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/3D-generic-modules
// ---------------------------------------------------------------------------

include <BOSL2/std.scad>
include <BOSL2/screws.scad>
include <dimensions.scad>
include <fase.scad>

NC_SIZE_25 = "M2.5x1,2.5";  // size as defined by BOSL
NC_D_25    = 7.2;           // outer dimension of fase
NC_NH_25   = 2.2;           // height of nut
NC_CH_25   = 6.7;           // height of connector without fase
NC_SLOP_25 = GAP;           // slop for nut and screw-hole

// --- ruthex thread pocket   ------------------------------------------------

module nut_conn(nut_size, nut_h, conn_d, conn_h, circular=true, fase=true, slop=GAP) {
  difference() {
    union() {
      // connector
      if (circular) {
        cyl(h=conn_h, d=conn_d, anchor=TOP+CENTER);
      } else {
        cuboid([conn_d,conn_d,conn_h], anchor=TOP+CENTER);
      }
      // fase
      if (fase && circular) {
        zmove(-conn_h) cfase(d=conn_d,h=conn_d,orient="fl");
      } else if (fase && !circular) {
        move([-conn_d/2,0,-conn_h]) fase(x=conn_d,y=conn_d,h=conn_d,orient="yl");
      }
    }
    // minus screw-hole and nut
    zmove(-nut_h+FUZZ) screw_hole(nut_size,$slop=slop/2, anchor=TOP+CENTER)
      position(TOP) nut_trap_inline(nut_h,$slop=slop);
  }
}

// --- standard module for M2.5 threads   ------------------------------------

module nc25(d_extra=0, circular=true, fase=true) {
  nut_conn(nut_size=NC_SIZE_25,
           nut_h=NC_NH_25,
           conn_d=d_extra+NC_D_25,
           conn_h=NC_CH_25,
           circular=circular,fase=fase,
           slop=NC_SLOP_25);
}

// demos
//xdistribute(20) {
//  nc25();
//  nc25(circular=false);
//  nc25(d_extra=10, fase=false);
//  nc25(circular=false, fase=false);
//}

// for size tests
//xmove(-10) nut_conn(nut_size=NC_SIZE_25,
//           nut_h=NC_NH_25,
//           conn_d=9,
//           conn_h=2*NC_NH_25,
//           circular=false,fase=false,
//           slop=2*GAP);
//
//nut_conn(nut_size=NC_SIZE_25,
//           nut_h=NC_NH_25,
//           conn_d=8,
//           conn_h=2*NC_NH_25,
//           circular=false,fase=false,
//           slop=GAP);
//
//xmove(+10)  nut_conn(nut_size=NC_SIZE_25,
//           nut_h=NC_NH_25,
//           conn_d=7,
//           conn_h=2*NC_NH_25,
//           circular=false,fase=false,
//           slop=0.5*GAP);
