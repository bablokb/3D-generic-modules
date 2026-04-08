// ---------------------------------------------------------------------------
// 3D-Model (OpenSCAD): Threaded Case.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/3D-generic-modules
// ---------------------------------------------------------------------------

include <BOSL2/std.scad>
include <dimensions.scad>
include <fase.scad>
include <ruthex.scad>
include <nut_conn.scad>

// --- basic case   ----------------------------------------------------------

module case_base(x, y, z, b, w, r) {
  // base plate
  cuboid([x,y,b], rounding=r, edges="Z", anchor=BOTTOM+CENTER);
  // sides
  rect_tube(size=[x,y], wall=w, h=b+z,
            rounding=r, anchor=BOTTOM+CENTER);
}

// --- support for PCB   -----------------------------------------------------

module case_supports(x,y,w,h) {
  move([-x+w-FUZZ,0,h])
    fase(w,y,w+3,orient="yl");
  move([+x-w+FUZZ,0,h])
    fase(w,y,w+3,orient="yr");
  move([0,-y+w-FUZZ,h])
    fase(x,w,w+3,orient="xf");
  move([0,+y-w+FUZZ,h])
    fase(x,w,w+3,orient="xb");
}

// --- thread pockets   -------------------------------------------------------

module case_pockets(x, y, h, w, offset, ruthex) {
  xflip_copy() yflip_copy()
    move([-x+offset,-y+offset,h]) {
     if (ruthex) {
       ruthex25(do_extra=w/2);
    } else {
       nc25(d_extra=w/2);
    }
  }
}

// --- threaded-case composite object   ---------------------------------------

module case_threaded(x_pcb, y_pcb, z_case=0, z_pcb=1.6, 
                      z_base=BT, wall=W4, rounding=3, ruthex=true) {
  // case and all supports
  x_case = x_pcb + 2*wall + GAP;
  y_case = y_pcb + 2*wall + GAP;
  case_base(x_case, y_case, z_case, z_base, wall, rounding);
  case_supports(x_case/2, y_case/2, wall, h=z_case-z_pcb+z_base);
  case_pockets(x_pcb/2, y_pcb/2,
               h=z_case-z_pcb+z_base, w=wall,
               offset=rounding, ruthex=ruthex);
}

//case_threaded(80,50,20, ruthex=false);