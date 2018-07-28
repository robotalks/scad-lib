$fn = 160;

ttMotorGearBoxL = 37;
ttMotorGearBoxH = 22.8;
ttMotorGearBoxD = 18.8;
ttMotorGearBoxCornerR = 3;
ttMotorGearBoxThinD = 8.6;
ttMotorGearBoxThickD = ttMotorGearBoxD - ttMotorGearBoxThinD;
ttMotorAxesOff = 11.5;      // Distance between center of Axes and round-cornered end of GearBox
ttMotorAxesHoleR = 2.8;
ttMotorAxesHoleOutR = 3.6;
ttMotorRndHullR = 2;
ttMotorRndHullH = 1.8;
ttMotorRndHullOff = 22;     // Distance between center of round hull and round-cornered end of GearBox
ttMotorTailT = 1.6;         // thinkness includes only single tail, both tails should *2
ttMotorTailH = 5.2;
ttMotorTailL = 4.8;
ttMotorTailHoleR = 1.2;
ttMotorTailHoleOff = ttMotorTailL/2;    // from end of the tail, not GearBox side
ttMotorNeckL = 11.3;
ttMotorNeckOutH = ttMotorGearBoxH;
ttMotorNeckD = ttMotorGearBoxThinD*2;
ttMotorNeckInH = 15;
ttMotorBuckleOff = 4.8;     // Distance between buckle start and edge of Neck and GearBox
ttMotorBuckleH = 5.2;
ttMotorBuckleL = 2.5;
ttMotorBuckleD = 3;

ttMotorShellConnFrontL = 8;
ttMotorShellConnTailL = 4;
ttMotorShellConnH = 5;
ttMotorShellConnAnchorH = ttMotorShellConnH/2-0.1;
ttMotorShellConnFrontOff = ttMotorGearBoxL-ttMotorAxesOff-ttMotorShellConnFrontL;
ttMotorShellConnTailOff = ttMotorAxesOff-2;

ttMotorT = 2;
ttMotorSp = 0.2;

module _ttMotorGearBoxRndEdgeSub() {
    translate([-ttMotorAxesOff, -ttMotorGearBoxThinD-0.1, ttMotorGearBoxH/2-ttMotorGearBoxCornerR])
    difference() {
        translate([-0.1, 0, 0])
        cube([ttMotorGearBoxCornerR+0.1, ttMotorGearBoxD+0.2, ttMotorGearBoxCornerR+0.1]);
        translate([ttMotorGearBoxCornerR, -0.1, 0])
        rotate([-90, 0, 0])
        cylinder(h = ttMotorGearBoxD+0.4, r = ttMotorGearBoxCornerR);
    }
}

module ttMotorGearBox() {
    difference() {
        union() {
            // body
            translate([-ttMotorAxesOff, -ttMotorGearBoxThinD, -ttMotorGearBoxH/2])
            cube([ttMotorGearBoxL, ttMotorGearBoxD, ttMotorGearBoxH]);
            // axes outer hole
            translate([0, -ttMotorGearBoxThinD-0.4, 0])
            rotate([-90, 0, 0])
            cylinder(h = ttMotorGearBoxD+0.8, r = ttMotorAxesHoleOutR);
            // round hull
            translate([ttMotorRndHullOff-ttMotorAxesOff, ttMotorGearBoxThickD-0.1, 0])
            rotate([-90, 0, 0])
            cylinder(h = ttMotorRndHullH+0.1, r = ttMotorRndHullR);
            // tail
            translate([-ttMotorTailL-ttMotorAxesOff, -ttMotorTailT, -ttMotorTailH/2])
            difference() {
                cube([ttMotorTailL+0.1, ttMotorTailT*2, ttMotorTailH]);
                translate([ttMotorTailHoleOff, -0.1, ttMotorTailH/2])
                rotate([-90, 0, 0])
                cylinder(h = ttMotorTailT*2+0.2, r = ttMotorTailHoleR);
            }
        }
        // round edges
        _ttMotorGearBoxRndEdgeSub();
        mirror([0, 0, -1]) _ttMotorGearBoxRndEdgeSub();
        // axes inner hole
        translate([0, -ttMotorGearBoxThinD-0.5, 0])
        rotate([-90, 0, 0])
        cylinder(h = ttMotorGearBoxD+1, r = ttMotorAxesHoleR);
    }
}

module _ttMotorBuckle() {
    translate([ttMotorBuckleOff, ttMotorNeckD/2, -ttMotorBuckleH/2])
    cube([ttMotorBuckleL, ttMotorBuckleD, ttMotorBuckleH]);
}

module _ttMotorNeck(sp = 0) {
    intersection() {
        translate([0, -ttMotorNeckD/2-sp, -ttMotorNeckOutH/2-sp])
        cube([ttMotorNeckL, ttMotorNeckD+sp*2, ttMotorNeckOutH+sp*2]);
        rotate([0, 90, 0])
        cylinder(h = ttMotorNeckL, d = ttMotorNeckOutH+sp*2);
    }
}

module ttMotorNeck() {
    translate([ttMotorGearBoxL-ttMotorAxesOff, 0, 0])
    union() {
        _ttMotorNeck();
        _ttMotorBuckle();
        mirror([0, 1, 0]) _ttMotorBuckle();
    }
}

module ttMotor() {
    union() {
        ttMotorGearBox();
        ttMotorNeck();
    }
}

module _ttMotorShellHollowSub(thick, sp) {
    translate([-ttMotorAxesHoleOutR-sp, 0, -ttMotorGearBoxH])
    cube([ttMotorShellConnFrontOff-thick+ttMotorAxesHoleOutR, ttMotorGearBoxD/4+thick+sp+0.1, ttMotorGearBoxH*2]);
}

module ttMotorShell(thick = ttMotorT, sp = ttMotorSp) {
    lsp = sp*2;
    difference() {
        translate([-ttMotorAxesOff-thick-sp, -ttMotorGearBoxThinD-thick-sp, -ttMotorGearBoxH/2-thick-sp])
        difference() {
            union() {
                cube([ttMotorGearBoxL+thick+lsp, ttMotorGearBoxD+thick*2+lsp, ttMotorGearBoxH+thick*2+lsp]);
                // tail
                translate([-ttMotorTailL+thick+sp, ttMotorGearBoxThinD-ttMotorTailT, (ttMotorGearBoxH-ttMotorTailH)/2])
                cube([ttMotorTailL, (ttMotorTailT+thick+sp)*2, ttMotorTailH+thick*2+lsp]);
                // neck cover
                translate([ttMotorGearBoxL+thick+lsp, 0, 0])
                cube([thick, ttMotorGearBoxD+thick*2+lsp, ttMotorGearBoxH+thick*2+lsp]);
            }
            translate([thick, thick, thick])
            cube([ttMotorGearBoxL+lsp, ttMotorGearBoxD+lsp, ttMotorGearBoxH+lsp]);
        }
        // neck
        translate([ttMotorGearBoxL-ttMotorAxesOff, 0, 0])
        _ttMotorNeck(sp = sp);
        // round hull
        translate([ttMotorRndHullOff-ttMotorAxesOff, 0, 0])
        rotate([-90, 0, 0])
        cylinder(h = ttMotorGearBoxThickD+thick+lsp, r = ttMotorRndHullR+sp);
        // substract tail and space
        translate([-ttMotorAxesOff-ttMotorTailL, -ttMotorTailT-sp, -ttMotorTailH/2-sp])
        union() {
            translate([-0.1, 0, 0])
            cube([ttMotorTailL+0.2, (ttMotorTailT+sp)*2, ttMotorTailH+lsp]);
            translate([ttMotorTailHoleOff, ttMotorTailT-ttMotorGearBoxThinD-thick-0.1, ttMotorTailH/2+sp])
            rotate([-90, 0, 0])
            cylinder(h = ttMotorGearBoxD+thick*2+lsp+0.2, r = ttMotorTailHoleR+sp);
            translate([0, -ttMotorGearBoxThinD-thick+ttMotorTailT-0.1-lsp, 0])
            cube([ttMotorTailL, ttMotorGearBoxThinD+thick-ttMotorTailT*2+0.1, ttMotorTailH+lsp]);
            translate([0, ttMotorTailT*3+lsp*2, 0])
            cube([ttMotorTailL, ttMotorGearBoxThickD+thick-ttMotorTailT*2+0.1, ttMotorTailH+lsp]);
        }
        // axes outer hole
        translate([0, -ttMotorGearBoxThinD-thick-sp-0.1, 0])
        rotate([-90, 0, 0])
        cylinder(h = ttMotorGearBoxD+thick*2+lsp+0.2, r = ttMotorAxesHoleOutR+sp);
        
        // remove unnecessary material
        translate([0, -ttMotorGearBoxThinD-thick-sp-0.1, 0])
        _ttMotorShellHollowSub(thick, sp);
        translate([0, ttMotorGearBoxThickD+thick+sp+0.1, 0])
        mirror([0, 1, 0]) _ttMotorShellHollowSub(thick, sp);
        
        subL = ttMotorAxesOff+ttMotorTailL+thick+sp;
        subD = ttMotorGearBoxThickD;
        translate([-subL-0.1-ttMotorAxesHoleOutR*2, -subD/2, 0])
        difference() {
            translate([0, 0, -ttMotorGearBoxH])
            cube([subL+0.1, subD, ttMotorGearBoxH*2]);
            translate([-ttMotorAxesOff+ttMotorAxesHoleOutR*2, -0.1, -ttMotorTailH*1.5])
            cube([subL+0.1, subD+0.2, ttMotorTailH*3]);
        }
    }
}

module _ttMotorShellConnectorOne(l, extraH, thick, sp) {
    difference() {
        cube([l, thick, ttMotorShellConnH+extraH]);
        translate([-0.1, thick/2-sp/2, ttMotorShellConnAnchorH])
        cube([l+0.2, thick/2+sp, ttMotorShellConnH-ttMotorShellConnAnchorH+extraH+sp/2]);
        translate([-0.1, thick, ttMotorShellConnAnchorH])
        rotate([-90, 0, 0]) rotate([0, 90, 0])
        linear_extrude(height = l+0.2)
            polygon(points = [
                [0, 0], 
                [thick, ttMotorShellConnAnchorH], 
                [thick, ttMotorShellConnAnchorH+0.1],
                [-0.1, ttMotorShellConnAnchorH+0.1]]);
    }
}

module _ttMotorShellUpperConnectorSub(l, thick, sp) {
    difference() {
        cube([l+sp, thick+0.2, ttMotorShellConnH+ttMotorShellConnAnchorH+sp]);
        translate([-0.1, (thick+sp)/2, 0])
        cube([l+sp+0.2, thick, ttMotorShellConnH-ttMotorShellConnAnchorH-sp/2]);
    }    
}

module _ttMotorShellUpperConnectorsSub(off, l, thick, sp) {
    translate([off-sp/2, -ttMotorGearBoxThinD-thick-sp-0.1, 0])
    _ttMotorShellUpperConnectorSub(l, thick, sp);
    translate([off-sp/2, ttMotorGearBoxThickD+thick+sp+0.1, 0])
    mirror([0, 1, 0])
    _ttMotorShellUpperConnectorSub(l, thick, sp);    
}

module ttMotorShellUpper(thick = ttMotorT, sp = ttMotorSp) {
    difference() {
        ttMotorShell(thick = thick, sp = sp);
        d = ttMotorGearBoxD+(thick+sp)*2+0.2;
        ty = -ttMotorGearBoxThinD-thick-sp-0.1;
        h = ttMotorGearBoxH/2+thick+sp;
        translate([-ttMotorAxesOff-sp, ty, -h-0.1])
        cube([ttMotorGearBoxL+thick+sp*2+0.1, d, h+sp/2+0.1]);
        translate([-ttMotorAxesOff-sp-ttMotorTailL-0.01, ty, -h-0.1])
        cube([ttMotorTailL+sp+0.01, d, h-ttMotorTailH/2+0.2]);
        translate([-ttMotorAxesOff-ttMotorTailL-sp, -ttMotorTailT-sp-thick-0.1, -ttMotorTailH/2-sp-thick-0.1])
        cube([ttMotorTailL+sp*2, thick+0.2, ttMotorTailH+thick+sp*2+0.1]);
        _ttMotorShellUpperConnectorsSub(ttMotorShellConnFrontOff, ttMotorShellConnFrontL, thick, sp);
        _ttMotorShellUpperConnectorsSub(-ttMotorShellConnTailOff, ttMotorShellConnTailL, thick, sp);
    }
}

module _ttMotorShellBottomConnectors(l, thick, sp) {
    translate([sp/2, 0, 0]) {
        translate([0, ttMotorGearBoxThickD+sp+thick, ttMotorShellConnH])
        mirror([0, 1, 0]) mirror([0, 0, 1]) _ttMotorShellConnectorOne(l, sp/2, thick, sp);
        translate([0, -ttMotorGearBoxThinD-sp-thick, ttMotorShellConnH])
        mirror([0, 0, 1])
        _ttMotorShellConnectorOne(l, sp/2, thick, sp);
    }
}

module ttMotorShellBottom(thick = ttMotorT, sp = ttMotorSp) {
    difference() {
        ttMotorShell(thick = thick, sp = sp);
        d = ttMotorGearBoxD+(thick+sp)*2+0.2;
        ty = -ttMotorGearBoxThinD-thick-sp-0.1;
        h = ttMotorGearBoxH/2+thick+sp;
        translate([-ttMotorAxesOff-sp, ty, -sp/2])
        cube([ttMotorGearBoxL+thick+sp*2+0.1, d, h+sp/2+0.1]);
        translate([-ttMotorAxesOff-sp-ttMotorTailL-0.01, ty, ttMotorTailH/2])
        cube([ttMotorTailL+sp+0.01, d, h-ttMotorTailH/2+0.2]);
        translate([-ttMotorAxesOff-ttMotorTailL-0.1, ttMotorTailT, -ttMotorTailH/2-sp])
        cube([ttMotorTailL+0.2, thick+sp*2, ttMotorTailH+sp+0.1]);
    }
    translate([ttMotorShellConnFrontOff, 0, 0])
    _ttMotorShellBottomConnectors(ttMotorShellConnFrontL, thick, sp);
    translate([-ttMotorShellConnTailOff, 0, 0])
    _ttMotorShellBottomConnectors(ttMotorShellConnTailL, thick, sp);    
}

// exported functions for measurements

function ttMotorShL() = ttMotorGearBoxL+(ttMotorT+ttMotorSp)*2;
function ttMotorShTailL() = ttMotorTailL-ttMotorT-ttMotorSp;
function ttMotorShNeckL() = ttMotorNeckL-ttMotorT-ttMotorSp;
function ttMotorShH() = ttMotorGearBoxH+(ttMotorT+ttMotorSp)*2;
function ttMotorShXOffL() = ttMotorGearBoxL-ttMotorAxesOff+ttMotorT+ttMotorSp;
function ttMotorShXOffS() = ttMotorAxesOff+ttMotorT+ttMotorSp;
function ttMotorShThinD() = ttMotorGearBoxThinD+ttMotorT+ttMotorSp;
function ttMotorShThickD() = ttMotorGearBoxThickD+ttMotorT+ttMotorSp;
function ttMotorThick() = ttMotorT;
function ttMotorSpacing() = ttMotorSp;
