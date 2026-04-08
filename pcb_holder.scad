// -----------------------------------------------------------------------------
// 3D-Model (OpenSCAD): PCB-holder.
//
// Author: Bernhard Bablok
// License: GPL3
//
// https://github.com/bablokb/3D-generic-modules
// ---------------------------------------------------------------------------

include <dimensions.scad>
include <BOSL2/std.scad>

Z_PCB_DEF = 1.6;
Z_SUP_DEF = 2.0;

// --- helper functions to expose dimensions   -------------------------------

function pcb_holder_dim(x) = x + 2*GAP + 2*W4;
function pcb_holder_z(z_pcb=Z_PCB_DEF,z_support=Z_SUP_DEF) = z_pcb+z_support+BT;

// --- supports   ------------------------------------------------------------

module supports(x_size,y_size,x_sup,y_sup,z_sup,
                xl_screw,xr_screw,y_screw,sups) {
  x = x_sup + W4 + GAP;
  y = y_sup + W4 + GAP;
  xl_off = -x_size/2 + xl_screw;
  xr_off =  x_size/2 - xr_screw;
  y_off  =  y_size/2 - y_screw;
  if (sups[0]) {
    move([xl_off,+y_off,0]) cuboid([x,y,z_sup],anchor=BOTTOM+CENTER);
  }
  if (sups[1]) {
    move([xr_off,+y_off,0]) cuboid([x,y,z_sup],anchor=BOTTOM+CENTER);
  }
  if (sups[2]) {
    move([xr_off,-y_off,0]) cuboid([x,y,z_sup],anchor=BOTTOM+CENTER);
  }
  if (sups[3]) {
    move([xl_off,-y_off,0]) cuboid([x,y,z_sup],anchor=BOTTOM+CENTER);
  }
}

// --- screws   ----------------------------------------------------------------

module screws(d,x_size,y_size,h_size,xl_screw,xr_screw,y_screw,screws) {
  xl_off = -x_size/2 + xl_screw;
  xr_off =  x_size/2 - xr_screw;
  y_off  =  y_size/2 - y_screw;
  r      = d/2 - GAP/2;
  if (screws[0]) {
    move([xl_off,+y_off,0]) cyl(r=r,h=h_size,anchor=BOTTOM+CENTER);
  }
  if (screws[1]) {
    move([xr_off,+y_off,0]) cyl(r=r,h=h_size,anchor=BOTTOM+CENTER);
  }
  if (screws[2]) {
    move([xr_off,-y_off,0]) cyl(r=r,h=h_size,anchor=BOTTOM+CENTER);
  }
  if (screws[3]) {
    move([xl_off,-y_off,0]) cyl(r=r,h=h_size,anchor=BOTTOM+CENTER);
  }
}

// --- pcb-holder (generic)   --------------------------------------------------

module pcb_holder(
         x_pcb, y_pcb, z_pcb=Z_PCB_DEF,
         x_support = 6.0, y_support = 6.0, z_support = Z_SUP_DEF, supports = [1,1,1,1],
         xl_screw = 3, xr_screw = 3,
         y_screw = 3, d_screw = 2.5, screws = [1,1,1,1]) {

  // box dimensions
  x_case = pcb_holder_dim(x_pcb);
  y_case = pcb_holder_dim(y_pcb);

  // base plate
  cuboid([x_case,y_case,BT],anchor=BOTTOM+CENTER);
  // suport and screws
  supports(x_pcb,y_pcb,x_support,y_support,BT+z_support,
           xl_screw,xr_screw,y_screw,supports);
  screws(d_screw,x_pcb,y_pcb,BT+z_support+z_pcb,xl_screw,xr_screw,y_screw,screws);
  // walls around pcb
  rect_tube(size=[x_case,y_case],wall=W4,h=BT+z_pcb+z_support,anchor=BOTTOM+CENTER);
}
