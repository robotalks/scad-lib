include<exo-parts.scad>

$fn = 160;
target = "";

if (target == "board") exoBoard();
if (target == "batmount-f") exoBatMountF();
if (target == "batmount-t") exoBatMountT();
if (target == "motor-r") exoMotorMountR();
if (target == "motor-l") exoMotorMountL();
if (target == "l1-top") exoL1BaseTop();
if (target == "l1-stands-f") exoL1StandsHalfF();
if (target == "l1-stands-t") exoL1StandsHalfT();
if (target == "l1-stands-m") exoL1StandsHalfM();
