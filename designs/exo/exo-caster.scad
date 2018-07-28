include<exo-common.scad>

exoCasterHoleDist = 40;
exoCasterHoleR = 2;
exoCasterBallHolderR = 15.4;
exoCasterL = 50;
exoCasterD = 32;
exoCasterLCornerR = 4;
exoCasterZOff = 1.5;
exoCasterSuppL = 60;
exoCasterSuppD = 40;
exoCasterSuppT = 2;
exoCasterXOff = 50;

module exoCasterHolder() {
    rotate([0, 0, 90]) {
        hull() {
            cylinder(h = exoCasterSuppT, d = exoCasterD);
            translate([-exoCasterL/2+exoCasterLCornerR, 0, 0])
            cylinder(h = exoCasterSuppT, r = exoCasterLCornerR);
            translate([exoCasterL/2-exoCasterLCornerR, 0, 0])
            cylinder(h = exoCasterSuppT, r = exoCasterLCornerR);
        }
        translate([0, 0, -exoBaseH*2]) {
            cylinder(h = exoBaseH*4, r = exoCasterBallHolderR);
            translate([exoCasterHoleDist/2, 0, 0])
            cylinder(h = exoBaseH*4, r = exoCasterHoleR);
            translate([-exoCasterHoleDist/2, 0, 0])
            cylinder(h = exoBaseH*4, r = exoCasterHoleR);    
        }
    }
}

/*
module exoCasterSupp() {
    translate([0, 0, -exoCasterSuppT-ttMotorThick()])
    hull() {
        r = (exoCasterL-exoCasterHoleDist)/2;
        translate([-exoCasterSuppL/2, 0, 0])
        cylinder(h = exoCasterSuppT, r = r);
        translate([exoCasterSuppL/2, 0, 0])
        cylinder(h = exoCasterSuppT, r = r);
        translate([0, exoCasterSuppD/2, 0])
        cylinder(h = exoCasterSuppT, r = r);
        translate([0, -exoCasterSuppD/2, 0])
        cylinder(h = exoCasterSuppT, r = r);    
    }
}
*/

module exoCasterHole() {
    translate([0, 0, -exoCasterSuppT])
    M3NutHole(exoCasterSuppT+0.1, exoCasterSuppT+0.1);
}

module exoCasterHoles() {
    translate([-exoCasterHoleDist/2, 0, 0])
    _casterHole();
    translate([exoCasterHoleDist/2, 0, 0])
    _casterHole();
}

module exoCaster(h = 22, d = 33) {
    translate([exoCasterXOff, 0, -h])
    cylinder(h = h, d = d);
}
