include<exo-parts.scad>

module bleedingEdge() {
    difference() {
        square([exoL+0.2, exoD+0.2], true);
        square([exoL, exoD], true);
    }
}

module ground() {
    translate([0, 0, -exoWheelR+ttMotorShH()/2-ttMotorThick()])
    square([exoL, exoD], true);
}

color("red") bleedingEdge();
color("gray") ground();

$fn = 100;

exoBoard();
exoMotors();
exoBatMounts();
exoL1BaseTop();
exoL1Stands();
color("blue") exoWheels();
color("blue") exoCaster();
