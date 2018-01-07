include<camcap-hemisphere.scad>

//$fn = 100;

camCapHspSingleLens();
rotate([70, 0, 0]) {
    color("green") camCapHspLensCover();
    color("lightgray") camCapHspLensMount();
    color("red") camCapHspVertAxles(sqL = 4, rndL = 1);
    color("gray") camCapTestCamModule1();
}
//camCapHspBody(100);
