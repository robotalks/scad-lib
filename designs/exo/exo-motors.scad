include<exo-common.scad>

exoWheelR = 33.25;
exoWheelD = 28;
exoWheelSp = 5;

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

module exoMotorMountR() {
    l = ttMotorShL()+ttMotorShNeckL()+ttMotorShMotorL()+ttMotorThick()+ttMotorSpacing();
    d = ttMotorShThinD()+ttMotorShThickD();
    h = ttMotorShH()-(ttMotorThick()+ttMotorSpacing())*2;
    difference() {
        translate([-exoBaseHoleSp*2, -exoBaseHoleSp*5, h/2]) {
            difference() {
                ttMotorShell(tailScrew = false, hollow = false, withMotor = true);
                thin_d = ttMotorShThinD()-ttMotorThick();
                translate([-ttMotorShXOffS()-0.1, -ttMotorShThinD()-0.1, -ttMotorShH()/2-0.001])
                cube([l+0.2, d+0.2, ttMotorThick()+0.1]);
                translate([0, -thin_d, -ttMotorShH()/2-0.1])
                cube([ttMotorShL()+ttMotorShNeckL(), thin_d*2, ttMotorShH()/2]);
                translate([-ttMotorShXOffS()-ttMotorShTailL()*2-1, -ttMotorShTailD()/2-2, -h/2])
                cube([ttMotorShTailL()*4+2, ttMotorShTailD()+4, h]);
            }
            xoff = exoBaseHoleSp*2-ttMotorShXOffS();
            translate([-ttMotorShXOffS()-xoff, 0, -h/2]) {
                hull() {
                    cylinder(h = THICK, d = exoHoleMntD);
                    translate([xoff, -ttMotorShThinD(), 0])
                    cube([ttMotorThick(), d, THICK]);
                }
                hull() {
                    translate([exoBaseHoleSp*8, 0, 0])
                    cylinder(h = THICK, d = exoHoleMntD);
                    translate([ttMotorShXOffS()+xoff+ttMotorShXOffL()+ttMotorShNeckL()+ttMotorShMotorL(), -ttMotorShThinD(), 0])
                    cube([THICK, d, THICK]);
                }
                hull() {
                    translate([exoBaseHoleSp*2, exoBaseHoleSp*2, 0])
                    cylinder(h = THICK, d = exoHoleMntD);
                    translate([exoBaseHoleSp*3, exoBaseHoleSp*2, 0])
                    cylinder(h = THICK, d = exoHoleMntD);
                    translate([xoff, ttMotorShThickD()-THICK, 0])
                    cube([ttMotorShL(), THICK, THICK]);
                }
            }
        }
        translate([-exoBaseHoleSp*2, -exoBaseHoleSp*5, h/2]) {
            translate([-ttMotorShAxesHoleR()-SP, -ttMotorShThinD()-0.1, -ttMotorShH()/2])
            cube([ttMotorShAxesHoleR()*2+SP*2, ttMotorShThinD()+ttMotorShThickD()+0.2, ttMotorShH()/2]);
            translate([-ttMotorShXOffS()+ttMotorShRndHullOff()-SP, ttMotorShThickD()-THICK-0.1, -ttMotorShH()/2])
            cube([ttMotorShRndHullR()*2+SP*2, THICK*2+0.1, ttMotorShH()/2]);
        }
        translate([0, 0, THICK]) {
            exoNutArray([-4:-4], [-5:-5], boltL = THICK*2);
            exoNutArray([-2:-1], [-3:-3], boltL = THICK*2);
            exoNutArray([4:4], [-5:-5], boltL = THICK*2);
        }
    }
}

module exoMotorMountL() {
    mirror([0, 1, 0]) exoMotorMountR();
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
