include<exo-common.scad>

exoWheelR = 33.25;
exoWheelD = 28;
exoWheelSp = 5;

exoFrameEdgeSp = 5;

exoMotorXOff = 20;
exoMotorYOff = exoD/2-exoWheelD-ttMotorShThinD();
exoMotorZOff = ttMotorShH()/2-ttMotorThick();

module exoMotorL() {
    translate([-exoMotorXOff, -exoMotorYOff, exoMotorZOff])
    ttMotorShellBottom();
}

module exoMotorR() {
    mirror([0, 1, 0]) exoMotorL();
}

module exoMotors() {
    exoMotorL();
    exoMotorR();
}

module exoMotorsFrame() {
    difference() {
        union() {
            translate([0, 0, -ttMotorThick()]) hull() {
                xoff = (exoL-exoCasterL)/2-exoFrameEdgeSp;
                t = ttMotorThick();
                translate([-exoMotorXOff-ttMotorShXOffS(), -exoMotorYOff, 0])
                cube([ttMotorShL(), exoMotorYOff*2, t]);
                translate([xoff, 0, 0])
                cylinder(h = t, d = exoCasterL);
            }
            translate([exoCasterXOff, 0, 0]) _casterSupp();
        }
        translate([exoCasterXOff, 0, 0]) _casterHoles();
    }
}

module exoWheelL() {
    translate([-exoMotorXOff, -exoMotorYOff-ttMotorShThinD()-exoWheelD, ttMotorShH()/2-ttMotorThick()])
    rotate([-90, 0, 0])
    cylinder(h = exoWheelD-3, r = exoWheelR);
}

module exoWheelR() {
    mirror([0, 1, 0]) exoWheelL();
}

module exoWheels() {
    exoWheelL();
    exoWheelR();
}
