*all arguments/commands are case-insensitive*

-------------------------------------------------------------------------
## [0.3 - WIP] - SOON?
-------------------------------------------------------------------------
## Improvements
- Flex keys, flex controllers, flex descriptions, and flexes in general have been reworked from a fixed array to a dynamic (65536~ flex verts in total are still engine limit, try avoiding many flex verts to works correctly without bugs & crashes in engine)
- `-game` is no longer required, by default the model will be compiled next to qc if `gameinfo.txt` is not found.
- Now segmentation/clamping of references ("cutting into multiple models") works correcly (some mesh parts are now no longer missing)
- Jiggle bones from a fixed array have been reworked into a dynamic. (To get rid of problems when there are many of them and the compiler starts crashing, since the optimization of the number of jingle bones occurs at the end after qc parsing)

## Fixes
- **Fixed** some crashes and bugs when 17+ `$CDMaterials` appear.
- **Fixed** issues where two separate VTAs caused the compiler to crash.
- **Fixed** flex issues (for the new style, i.e. DMX) after segmentation/clamping, when the compiler could crash after processing them.
- **Fixed** duplication of flex controllers after segmentation/clamping references. (Reverse engineered the behavior of studiomdl from SFM)
- **Fixed** some crashes caused by stackoverflow (increased the stack size, this is necessary for some long loops... Valve did the same thing in studiomdl from sfm)

## Features
- **Added** `-OutDir/$OutDir` - The output path where the model will eventually be compiled, either an absolute path or relative to qc.
- **Added** `-IgnoreEyeballScaling/$IgnoreEyeballScaling` - Ignores eye offsets and radius scaling when using the $scale command.
- **Added** `-ComputeWrinkles/$ComputeWrinkles` - Uses the current combo rules ( i.e. The wrinkleScales, via SetWrinkleScale()) to compute wrinkle delta values.
- **Added** `-ComputeDeltaNormals/$ComputeDeltaNormals` - Computes new smooth normals for the current mesh and all of its delta states.
- **Added** `-ComputeNormalsAndWrinkles/$ComputeNormalsAndWrinkles` - Uses **-ComputeDeltaNormals/$ComputeDeltaNormals** and **-ComputeWrinkles/$ComputeWrinkles** at the same time.
- **Added** `ComputeWrinkles` - Uses the current combo rules on current reference ( i.e. The wrinkleScales, via SetWrinkleScale()) to compute wrinkle delta values.
- **Added** `ComputeDeltaNormals` - Computes new smooth normals for the current reference and all of its delta states.
- **Added** `ComputeNormalsAndWrinkles` - Uses **ComputeDeltaNormals** and **ComputeWrinkles** at the same time on current reference
- **Added** `IgnoreComputeWrinkles` - Disable compute wrinkles on current reference (if **-ComputeWrinkles/$ComputeWrinkles** is used)
- **Added** `IgnoreComputeDeltaNormals` - Disable compute delta normals on current reference (if **-ComputeDeltaNormals/$ComputeDeltaNormals** is used)
- **Added** `IgnoreComputeNormalsAndWrinkles` - Disable compute delta normals and wrinkles on current reference (if **-ComputeWrinkles/$ComputeWrinkles** and **-ComputeDeltaNormals/$ComputeDeltaNormals** is used)

**Ex. usage:**
- `$OutDir "./"` - Means to have the model compiled next to qc (useful if the `-game` command was given)
- `$OutDir "../"` - Means that the model should be compiled to a level lower than qc (For example, qc is located at the path `X:\Cool_Folder1\Cool_Folder2\`, after that the output path will become `X:\Cool_Folder1\`
- `$OutDir "X:\Cool_Folder1\"` - Means that the model should be compiled at the specified absolute path.
```
$model "my_cool_name" "my_cool_reference.dmx" ComputeWrinkles {
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" ComputeWrinkles

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" ComputeWrinkles
	//...
}
```

## Known issues
- **BUG** With some models when scaling (by **$scale**) to some larger values, may causes problems with the weights.
- **BUG** Sometimes, with a certain number of vertices after segmentation/clamping (not sure), flex vertices cause crashes.
- **TODO** VTA ("old style" vertex animations) flexes after segmentation/clamping do not work on all vertices (rework "old style" vertex animations required).
- **TODO** With flexes (only new style?), there may be differences in shading due to some differences in the direction of normals (deep debugging required).
- **TODO** High memory usage, optimization of some variables from a fixed array to a dynamic is required + get rid of **$outputbuffersize/-outputbuffersize** (so that more things can be done)
- **TODO** Improve SMD/VTA reading performance (it is very slow)
- **TODO** Remove some of the limits on the number of materials in references (Make partially dynamic)
- **TODO** Allow bodygroups to be configured as models (flexes, etc.) for more flexibility

-------------------------------------------------------------------------
## [0.2 Stable] - 27.02.25
-------------------------------------------------------------------------
## Features
- **Added** `$defaqscale/-defaqscale` **(used ones)** - Increases flexes by **10** times.
- **Added** `$ignoredmxdefaq/-ignoredmxdefaq` **(used ones)** - ignore increases flexes for DMX if **$defaqscale/-defaqscale** is used.
- **Added** `fscale <value>` **(used within "flexfile")** - Increase flex to the specified value.
- **Added** `$outputbuffersize/-outputbuffersize <size in mb>` - Maximum buffer size for writing data to MDL, VVD, VTX files (by default this buffer has been increased to **64 MB**).
- **Added** `$uselegacystripify/-uselegacystripify` - Reuse nvtristrip library for generating indices (re-sorting).
- **Added** `$alwayscollapsebyprefix <prefix>` - Does the same thing as $alwayscollapse, only collapse bones by prefix in the name.
- **Added** `addcontrollerbyflex <type> <min> <max>` **(used within "flexfile")** - Creates flex controllers based on flexes (their name, specified type and specified minimum/maximum).
- **Added** `bindtoonebone` **(used within $bodygroup, $model, $body)** - Overrides model weights to the first bone in vertex **(Experimental)**.
- **Added** `-eyeballscale <scale>` - Equivalent to the **$eyeballscale** command.
- **Added** `$collisionbindtoonebone/-collisionbindtoonebone` **(used ones)** - Overrides collision model weights to the first bone in vertex **(Experimental)**.
- **Added** `$includeanimprefix/-includeanimprefix <prefix>` **(used ones)** - Adds a prefix to the end of the model's include name in $includemodel.
- **Added** `$includeprefix/-includeprefix <target> <prefix>` - Adds a prefix at the end of the file name that is specified in $include.
- **Added** `renamematbyprefix <prefix>` **(used within $bodygroup, $model, $body)** - Adds a prefix to the material name.

## Improvements
- Allow increase flexes by 10 times or by specified
- Increased file buffer size to **64 mb** for writing MDL, VTX, VVD.
- Improved compilation time when generating indices (re-sorting) by replace **nvtristrip** to **meshoptimizer** (nvtristrip can be reuse by using **$uselegacystripify/-uselegacystripify** commands).
- Large addresses are allowed (LARGEADDRESSAWARE) so that more complex models can be compiled **(e.g. a model with 1 million vertices)**.
- Changed logic of bones collapse, now when using **$alwayscollapse** - it will be collapsed always, even if this bone has weights on vertices.
- Slightly changed debugging information when cutting model into multiple models (Which model is in process and how many vertices it has).
- Increased flex rules operations from **512** to **2048**.
- **renamemat** now support DMX.

## Fixed
- It is no longer necessary to specify **$maxverts** (only if you need the wireframe for debugging, it is better to set the limit to **32768** or **21845**).
- **Fixed** cutting reference into multiple references crash.
- **Fixed** crashes on indices generation due to file buffer overflow (This buffer can be configured with **$outputbuffersize/-outputbuffersize**).
- **Fixed** writing materialreplacement in file.
- **Fixed** empty "**bad command**" error with collision models.

## Known issues
- **BUG** With some models when scaling (by **$scale**) to some larger values, may causes problems with the weights.
- **TODO** At the moment cutting a model into several only works with group 0 and model 0, the other groups and models may be missing some parts of the meshes!

-------------------------------------------------------------------------
## [0.1 Unstable] (Initial Release) - 12.12.24
-------------------------------------------------------------------------
## Features
- **Added** `$dontdestroy/-dontdestroy` - Prevents deletion of processed files after a crash (Useful only at the stage of successful indices generation).
- **Added** `$ignoreeyelid/-ignoreeyelid` - Disables automatic eyelid setup for eyeballs while preserving flex rules.
- **Added** `$addinvstudioflexes/-addinvstudioflexes` - Generates inverted flexes and creates corresponding inverted rules by multiplying their values by -1.
- **Added** `$zeroflexdecay/-zeroflexdecay` - Removes "decay" effect between flexes. This is particularly useful in Source Filmmaker (SFM) to prevent flexes from resetting to zero during shot transitions.
- **Added** `-mostlyopaque` - Assigns the **STUDIOHDR_FLAGS_TRANSLUCENT_TWOPASS** model flag to forcing engine process shaders in two passes. This can help resolve transparency issues or improve Ambient Occlusion (AO).
- **Added** `$allowcollapsevertexbone` - Allows collapse vertex bones (Not collapse only if this bone is used in bonemerge, ik, animation and attachment).
- **Added** `$hboxignorechild` - Ignores compute child bboxes (may be useful for SFMs when bbox is too large).
- **Added** `$eyeballscale` - Scales eye position and pupil size based on the value ($scale will be ignored for eyes by this command).
- **Added** `$ignoreeyeballirisscale` - Ignores pupil scale when $scale or $eyeballscale is used. (Probably useful when using EyeRefract shader and the eye radius is set in the material)
- **Added** `$ignoredefaultflexkey` - Ignore bakes defaultflex vertexes into model (lods) vertexes.
- **Added** `renamemat` **(used within $bodygroup, $model, $body)** - Creates a unique version of the reference and renames the material from source to target. (Useful when we don't need to manually create a copy of the reference file with a different material name)
- **Added** `invertcontrollers` **(used within "flexfile")** - Works like the "-addinvstudioflexes" argument. It copy original flexes & inverts them with change controller range (-1 1) until toggled off.

## Improvements
- Vertex animations limit increased to **65,536** (MAXSTUDIOFLEXVERTS)
- Bones limit increased to **256** (MAXSTUDIOBONES)
- Materials limit increased to **128** (MAXSTUDIOSKINS)
- Flex controllers limit increased to **480** (MAXSTUDIOFLEXCTRL)
- Animation limit increased to **3000** (MAXSTUDIOANIMS)
- Weights threshload changed from **0.05** to **0.001**
- **$scale** now supports scaling of old-style vertex animations (including eyes)

## Known issues
- **BUG** Cutting model into multiple models cause crash.
- When writing materialreplacement in file cause crash sometimes (fixed by **$dontdestroy/-dontdestroy** command temporary).
- Crash on indices generation due to file buffer overflow.
- Empty **"bad command"** error with collision models.
- **BUG** With some models when scaling (by **$scale**) to some larger values, may causes problems with the weights.