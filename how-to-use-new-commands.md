*TODO: Move this information to the wiki page!*

> **NOTE:**  
> - Commands starting with `-` are **StudioMDL startup arguments** (passed via command line).  
> - Commands starting with `$` are **QC/QCI script commands**.
>
> **Important:**  
> Some commands affect global compiler state. In such cases, it is recommended to place them **before** `$model`, `$body`, or `$bodygroup` definitions to ensure correct and predictable behavior.

## Global Commands
`-OutputBufferSize/-OutputBufferSize <size in mb>` - Set maximum buffer size for writing data to MDL/ANI file (by default this buffer size is  **64 MB**)
Example:
```
$OutputBufferSize 75 // means the compiler will allocate 75 MB for writing the output buffer to the MDL/ANI file
```

`-MDLOutputBufferSize/$MDLOutputBufferSize <size in MB>` - Set maximum buffer size for writing data to MDL file (by default this buffer size is  **64 MB**)

Example:
```
$MDLOutputBufferSize 75 // means the compiler will allocate 75 MB for writing the output buffer to the MDL file
```

`-ANIOutputBufferSize/$ANIOutputBufferSize <size in MB>` - Set maximum buffer size for writing data to ANI file (by default this buffer size is  **64 MB**)

Example:
```
$ANIOutputBufferSize 75 // means the compiler will allocate 75 MB for writing the output buffer to the ANI file
```

`-OutDir/$OutDir` - Specifies the output directory for compiled models.  
 - The path can be **relative to the QC file** or an **absolute path**.  
 - All paths are resolved relative to the `models` directory.

Example:
```
$OutDir "./" // Compiles the model next to the QC file, relative to the models folder.

$OutDir "../" // Compiles the model one directory level above the QC file. (Multiple levels can be specified by chaining "../")
// Example:
// $OutDir "../" -> "X:\Cool_Folder1\"
// $OutDir "../../" -> "X:\"
// (All paths are resolved relative to the models folder)

$OutDir "X:\Cool_Folder1\" // Compiles the model to the specified absolute path (still resolved relative to the models folder).
```

`-IncludePrefix/$IncludePrefix <target> <prefix>` - Adds a prefix at the end of the file name that is specified in `$Include`.

Example:
```
$IncludePrefix "my_cool_inc.qci" "mycoolprefix_"
$Include "my_cool_inc.qci" // Compiler will add a prefix to the include name, for example: mycoolprefix_my_cool_inc.qci.
```

`$PUSHDInclude <1|0>` - Controls whether `$Include` files are resolved relative to the currently active `$pushd` directory.  
 - This is useful when `.qci` files need to be loaded from a different location rather than from the directory next to the main QC file.  
 - The setting also applies recursively to any child `$Include` commands inside included `.qci` files.
Example:
```
$PUSHDInclude 1 // Enable resolving $Include from the active $pushd
$pushd "../Humans/Male/Group01" // Set directory where includes will be searched
$Include "my_cool_include.qci" // Loaded from "../Humans/Male/Group01"
$popd // Restore previous directory
```

`$PUSHDProcedural <1|0>` - Same behavior as `$PUSHDInclude`, but applied to `$ProceduralBones` (VRD files).

Example:
```
$PUSHDProcedural 1 // Enable resolving $ProceduralBones from the active $pushd
$pushd "../Humans/Male/Group01" // Set directory where VRD files will be searched
$ProceduralBones "my_cool_include.vrd" // Loaded from "../Humans/Male/Group01"
$popd // Restore previous directory
```

`-AlwaysCollapseByPrefix/$AlwaysCollapseByPrefix <prefix>` - Does the same thing as $alwayscollapse, only collapse bones by prefix in the name.

Example:
```
$AlwaysCollapseByPrefix "!unused_"
```

`-EyeballScale/$EyeballScale <scale>` - Scales eye position and pupil size based on the value (`$scale` will be ignored for eyes by this command).

Example:
```
$EyeballScale 1.5 // will offset/scale eyes to 150%

$Model "MyCoolModelGroup" "MyCoolModelFile.smd" {
	// here is eyes
}
```

`-IncludeAnimPrefix/$IncludeAnimPrefix <prefix>` - Adds a prefix to the end of the model's include name in `$IncludeModel`.

Example:
```
$IncludeAnimPrefix "mycoolprefix_"

$IncludeModel "include_model.mdl" // Compiler adds a prefix to the name of the include model, for example: mycoolprefix_include_model.mdl
```

---

*Below are commands that do not require a value to be entered; simply declare them to enable/disable their function.*
Example:
```
$CoolCommand // That's all, no action required
```

- `-UseLegacyStripify/$UseLegacyStripify` - Reuse nvtristrip library for generating strips (re-sorting).
- `-UseLegacyClampMethod/$UseLegacyClampMethod` - Revert to the old segmentation/clamping method (Apply a global limit on the number of vertices for the entire reference (model))
- `-IgnoreEyeballScaling/$IgnoreEyeballScaling` - Ignores eye offsets and radius scaling when using the `$scale` command.
- `-OverrideFlexControllers/$OverrideFlexControllers` - Allows overriding existing flex controllers
- `-AllowDuplicationFlexControllers/$AllowDuplicationFlexControllers` - Allows duplicate flex controllers (USE ONLY IF KNOWING WHAT TO DO!)
- `-RemapFlexToGlobal/$RemapFlexToGlobal` - Enable remapping of flexes for the new style (DMX) to the global bone space (by default, this feature was previously enabled, but is now disabled to improve flexes quality)
- `-ComputeWrinkles/$ComputeWrinkles` - Uses the current combo rules ( i.e. The wrinkleScales, via SetWrinkleScale()) to compute wrinkle delta values on all models.
- `-ComputeDeltaNormals/$ComputeDeltaNormals` - Computes new smooth normals for the current mesh and all of its delta states on all models.
- `-ComputeNormalsAndWrinkles/$ComputeNormalsAndWrinkles` - Uses `-ComputeDeltaNormals/$ComputeDeltaNormals` and `-ComputeWrinkles/$ComputeWrinkles` at the same time.
- `-IgnoreEyelid/$IgnoreEyelid` - Disables automatic eyelid setup for eyeballs while preserving flex rules.

After use `-IgnoreEyelid/$IgnoreEyelid`, need do this:
```
// Rules for eyelid flex must be edited from this (for hl2 FACS):
%upper_right_raiser = right_lid_raiser * (1 - right_lid_droop * 0.8) * (1 - right_lid_closer) * (1 - blink)
%upper_right_neutral = (1 - right_lid_droop * 0.8) * (1 - right_lid_raiser) * (1 - right_lid_closer) * (1 - blink)
%upper_right_lowerer = right_lid_closer + blink * (1 - right_lid_closer)
%upper_left_raiser = left_lid_raiser * (1 - left_lid_droop * 0.8) * (1 - left_lid_closer) * (1 - blink)
%upper_left_neutral = (1 - left_lid_droop * 0.8) * (1 - left_lid_raiser) * (1 - left_lid_closer) * (1 - blink)
%upper_left_lowerer = left_lid_closer + blink * (1 - left_lid_closer)
%lower_right_raiser = right_lid_closer + blink * 0.5 * (1 - right_lid_closer)
%lower_right_neutral = (1 - right_lid_closer) * (1 - 0.5 * blink) * (1 - right_lid_tightener * 0.5) * (1 - right_cheek_raiser * 0.25)
%lower_right_lowerer = 0
%lower_left_raiser = left_lid_closer + blink * 0.5 * (1 - left_lid_closer)
%lower_left_neutral = (1 - left_lid_closer) * (1 - 0.5 * blink) * (1 - left_lid_tightener * 0.5) * (1 - left_cheek_raiser * 0.25)
%lower_left_lowerer = 0
// To this:
%upper_right_raiser = right_lid_raiser
%upper_right_lowerer = right_lid_closer + blink + right_lid_droop
%upper_left_raiser = left_lid_raiser
%upper_left_lowerer = left_lid_closer + blink + left_lid_droop
%lower_right_raiser = right_lid_closer + (blink * 0.5) + right_lid_closer + right_lid_tightener + (right_cheek_raiser * 0.25)
%lower_right_lowerer = 0
%lower_left_raiser = left_lid_closer  + (blink * 0.5) + left_lid_closer + left_lid_tightener + (left_cheek_raiser * 0.25)
%lower_left_lowerer = 0
```

- `-AddInvStudioFlexes/$AddInvStudioFlexes` - Generates inverted flexes and creates corresponding inverted rules by multiplying their values by -1.
- `-ZeroFlexDecay/$ZeroFlexDecay` - Removes "decay" effect between flexes. This is particularly useful in Source Filmmaker (SFM) to prevent flexes from resetting to zero during shot transitions.
- `-MostlyOpaque/$MostlyOpaque` - Assigns the **STUDIOHDR_FLAGS_TRANSLUCENT_TWOPASS** model flag to forcing engine process shaders in two passes. This can help resolve transparency issues or improve Ambient Occlusion (AO).
- `-CollisionBindToOneBone/$CollisionBindToOneBone` - Overrides collision model weights to the first bone in vertex **(Experimental)**.
- `$IgnoreEyeballIrisScale` - Ignores pupil scale when $scale or $EyeballScale is used. (Probably useful when using EyeRefract shader and the eye radius is set in the material)
- `$AllowCollapseVertexBone` - Allows collapse vertex bones (Not collapse only if this bone is used in bonemerge, ik, animation and attachment). (Experimental)
- `$HBoxIgnoreChild` - Ignores compute child bboxes (may be useful for SFMs when bbox is too large).
- `$IgnoreDefaultFlexKey` - Ignore bakes defaultflex vertexes into model (lods) vertexes.
- `-DefaqScale/$DefaqScale` - Increases flexes by **10** times.
- `-IgnoreDMXDefaq/$IgnoreDMXDefaq` - ignore increases flexes for DMX if **$DefaqScale/-DefaqScale** is used.

## Sub-Commands

`ComputeWrinkles` - Uses the current combo rules on current model ( i.e. The wrinkleScales, via SetWrinkleScale()) to compute wrinkle delta values.
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

`ComputeDeltaNormals` - Computes new smooth normals for the current model and all of its delta states.
```
$model "my_cool_name" "my_cool_reference.dmx" ComputeDeltaNormals {
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" ComputeDeltaNormals

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" ComputeDeltaNormals
	//...
}
```

`ComputeNormalsAndWrinkles` - Uses **ComputeDeltaNormals** and **ComputeWrinkles** at the same time on current model
```
$model "my_cool_name" "my_cool_reference.dmx" ComputeNormalsAndWrinkles {
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" ComputeNormalsAndWrinkles

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" ComputeNormalsAndWrinkles
	//...
}
```

`IgnoreComputeWrinkles` - Disable compute wrinkles on current model (if **-ComputeWrinkles/$ComputeWrinkles** is used)
```
$model "my_cool_name" "my_cool_reference.dmx" IgnoreComputeWrinkles {
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" IgnoreComputeWrinkles

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" IgnoreComputeWrinkles
	//...
}
```

`IgnoreComputeDeltaNormals` - Disable compute delta normals on current model (if **-ComputeDeltaNormals/$ComputeDeltaNormals** is used)
```
$model "my_cool_name" "my_cool_reference.dmx" IgnoreComputeDeltaNormals {
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" IgnoreComputeDeltaNormals

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" IgnoreComputeDeltaNormals
	//...
}
```

`IgnoreComputeNormalsAndWrinkles` - Disable compute delta normals and wrinkles on current model (if **-ComputeWrinkles/$ComputeWrinkles** and **-ComputeDeltaNormals/$ComputeDeltaNormals** is used)
```
$model "my_cool_name" "my_cool_reference.dmx" IgnoreComputeNormalsAndWrinkles {
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" IgnoreComputeNormalsAndWrinkles

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" IgnoreComputeNormalsAndWrinkles
	//...
}
```

`NoAutoDMXRulesLegacy` - Delete all flex controllers
> Since `NoAutoDMXRules` used to do it exactly like that
```
$model "my_cool_name" "my_cool_reference.dmx" {
	//...
	
	NoAutoDMXRulesLegacy
	
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" {
	//...
	
	NoAutoDMXRulesLegacy
	
	//...
}

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" {
		//...
		
		NoAutoDMXRulesLegacy
		
		//...
	}
}
```

`BindToOneBone` - Overrides model weights to the first bone in vertex **(Experimental)**.
```
$model "my_cool_name" "my_cool_reference.dmx" BindToOneBone {
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" BindToOneBone

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" BindToOneBone
	//...
}
```

`RenameMatByPrefix <prefix>` - Adds a prefix to the material name. (TODO: Change command name)
```
$model "my_cool_name" "my_cool_reference.dmx" RenameMatByPrefix {
	//...
}

$body "my_cool_name" "my_cool_reference.dmx" RenameMatByPrefix

$bodygroup "my_cool_group"
{
	studio "my_cool_reference.dmx" RenameMatByPrefix
	//...
}
```

`RenameMat <source/target> <new_name>` - Creates a unique version of the reference and renames the material from source to target (Useful when we don't need to manually create a copy of the reference file with a different material name)
> *NOTE: Can be called multiple times in the same reference without any limitation. (Collisions may occur when trying to rename the same material in the same reference again)*

> **WARNING**: Be careful, if doing as in the example, don't forget about the total limit of groups (only if 32 groups with 2 models (*blank* also counts as a "model"), the more models in one group - the less groups can be created), otherwise... groups can cause unstable behavior in the engine!
```
$model "male_04" "male_04" renamemat "eric_facemap.bmp" "van_facemap.bmp" {
	// ...
}

$body "male_04" "male_04" renamemat "eric_facemap.bmp" "van_facemap.bmp"

$bodygroup "head_philips_cineos_screen" {
	studio "philips_cineos1_screen"
	studio "philips_cineos1_screen" renamemat "ekr2.bmp" "ekr1.bmp"
	studio "philips_cineos1_screen" renamemat "ekr2.bmp" "ekr3.bmp"
	studio "philips_cineos1_screen" renamemat "ekr2.bmp" "ekr4.bmp"
	studio "philips_cineos1_screen" renamemat "ekr2.bmp" "ekr5.bmp"
	studio "philips_cineos1_screen" renamemat "ekr2.bmp" "ekrcustom.bmp"
	// ...
	
	// example of renaming multiple materials
	studio "example_ref" renamemat "mat1.bmp" "mat_new1.bmp" renamemat "mat2.bmp" "mat_new2.bmp" // etc...
	
	// example collision (don't do that!)
	studio "example_ref" renamemat "mat1.bmp" "mat_new1.bmp" renamemat "mat1.bmp" "mat_new1.bmp"
}
```

`InvertControllers` - Works like the `-AddInvStudioFlexes/$AddInvStudioFlexes` command. It copy original flexes & inverts them with change controller range (-1 1) until toggled off.
> *NOTE: Complex rules may be unstable. Rules and flex controllers will also be inverted.*
```
	flexfile "your_vta_file.vta" {
		defaultflex frame 0
		
		InvertControllers			// Start inverting flexes
		flex Flex1 frame 1			// Creates inverted flex named "Flex1_Inv"
		flex Flex2 frame 2			// Creates inverted flex named "Flex2_Inv"
		flex Flex3 frame 3			// Creates inverted flex named "Flex3_Inv"
		InvertControllers			// Stop inverting flexes
		
		flex Flex4 frame 4			// Processed as normal, no inversion
		
		InvertControllers			// Start inverting flex pairs
		flexpair Flex5 1 frame 5	// Creates "Flex5_InvR" and "Flex5_InvL"
		flexpair Flex6 1 frame 6	// Creates "Flex6_InvR" and "Flex6_InvL" 
		InvertControllers			// Stop inverting flex pairs
		
		
		...
	}
```

`fscale <value>` - Increase flex to the specified value.
> `-DefaqScale/$DefaqScale` will be ignored for some flexes that use `fscale`
```
	flexfile "your_vta_file.vta" {
		defaultflex frame 0
		flex Flex1 frame 1 fscale 1.5 // scale flex to 150%
		flex Flex2 frame 2 fscale 2 // scale flex to 200%
		flex Flex3 frame 3 fscale 3 // scale flex to 300%
		...
	}
```

## Example to use features from $Model in $Body/$BodyGroup
> **Important notes**
>
> - **Avoid duplicating flex rules and flex controllers across references.**  
>   Flex controllers and rules should be declared **only once** and then reused.  
>   If a duplicate flex controller is encountered, the compiler will **warn**, **skip it**, and continue compiling.
>
> - **Always use unique eyeball names per reference.**  
>   When creating multiple references with eyes inside the same bodygroup, each `eyeball <eye_name>` must have a **unique name**.
>
> - **Eyelids must reference the correct eyeball defined earlier in the same reference.**  
>   The `eyelid ... eyeball <eye_name>` entry must point to the corresponding `eyeball <eye_name>` defined **before** it in the current reference.
>
> Failing to follow these rules may result in conflicts, missing flex behavior, or incorrect eye rendering when switching models within a bodygroup.
```
$body "my_cool_name" "my_cool_reference.smd" {
	// Same as $Model
}

$bodygroup "my_cool_group" {
	studio "my_cool_reference.smd" {
		eyeball righteye1 "ValveBiped.Bip01_Head1" -1.3598 -4.1039 67.4871 "dark_eyeball_r" 1 4 "pupil_r" 0.68
		eyeball lefteye1 "ValveBiped.Bip01_Head1" 1.3536 -4.1039 67.4791 "dark_eyeball_l" 1 -4 "pupil_l" 0.68
		
		eyelid  upper_right "male_01_expressions" lowerer 1 -0.166 neutral 0 0.1405 raiser 2 0.2104 split 0.1 eyeball righteye1
		eyelid  lower_right "male_01_expressions" lowerer 3 -0.3399 neutral 0 -0.256 raiser 4 -0.1001 split 0.1 eyeball righteye1
		eyelid  upper_left "male_01_expressions" lowerer 1 -0.166 neutral 0 0.1405 raiser 2 0.2104 split -0.1 eyeball lefteye1
		eyelid  lower_left "male_01_expressions" lowerer 3 -0.3399 neutral 0 -0.256 raiser 4 -0.1001 split -0.1 eyeball lefteye1

		// etc...
	}
	studio "my_cool_reference2.smd" {
		eyeball righteye2 "ValveBiped.Bip01_Head1" -1.2301 -3.7469 67.3623 "eyeball_r" 1 4 "pupil_r" 0.63
		eyeball lefteye2 "ValveBiped.Bip01_Head1" 1.4201 -3.7469 67.3391 "eyeball_l" 1 -4 "pupil_l" 0.63
		
		eyelid  upper_right "male_02_expressions" lowerer 1 -0.245 neutral 0 0.1689 raiser 2 0.2489 split 0.1 eyeball righteye2
		eyelid  lower_right "male_02_expressions" lowerer 3 -0.2747 neutral 0 -0.216 raiser 4 -0.0309 split 0.1 eyeball righteye2
		eyelid  upper_left "male_02_expressions" lowerer 1 -0.245 neutral 0 0.1689 raiser 2 0.2489 split -0.1 eyeball lefteye2
		eyelid  lower_left "male_02_expressions" lowerer 3 -0.2747 neutral 0 -0.216 raiser 4 -0.0309 split -0.1 eyeball lefteye2

		// etc...
	}
}
```