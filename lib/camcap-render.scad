include<camcap-hemisphere.scad>

$fn = 120;
target = "";

if (target == "hsp.cap") camCapHspSingleLens();
if (target == "hsp.lens") camCapHspLensCover();
