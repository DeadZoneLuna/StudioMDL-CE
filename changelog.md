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