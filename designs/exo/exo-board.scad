include<exo-common.scad>
include<exo-caster.scad>
include<exo-motors.scad>

module _exoBoardWheelLSub() {
    l = (exoWheelR+exoWheelSp)*2;
    d = exoD/2;
    translate([-l/2-exoMotorXOff, -d-exoMotorYOff-ttMotorShThinD(), -exoBaseH-0.1])
    cube([l, d, exoBaseH+0.2]);
}

module _exoBoardSideLSub() {
    translate([-exoL/2, -exoD-exoMotorYOff-ttMotorShThinD()-exoWheelD/2, -exoBaseH-0.1])
    cube([exoL, exoD, exoBaseH+0.2]);
}

module exoBoard() {
    difference() {
        translate([0, 0, -exoBaseH]) {
            r = exoBaseD/6;
            translate([-exoBaseL/2+r, -exoBaseD/2+r, 0])
            cylinder(h = exoBaseH, r = r);
            translate([-exoBaseL/2+r, exoBaseD/2-r, 0])
            cylinder(h = exoBaseH, r = r);
            translate([exoBaseL/2-r, -exoBaseD/2+r, 0])
            cylinder(h = exoBaseH, r = r);
            translate([exoBaseL/2-r, exoBaseD/2-r, 0])
            cylinder(h = exoBaseH, r = r);
            translate([0, 0, exoBaseH/2])
            cube([exoBaseL, exoBaseD-r*2, exoBaseH], true);
            translate([0, 0, exoBaseH/2])
            cube([exoBaseL-r*2, exoBaseD, exoBaseH], true);
        }
        cylinder(h = exoBaseH, d = exoL);
        _exoBoardWheelLSub();
        mirror([0, 1, 0]) _exoBoardWheelLSub();
        _exoBoardSideLSub();
        mirror([0, 1, 0]) _exoBoardSideLSub();
        exoBaseBoltArray();
        translate([exoCasterXOff, 0, -exoCasterZOff]) exoCasterHolder();
    }
}
