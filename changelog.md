-------------------------------------------------------------------------
## [0.2 Stable] - 27.02.25
-------------------------------------------------------------------------
## Features
- **Added** $defaqscale/-defaqscale **(used ones)** - Increases flexes by **10** times.
- **Added** $ignoredmxdefaq/-ignoredmxdefaq **(used ones)** - ignore increases flexes for DMX if **$defaqscale/-defaqscale** is used.
- **Added** fscale <value> **(used within "flexfile")** - Increase flex to the specified value.
- **Added** $outputbuffersize/-outputbuffersize <size in mb> - Maximum buffer size for writing data to MDL, VVD, VTX files (by default this buffer has been increased to **64 MB**).
- **Added** $uselegacystripify/-uselegacystripify - Reuse nvtristrip library for generating indices (re-sorting).
- **Added** $alwayscollapsebyprefix <prefix> - Does the same thing as $alwayscollapse, only collapse bones by prefix in the name.
- **Added** addcontrollerbyflex <type> <min> <max> **(used within "flexfile")** - Creates flex controllers based on flexes (their name, specified type and specified minimum/maximum).
- **Added** bindtoonebone **(used within $bodygroup, $model, $body)** - Overrides model weights to the first bone in vertex **(Experimental)**.
- **Added** -eyeballscale <scale> - Equivalent to the **$eyeballscale** command.
- **Added** $collisionbindtoonebone/-collisionbindtoonebone **(used ones)** - Overrides collision model weights to the first bone in vertex **(Experimental)**.
- **Added** $includeanimprefix/-includeanimprefix <prefix> **(used ones)** - Adds a prefix to the end of the model's include name in $includemodel.
- **Added** $includeprefix/-includeprefix <target> <prefix> - Adds a prefix at the end of the file name that is specified in $include.
- **Added** renamematbyprefix <prefix> **(used within $bodygroup, $model, $body)** - Adds a prefix to the material name.

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
- **Added** $dontdestroy/-dontdestroy - Prevents deletion of processed files after a crash (Useful only at the stage of successful indices generation).
- **Added** $ignoreeyelid/-ignoreeyelid - Disables automatic eyelid setup for eyeballs while preserving flex rules.
- **Added** $addinvstudioflexes/-addinvstudioflexes - Generates inverted flexes and creates corresponding inverted rules by multiplying their values by -1.
- **Added** $zeroflexdecay/-zeroflexdecay - Removes "decay" effect between flexes. This is particularly useful in Source Filmmaker (SFM) to prevent flexes from resetting to zero during shot transitions.
- **Added** -mostlyopaque - Assigns the **STUDIOHDR_FLAGS_TRANSLUCENT_TWOPASS** model flag to forcing engine process shaders in two passes. This can help resolve transparency issues or improve Ambient Occlusion (AO).
- **Added** $allowcollapsevertexbone - Allows collapse vertex bones (Not collapse only if this bone is used in bonemerge, ik, animation and attachment).
- **Added** $hboxignorechild - Ignores compute child bboxes (may be useful for SFMs when bbox is too large).
- **Added** $eyeballscale - Scales eye position and pupil size based on the value ($scale will be ignored for eyes by this command).
- **Added** $ignoreeyeballirisscale - Ignores pupil scale when $scale or $eyeballscale is used. (Probably useful when using EyeRefract shader and the eye radius is set in the material)
- **Added** $ignoredefaultflexkey - Ignore bakes defaultflex vertexes into model (lods) vertexes.
- **Added** renamemat **(used within $bodygroup, $model, $body)** - Creates a unique version of the reference and renames the material from source to target. (Useful when we don't need to manually create a copy of the reference file with a different material name)
- **Added** invertcontrollers **(used within "flexfile")** - Works like the "-addinvstudioflexes" argument. It copy original flexes & inverts them with change controller range (-1 1) until toggled off.

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