# OpenSCAD Parts

This repository contains robotics parts developed using OpenSCAD.
Most of them can be highly customizable and reusable.
Simply point to `lib` folder as OpenSCAD libraries path,
and use `include` or `use` in your project.

# Render

```
./render.sh COMPONENT TARGET
```

will render STL file in `out` directory.
The file `lib/COMPONENT-render.scad` is required to render the model.

# Reuse and Customization

Some parts has large number of configuration variables.
To customize those, create your own custom .scad file, and use `include`:

E.g. create `mycamcap.scad`

```
include<camcap-hemisphere.scad>

camCapRadius = 80;

```

Then reference `mycamcap.scad` using `use`:

```
use<mycamcap.scad>

camCapHspSingleLens();
```
