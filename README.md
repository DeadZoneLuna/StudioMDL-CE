# StudioMDL-CE
###### Another version of StudioMDL (lol) for the community (more for SFM, Based on the CS:GO Partner Branch)

# Install
The **"game"** folder should be moved to a desired location. The path can then be configured in Crowbar (ex: X:\utils\game\bin\studiomdl.exe) or utilized manually without Crowbar, depending on preference.
**NOTE: Moving files from "game" into the game's folder (sfm for example) may cause crashes!**

## Features/Improvements
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

##### [Full Changelog](./changelog.md)