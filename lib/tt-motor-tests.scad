include<tt-motor-parts.scad>

$fn = 100;

//ttMotorShellUpper();
//ttMotorShellBottom();
//ttMotor();

color("red") translate([ttMotorShXOffS(), ttMotorShThinD(), ttMotorShH()/2]) {
    ttMotorShellUpper();
    ttMotorShellBottom();
    ttMotor();
}

color("green")
translate([-ttMotorShXOffL(), -ttMotorShThickD(), -ttMotorShH()/2]) {
    ttMotorShellUpper();
    ttMotorShellBottom();
    ttMotor();
}

color("blue") translate([ttMotorShXOffS()+ttMotorShTailL(), ttMotorShThinD(), -ttMotorShH()/2]) {
    ttMotorShellUpper();
    ttMotorShellBottom();
    ttMotor();
}

color("yellow")
translate([-ttMotorShXOffL()-ttMotorShNeckL(), -ttMotorShThickD(), ttMotorShH()/2]) {
    ttMotorShellUpper();
    ttMotorShellBottom();
    ttMotor();
}