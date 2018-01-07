include<camcap-hemisphere.scad>

$fn = 120;
support = false;
target = "";

if (target == "hsp.cap") camCapHspSingleLens();
if (target == "hsp.lens") camCapHspLensCover();