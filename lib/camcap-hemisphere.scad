// Camera Cap Hemisphere

include<camcap-vars.scad>
include<camcap-utils.scad>

// spacing of lens track
camCapHspLensTrackSp = 0.8;

// lens cover thickness
camCapHspLensCoverT = 1.6;

// lens cover width
camCapHspLensCoverW = 38;

function camCapHspInnerR() = camCapRadius-(camCapThickness+camCapHspLensTrackSp)*2-camCapHspLensCoverT;

function camCapHspLensTrackW() = (camCapLensRadius+camCapHspLensTrackSp) * 2;

function camCapHspRailsApart() = camCapHspLensCoverW+camCapHspLensTrackSp*2;

function camCapHspRailsApartIn() = camCapHspRailsApart()-camCapSupportSize*2;

function camCapHspRailsApartOut() = camCapHspRailsApart()+camCapSupportSize*2;

function camCapHspCoverR() = camCapRadius-camCapThickness-camCapHspLensTrackSp;

function camCapHspCoverSuppW() = camCapSupportSize;

function camCapHspCoverSuppApartIn() = camCapSupportApart;

function camCapHspCoverSuppApartOut() = camCapHspCoverSuppApartIn()+camCapHspCoverSuppW()*2;

function camCapHspCapSuppW() = camCapSupportSize*2;

function camCapHspCapSuppApartIn() = camCapHspCoverSuppApartOut()+camCapSpacing*2;

function camCapHspCapSuppApartOut() = camCapHspCapSuppApartIn()+camCapHspCapSuppW()*2;

function camCapHspCoverHolderR() = camCapAxleRadius+camCapSupportSize+camCapSpacing;

function camCapHspHoleR(n) = camCapHspCoverHolderR()*2+camCapBoltCapRadius*4*n;

function camCapHspHoleR2() = camCapHspInnerR()-camCapBoltCapRadius*3;

function camCapVertAxleSqD() = (camCapAxleRadius-camCapSpacing)*1.4;

_camCapSuppOnCoverAngles = [4, 45, 120];
_camCapSuppOnCapAngles = [30, 82.5, 135];
_camCapCoverSuppConns = [[4, 56], [120, 15]];

module _sector(h, r, from, angles) {
    difference() {
        cylinder(h = h, r = r);
        r1 = r+1;
        rotate([0, 0, -90+from])
            translate([0, r1, 0]) cube([r1*2, r1*2, (h+2)*2], true);
        rotate([0, 0, -90+from+angles])
            translate([0, -r1, 0]) cube([r1*2, r1*2, (h+2)*2], true);
    }
}

module _camCapBoltHole(h, t, r) {
    translate([r, 0, (h-camCapBoltCapThickness)*t-0.1*(1-t)])
    cylinder(h = camCapBoltCapThickness+0.1, r = camCapBoltCapRadius+camCapSpacing);
    translate([r, 0, -0.1])
    cylinder(h = h+0.2, r = camCapBoltThreadRadius+camCapSpacing);
}

module _camCapNutHole(h, t, r) {
    translate([r, 0, (h-camCapNutThickness)*t-0.1*(1-t)])
    cylinder(h = camCapNutThickness+0.1, r = camCapNutRadius+camCapSpacing, $fn=6);
    translate([r, 0, -0.1])
    cylinder(h = h+0.2, r = camCapBoltThreadRadius+camCapSpacing);
}

module _camCapHole(what, h, t, r) {
    if (what == "bolt") _camCapBoltHole(h, t, r);
    if (what == "nut") _camCapNutHole(h, t, r);
}

module camCapHspCoverArcEraser(from, size) {
    // size < 180
    rotate([0, 90, 0])
    translate([0, 0, -camCapRadius-1])
    _sector(camCapRadius*2+2, camCapRadius, from, size);
}

module camCapHspSuppArm(off, angle, size = 15,
                        holes = "", holesAt = 0,
                        outerR = camCapRadius,
                        spThickness = camCapThickness,
                        thickness = camCapSupportSize) {
    difference() {
        translate([off, 0, 0])
        rotate([0, 90, 0])
        difference() {
            union() {
                difference() {
                    _sector(thickness, camCapRadius, angle, size);
                    translate([0, 0, -0.1])
                        cylinder(h = thickness + 0.2, r = camCapHspCoverHolderR()-0.01);
                }
                // ensure minimum width of arm
                ir = outerR - spThickness;
                sr = sqrt(ir*ir - off*off);
                hr = camCapHspCoverHolderR();
                am = angle+size/2;
                rotate([0, 0, 90])
                linear_extrude(height = thickness) polygon([
                        [hr*cos(am-30), hr*sin(am-30)],
                        [sr*cos(angle), sr*sin(angle)],
                        [sr*cos(angle+size), sr*sin(angle+size)],
                        [hr*cos(am+30), hr*sin(am+30)]
                    ], [[0, 1, 2, 3]]);
                // holder
                cylinder(h = thickness, r = hr);
            }
            if (holes != "") {
                rot = 90+angle;
                rotate([0, 0, rot+size/2]) {
                    _camCapHole(holes, thickness, holesAt, camCapHspHoleR(0));
                    _camCapHole(holes, thickness, holesAt, camCapHspHoleR(1));
                    r2 = camCapHspHoleR2();
                    if (r2 <= outerR-spThickness-camCapBoltCapRadius*3) {
                        _camCapHole(holes, thickness, holesAt, camCapHspHoleR2());
                    }
                }
            }
        }
        camCapOuterEraser(r = outerR);
    }
}

module camCapHspSuppArmOnCap(angle) {
    camCapHspSuppArm(camCapHspCapSuppApartIn()/2, angle, holes = "bolt");
}

module camCapHspSuppArmOnCover(angle) {
    camCapHspSuppArm(camCapHspCoverSuppApartIn()/2, angle,
        outerR = camCapHspInnerR()-camCapHspLensTrackSp,
        spThickness = camCapSupportSize,
        holes = "bolt",
        holesAt = 1);
}

module camCapHspLensCoverSupp() {
    for (a = _camCapSuppOnCoverAngles) camCapHspSuppArmOnCover(a);
}

module camCapHspLensCoverSuppConn(angle, size) {
    r = camCapHspCoverR();
    r1 = camCapHspInnerR()-camCapHspLensTrackSp;
    w = camCapHspLensTrackW();
    w1 = camCapHspCoverSuppApartOut();
    difference() {
        union() {
            difference() {
                sphere(r);
                sphere(r1-0.1);
                translate([camCapRadius+w/2, 0, 0]) cube(camCapRadius*2, true);
                translate([-camCapRadius-w/2, 0, 0]) cube(camCapRadius*2, true);
            }
            difference() {
                sphere(r1);
                sphere(r1-camCapSupportSize);
                translate([camCapRadius+w1/2, 0, 0]) cube(camCapRadius*2, true);
                translate([-camCapRadius-w1/2, 0, 0]) cube(camCapRadius*2, true);
            }
        }

        translate([0, 0, -r*2]) cube(r*4, true);
        s1 = angle+size;
        e1 = 181-s1;
        camCapHspCoverArcEraser(-1, angle+1);
        camCapHspCoverArcEraser(s1, e1);
    }
}

module camCapHspLensCover() {
    r = camCapHspCoverR();
    difference() {
        union() {
            difference() {
                sphere(r);
                sphere(r-camCapHspLensCoverT);
                cylinder(h = r+1, r = camCapLensRadius);
                translate([0, 0, -r*2+camCapThickness]) cube(r*4, true);
                translate([r+1+camCapHspLensCoverW/2, 0, 0]) cube(r*2+2, true);
                translate([-r-1-camCapHspLensCoverW/2, 0, 0]) cube(r*2+2, true);
            }
            for (a = _camCapCoverSuppConns)
                camCapHspLensCoverSuppConn(a[0], a[1]);
            camCapHspLensCoverSupp();
            mirror([1, 0, 0])
            camCapHspLensCoverSupp();
        }
        // hole for axle
        d = camCapVertAxleSqD()+camCapSpacing;
        cube([camCapHspCapSuppApartOut(), d, d], true);

        // make both end round
        rr = camCapHspLensCoverW/2+0.1;
        translate([0, 0, rr])
        difference() {
            translate([0, 0, -camCapHspLensCoverW/4])
            cube([rr*2, camCapRadius*2-0.2, camCapHspLensCoverW/2], true);
            rotate([90, 0, 0])
            translate([0, 0, -camCapRadius])
            cylinder(h = camCapRadius*2, r = rr);
        }
    }
}

module camCapHspSuppBar() {
    h = camCapHspCapSuppW();
    difference() {
        translate([camCapHspCapSuppApartIn()/2, 0, 0])
        rotate([0, 90, 0])
        difference() {
            translate([camCapAxleRadius+camCapSpacing, -camCapRadius, 0])
                cube([camCapSupportSize, camCapRadius*2, h]);
            translate([camCapAxleRadius+camCapSpacing+camCapSupportSize, 0, h/2])
            rotate([0, -90, 0]) rotate([0, 0, 90]) {
                _camCapNutHole(camCapSupportSize, 1, camCapHspHoleR(0));
                _camCapNutHole(camCapSupportSize, 1, camCapHspHoleR(1));
                _camCapNutHole(camCapSupportSize, 1, -camCapHspHoleR(0));
                _camCapNutHole(camCapSupportSize, 1, -camCapHspHoleR(1));
            }
            translate([0, 0, -0.1]) cylinder(h = h+0.2, r = camCapAxleRadius+camCapSpacing);
        }
        translate([0, 0, -camCapRadius])
        difference() {
            cylinder(h = camCapRadius*4, r = camCapRadius*2);
            translate([0, 0, -2])
            cylinder(h = camCapRadius*4+4, r = camCapRadius-camCapSupportSize-camCapSpacing-0.01);
        }
    }
}

module camCapHspLensCoverSuppOnCap() {
    difference() {
        union() {
            for (a = _camCapSuppOnCapAngles) camCapHspSuppArmOnCap(a);
            camCapHspSuppBar();
        }
        rotate([0, 90, 0])
        translate([0, 0, -camCapRadius*2])
        cylinder(h = camCapRadius*4, r = camCapAxleRadius+camCapSpacing);
    }
}

module camCapHspLensCoverRails() {
    r = camCapHspInnerR()+camCapThickness;
    difference() {
        sphere(r);
        sphere(r-camCapThickness);
        translate([0, 0, -r-1]) cube(r*2+2, true);
        translate([r+1+camCapHspRailsApartOut()/2, 0, 0]) cube(r*2+2, true);
        translate([-r-1-camCapHspRailsApartOut()/2, 0, 0]) cube(r*2+2, true);
        cube([camCapHspRailsApartIn(), r*2+2, r*2+2], true);
    }
    difference() {
        sphere(camCapRadius);
        sphere(r-camCapThickness);
        translate([0, 0, -camCapRadius-1]) cube(camCapRadius*2+2, true);
        translate([r+1+camCapHspRailsApartOut()/2, 0, 0]) cube(r*2+2, true);
        translate([-r-1-camCapHspRailsApartOut()/2, 0, 0]) cube(r*2+2, true);
        cube([camCapHspRailsApart(), camCapRadius*2+2, camCapRadius*2+2], true);
    }
    camCapHspLensCoverSuppOnCap();
    mirror([1, 0, 0])
    camCapHspLensCoverSuppOnCap();
}

module camCapHspLensCoverEraserForCap() {
    rot = camCapLensMaxAngle+1;
    difference() {
        rotate([rot, 0, 0])
        difference() {
            sphere(camCapRadius-camCapThickness);
            translate([0, 0, -camCapRadius]) cube(camCapRadius*2, true);
            translate([camCapRadius+camCapHspRailsApart()/2, 0, 0])
                cube(camCapRadius*2, true);
            translate([-camCapRadius-camCapHspRailsApart()/2, 0, 0])
                cube(camCapRadius*2, true);
        }
        translate([0, 0, camCapRadius+1]) cube(camCapRadius*2+2, true);
        cube([camCapRadius*2, camCapHspInnerR()*cos(rot)*2, camCapRadius*2], true);
    }
}

module camCapHspEraserForBody() {
    rot = camCapLensMaxAngle+1;
    y = (camCapRadius-(camCapThickness+camCapSpacing)*2)*cos(rot);
    h = camCapRadius*sin(rot)+camCapThickness+camCapSpacing;
    difference() {
        translate([0, 0, -h-0.1])
        cylinder(h = h+0.2, r = camCapRadius-camCapThickness);
        translate([0, 0, -h-0.2]) cylinder(h = h+0.4, r = camCapHspInnerR()*cos(rot)*2);
    }
}

module camCapHsp() {
    difference() {
        sphere(camCapRadius);
        sphere(camCapRadius-camCapThickness);
        translate([0, 0, -camCapRadius-1]) cube(camCapRadius*2+2, true);
    }
    difference() {
        translate([0, 0, -camCapThickness])
        difference() {
            r0 = camCapRadius-camCapSupportSize-camCapSpacing;
            connH = camCapSupportSize*3;
            union() {
                cylinder(h = camCapThickness+0.001, r = camCapRadius);
                translate([0, 0, -connH])
                cylinder(h = connH+0.001, r = r0);
            }
            translate([0, 0, -connH-0.1])
                cylinder(h = camCapThickness+connH+0.2, r = r0 - camCapThickness);
        }
        camCapHspLensCoverEraserForCap();
    }
}

module camCapHspLensTrackEraser() {
    hull() {
        rotate([90-camCapLensMinAngle, 0, 0])
            cylinder(h = camCapRadius*2, d = camCapHspLensTrackW());
        rotate([90-camCapLensMaxAngle, 0, 0])
            cylinder(h = camCapRadius*2, d = camCapHspLensTrackW());
    }
}

module camCapHspSingleLens() {
    difference() {
        camCapHsp();
        camCapHspLensTrackEraser();
    }
    camCapHspLensCoverRails();
}

module camCapHspLensMountSupp(nuts = 1, select = [1,2]) {
    off = camCapHspCoverSuppApartIn()/2-camCapSupportSize-camCapSpacing;
    difference() {
        union()
        for (i = select) {
            camCapHspSuppArm(off, _camCapSuppOnCoverAngles[i],
                outerR = camCapHspInnerR()-camCapHspLensTrackSp,
                spThickness = camCapSupportSize,
                holes = "nut");
        }
        camCapOuterEraser(
            camCapHspInnerR()-camCapHspLensTrackSp-camCapSupportSize-camCapSpacing);
        rotate([0, 90, 0])
        translate([0, 0, -camCapRadius*2])
        cylinder(h = camCapRadius*4, r = camCapHspHoleR(2-nuts)-camCapBoltCapRadius*2);
    }
}

module camCapHspLensMount(nuts = 1, select = [1,2]) {
    camCapHspLensMountSupp(nuts, select);
    mirror([1, 0, 0])
    camCapHspLensMountSupp(nuts, select);
}

module camCapHspVertAxle(sqL = 0, rndL = 0) {
    d = camCapVertAxleSqD();
    translate([camCapHspCoverSuppApartIn()/2-sqL, -d/2, -d/2])
        cube([camCapHspCoverSuppW()+camCapSpacing+sqL, d, d]);
    translate([camCapHspCapSuppApartIn()/2, 0, 0])
    rotate([0, 90, 0])
        cylinder(h = camCapHspCapSuppW()+rndL, r = camCapAxleRadius);
}

module camCapHspVertAxles(sqL = 0, rndL = 0) {
    camCapHspVertAxle(sqL, rndL);
    mirror([1, 0, 0])
    camCapHspVertAxle(sqL, rndL);
}

module camCapHspBody(h) {
    difference() {
        translate([0, 0, -camCapThickness-camCapSpacing-h])
        difference() {
            cylinder(h = h, r = camCapRadius);
            translate([0, 0, -0.1])
            cylinder(h = h+0.2, r = camCapRadius-camCapSupportSize-camCapSpacing);
        }
        camCapHspEraserForBody();
    }
}

module camCapTestCamModule(
    lensR = 8.3,
    lensD = 6.6,
    mntW = 26.8,
    mntH = 17.5,
    mntD = 9.2,
    boardSz = 28.1,
    boardD = 16,
    boardOvl = 1.5,
    offH = 10.5,) {
    translate([0, 0, camCapRadius-lensD-mntD]) {
        translate([0, 0, mntD/2]) cube([mntW, mntH, mntD], true);
        translate([0, 0, mntD]) cylinder(h = lensD, r = lensR);
        translate([0, offH/2, -boardD/2+boardOvl])
            cube([boardSz, boardSz, boardD], true);
    }
}

module camCapTestCamModule1(
    lensR = 7.85,
    lensD = 8,
    mntW = 24,
    mntH = 16,
    mntD = 7.2,
    boardSz = 38.3,
    boardD = 20,
    boardOvl = 2) {
    translate([0, 0, camCapRadius-lensD-mntD]) {
        translate([0, 0, mntD/2]) cube([mntW, mntH, mntD], true);
        translate([0, 0, mntD]) cylinder(h = lensD, r = lensR);
        translate([0, 0, -boardD/2+boardOvl])
            cube([boardSz, boardSz, boardD], true);
    }
}
