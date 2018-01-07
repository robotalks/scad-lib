// CameraCap Utilities

include<camcap-vars.scad>

module camCapOuterEraser(r = camCapRadius) {
    difference() {
        sphere(camCapRadius*2);
        sphere(r);
    }
}
