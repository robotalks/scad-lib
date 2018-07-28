protoBoardSp = 1.4; // board thick is 1.2
protoBoardCornerR = 5;
protoBoardCornerL = 10;
protoBoardDefLowerH = 4;
protoBoardDefUpperH = 4;

function protoBoardOutSz(sz) = sz + (protoBoardCornerL-protoBoardCornerR) * 2;
function protoBoardInnerSz(sz) = sz - protoBoardCornerR*2;

module protoBoardCorner(
    upperH = protoBoardDefUpperH, 
    lowerH = protoBoardDefLowerH) {
    translate([-protoBoardCornerR, -protoBoardCornerR, 0])
    difference() {
        cube([protoBoardCornerL, protoBoardCornerL, upperH+lowerH+protoBoardSp]);
        translate([-0.1, -0.1, lowerH])
        cube([protoBoardCornerR+0.1, protoBoardCornerR+0.1, protoBoardSp]);
    }
}

module protoBoardStand(cx, cy, 
    upperH = protoBoardDefUpperH,
    lowerH = protoBoardDefLowerH) {
    translate([cx/2, cy/2, 0]) protoBoardCorner(upperH, lowerH);
    translate([cx/2, -cy/2, 0]) mirror([0, 1, 0]) protoBoardCorner(upperH, lowerH);
    translate([-cx/2, cy/2, 0]) mirror([1, 0, 0]) protoBoardCorner(upperH, lowerH);
    translate([-cx/2, -cy/2, 0]) mirror([0, 1, 0]) mirror([1, 0, 0]) protoBoardCorner(upperH, lowerH);
}

module protoBoardStand9x7(    
    upperH = protoBoardDefUpperH,
    lowerH = protoBoardDefLowerH) {
    protoBoardStand(90, 70, upperH, lowerH);
}

module protoBoardStand6x4(    
    upperH = protoBoardDefUpperH,
    lowerH = protoBoardDefLowerH) {
    protoBoardStand(60, 40, upperH, lowerH);
}

module protoBoardStand7x5(    
    upperH = protoBoardDefUpperH,
    lowerH = protoBoardDefLowerH) {
    protoBoardStand(70, 50, upperH, lowerH);
}

module protoBoardStand8x2(    
    upperH = protoBoardDefUpperH,
    lowerH = protoBoardDefLowerH) {
    protoBoardStand(80, 20, upperH, lowerH);
}
