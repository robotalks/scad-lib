use<exo-imports.scad>
include<protoboard.scad>

THICK = 2;
SP = 0.2;

exoL = 180;
exoD = 180;

exoBaseH = 4;
exoBaseHoleCapH = 2.8;
exoBaseHoleSp = 10;
exoBaseL = 140;
exoBaseD = 120;

exoHoleMntD = 10;

function OutSz(innerSz, thick = THICK, sp = SP) = innerSz+(thick+sp)*2;
function InnerSz(outSz, thick = THICK, sp = SP) = outSz-(thick+sp)*2;

DRAW_HOLES = true;

module exoBaseBoltArray(xs = [-6:6], ys = [-5:5]) {
    if (DRAW_HOLES) {
        translate([0, 0, -exoBaseH+exoBaseHoleCapH]) {
            for (x = xs)
                for (y = ys) {
                    if (! ( ( ((y == 2 || y == -2) && x == 5) ) || (x >= 4 && y >= -1 && y <= 1) ) )
                        translate([x*exoBaseHoleSp, y*exoBaseHoleSp, 0])
                        mirror([0, 0, 1]) M3NutHole(exoBaseHoleCapH+0.1, exoBaseH-exoBaseHoleCapH+0.1);
                }
        }
    }
}

module exoBoltArray(xs = [-6:6], ys = [-5:5], boltL = THICK, headH = THICK) {
    if (DRAW_HOLES) {
        for (x = xs)
            for (y = ys) {
                translate([x*exoBaseHoleSp, y*exoBaseHoleSp, 0])
                M3BoltHole(headH+1, boltL+1);
            }
    }
}

module exoNutArray(xs = [-6:6], ys = [-5:5], boltL = THICK, headH = THICK) {
    if (DRAW_HOLES) {
        for (x = xs)
            for (y = ys) {
                translate([x*exoBaseHoleSp, y*exoBaseHoleSp, 0])
                M3NutHole(headH+1, boltL+1);
            }
    }
}
