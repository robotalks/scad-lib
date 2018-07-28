include<exo-common.scad>

exoL1PbCX = 70;
exoL1PbCY = 90;

exoL1BaseT = 2;
exoL1BaseSubCY = 25;
exoL1BaseSubCX = 20;

exoL1ZOff = exoBatFrameCZ;
exoL1TopZOff = exoL1ZOff+exoL1BaseT;

module exoL1BaseAll(cx = exoL1PbCX, cy = exoL1PbCY) {
    cx1 = protoBoardOutSz(cx);
    cx2 = cx1*2;
    cy1 = protoBoardOutSz(cy);
    translate([0, 0, exoL1ZOff+exoL1BaseT/2])
    difference() {
        union() {
            difference() {
                cube([cx2, cy1, exoL1BaseT], true);
                // make it smaller
                difference() {
                    d_cx = cx2-exoL1BaseSubCX*2;
                    d_cy = exoL1BaseSubCY+0.2;
                    d_cz = exoL1BaseT+0.2;                
                    union() {
                        d_offy = cy1/2-exoL1BaseSubCY/2+0.1;
                        translate([0, d_offy, 0])
                        cube([d_cx, d_cy, d_cz], true);
                        translate([0, -d_offy, 0])
                        cube([d_cx, d_cy, d_cz], true);
                    }
                    cube([protoBoardCornerL*2, cy1+0.2, d_cz+0.2], true);
                }
            }
            // support
            offz = -THICK-exoL1BaseT/2;
            // middle
            translate([0, 0, offz])
            cube([protoBoardCornerL*2, cy1, THICK*2], true);
            // front and tail
            offx = cx1-exoL1BaseSubCX/2;
            translate([-offx, 0, offz])
            cube([exoL1BaseSubCX, cy1, THICK*2], true);
            translate([offx, 0, offz])
            cube([exoL1BaseSubCX, cy1, THICK*2], true);
        }
        // holes
        translate([0, 0, -exoL1BaseT/2-THICK]) mirror([0, 0, 1]) {
            exoNutArray([0:0], [-3:3], boltL = THICK*2);
            exoNutArray([-7:-7], [-3:3], boltL = THICK*2);
            exoNutArray([7:7], [-3:3], boltL = THICK*2);
            exoNutArray([-5:-2], [-3:3], boltL = THICK*2);
            exoNutArray([2:5], [-3:3], boltL = THICK*2);
        }
    }
}

module exoL1BaseTop(cy = exoL1PbCY, sp = 0.2) {
    intersection() {
        difference() {
            exoL1BaseAll();
            translate([0, 0, -THICK*2+exoL1ZOff+sp/2])
            cube([exoL, exoD, THICK*4], true);
        }
        // make space for stands
        i_cy = protoBoardInnerSz(cy) - sp * 2;
        translate([0, 0, exoL1ZOff])
        cube([exoL, i_cy, THICK*4], true);
    }
}

module exoL1BaseBottom(sp = 0.2) {
    difference() {
        exoL1BaseAll();
        translate([0, 0, THICK*2+exoL1ZOff-sp/2])
        cube([exoL, exoD, THICK*4], true);
    }
}

module exoL1Stands(cx = exoL1PbCX, cy = exoL1PbCY, sp = 0.2) {
    translate([0, 0, exoL1TopZOff]) {
        offx = protoBoardOutSz(cx)/2;
        offz = exoL1BaseT+sp;
        translate([-offx, 0, -offz]) protoBoardStand(cx, cy, lowerH = protoBoardDefLowerH+offz);
        translate([offx, 0, -offz]) protoBoardStand(cx, cy, lowerH = protoBoardDefLowerH+offz);
    }
    exoL1BaseBottom();
}

module exoL1StandsF(cx = exoL1PbCX, cy = exoL1PbCY, sp = 0.2) {
    difference() {
        exoL1Stands(cx, cy, sp);
        h = (protoBoardDefLowerH+protoBoardDefUpperH+THICK)*4;
        translate([exoL/2-cx+exoL1BaseSubCX, 0, exoL1TopZOff]) cube([exoL, exoD, h], true);
    }
}

module exoL1StandsT(cx = exoL1PbCX, cy = exoL1PbCY, sp = 0.2) {
    difference() {
        exoL1Stands(cx, cy, sp);
        h = (protoBoardDefLowerH+protoBoardDefUpperH+THICK)*4;
        translate([-exoL/2+cx-exoL1BaseSubCX, 0, exoL1TopZOff]) cube([exoL, exoD, h], true);
    }
}

module exoL1StandsM(cx = exoL1PbCX, cy = exoL1PbCY, sp = 0.2) {
    difference() {
        exoL1Stands(cx, cy, sp);
        h = (protoBoardDefLowerH+protoBoardDefUpperH+THICK)*4;
        translate([exoL/2+protoBoardCornerL, 0, exoL1TopZOff]) cube([exoL, exoD, h], true);
        translate([-exoL/2-protoBoardCornerL, 0, exoL1TopZOff]) cube([exoL, exoD, h], true);
    }
}

module _l1StandsHalfSub() {
    h = (protoBoardDefLowerH+protoBoardDefUpperH+THICK)*4;
    translate([0, exoD/2-exoBaseHoleSp/2, exoL1TopZOff]) cube([exoL, exoD, h], true);
}

module exoL1StandsHalfF(cx = exoL1PbCX, cy = exoL1PbCY, sp = 0.2) {
    difference() {
        exoL1StandsF(cx, cy, sp);
        _l1StandsHalfSub();
    }
}

module exoL1StandsHalfT(cx = exoL1PbCX, cy = exoL1PbCY, sp = 0.2) {
    difference() {
        exoL1StandsT(cx, cy, sp);
        _l1StandsHalfSub();
    }
}

module exoL1StandsHalfM(cx = exoL1PbCX, cy = exoL1PbCY, sp = 0.2) {
    difference() {
        exoL1StandsM(cx, cy, sp);
        _l1StandsHalfSub();
    }
}
