M3NutHoleD = 6.4;
M3BoltHoleD = 3;
M3CapHoleD = 6.4;

M25NutHoleD = 5.6;
M25BoltHoleD = 2.6;
M25CapHoleD = 5.6;

M2NutHoleD = 4.8;
M2BoltHoleD = 2.2;
M2CapHoleD = 4.8;

module _BoltNutHole(h, boltLen, holeD, boltD, nut) {
    if (h > 0) {
        if (nut) cylinder(h = h, d = holeD, $fn = 6);
        else cylinder(h = h, d = holeD);
    }
    if (boltLen > 0)
        translate([0, 0, -boltLen])
        cylinder(h = boltLen, d = boltD);
}

module M3NutHole(h = 2, boltLen = 2) {
    _BoltNutHole(h, boltLen, M3NutHoleD, M3BoltHoleD, true);
}

module M3BoltHole(capH = 2, boltLen = 2) {
    _BoltNutHole(capH, boltLen, M3CapHoleD, M3BoltHoleD, false);
}

module M25NutHole(h = 2, boltLen = 2) {
     _BoltNutHole(h, boltLen, M25NutHoleD, M25BoltHoleD, true);
}

module M25BoltHole(capH = 2, boltLen = 2) {
    _BoltNutHole(capH, boltLen, M25CapHoleD, M25BoltHoleD, false);
}

module M2NutHole(h = 2, boltLen = 2) {
    _BoltNutHole(h, boltLen, M2NutHoleD, M2BoltHoleD, true);
}

module M2BoltHole(capH = 2, boltLen = 2) {
    _BoltNutHole(capH, boltLen, M2CapHoleD, M2BoltHoleD, false);
}
