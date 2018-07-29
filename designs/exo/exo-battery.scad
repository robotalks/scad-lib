include<exo-common.scad>

exoBatteryCX = 139.5;
exoBatteryCY = 47.2;
exoBatteryCZ = 25.2;

exoBatFrameCX = OutSz(exoBatteryCX)+THICK*2;
exoBatFrameCY = OutSz(exoBatteryCY)+THICK*2;
exoBatFrameCZ = OutSz(exoBatteryCZ)+THICK*2;

exoBatMountCX = 25;
exoBatMountMarginX = THICK+15;
exoBatMountMarginTop = 8;
//exoBatMountMarginBottom = 5;

module exoBatteryFrame() {
    difference() {
        cube([exoBatFrameCX, exoBatFrameCY, exoBatFrameCZ], true);
        cube([exoBatteryCX, exoBatteryCY, exoBatteryCZ], true);
    }
}

module exoBatMount() {
    translate([0, 0, exoBatFrameCZ/2])
    difference() {
        exoBatteryFrame();
        translate([exoBatMountCX+exoBatMountMarginX, 0, 0])
        cube([exoBatFrameCX, exoBatFrameCY+0.2, exoBatFrameCZ+0.2], true);
        translate([-exoBatFrameCX/2+exoBatMountMarginX/2-0.1,
            0, exoBatFrameCZ/2-exoBatMountMarginTop/2+0.1])
        cube([exoBatMountMarginX+0.1, exoBatFrameCY+0.2, exoBatMountMarginTop+0.1], true);
        //translate([-exoBatFrameCX/2+exoBatMountMarginX/2-0.1,
        //    0, -exoBatFrameCZ/2+exoBatMountMarginBottom/2-0.1])
        //cube([exoBatMountMarginX+0.1, exoBatFrameCY+0.2, exoBatMountMarginBottom+0.1], true);
    }
}

module exoBatMountF() {
    difference() {
        exoBatMount();
        translate([0, 0, exoBatFrameCZ-THICK])
        mirror([0, 0, 1]) exoNutArray([-5:-4], [-2:2]);
        translate([0, 0, THICK])
        exoNutArray([-6:-4], [-2:2]);
        translate([-exoBatFrameCX/2+THICK, 0, 0]) rotate([0, 90, 0]) exoNutArray([-2:-1], [-2:2]);
        translate([0, -exoBatFrameCY/2+THICK, 0]) rotate([-90, 0, 0]) exoNutArray([-6:-4], [-2:-1]);
        translate([0, exoBatFrameCY/2-THICK, 0]) rotate([90, 0, 0]) exoNutArray([-6:-4], [1:2]);
    }
}

module exoBatMountT() {
    difference() {
        mirror([1, 0, 0]) exoBatMount();
        translate([0, 0, exoBatFrameCZ-THICK])
        mirror([0, 0, 1]) exoNutArray([4:5], [-2:2]);
        translate([0, 0, THICK])      
        exoNutArray([4:6], [-2:2]);
        translate([exoBatFrameCX/2-THICK, 0, 0]) rotate([0, -90, 0]) exoNutArray([1:2], [-2:2]);
        translate([0, -exoBatFrameCY/2+THICK, 0]) rotate([-90, 0, 0]) exoNutArray([4:6], [-2:-1]);
        translate([0, exoBatFrameCY/2-THICK, 0]) rotate([90, 0, 0]) exoNutArray([4:6], [1:2]);

        // caster holder
        translate([exoCasterXOff, 0, -0.01]) 
        difference() {
            exoCasterHolder();
            translate([0, 0, exoCasterSuppT+exoBaseH*2])
            cube([exoL, exoD, exoBaseH*4], true);
        }
        // make sure nut hole through caster holder
        exoNutArray([5:5], [-2:-2]);
        exoNutArray([5:5], [2:2]);
    }
}

module exoBatMounts() {
    exoBatMountF();
    exoBatMountT();
}
