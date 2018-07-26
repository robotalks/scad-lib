include<tt-motor-parts.scad>

$fn = 160;
target = "";

if (target == "ttm.shell.upper") ttMotorShellUpper();
if (target == "ttm.shell.bottom") ttMotorShellBottom();
