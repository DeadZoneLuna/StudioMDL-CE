# StudioMDL-CE
###### Another version of StudioMDL (lol) for the community (more for SFM, Based on the CS:GO Partner Branch)

# Install
The **"game"** folder should be moved to a desired location. The path can then be configured in Crowbar (ex: X:\utils\game\bin\studiomdl.exe) or utilized manually without Crowbar, depending on preference.
**NOTE: Moving files from "game" into the game's folder (sfm for example) may cause crashes!**

## Improvements
- Allow increase flexes by 10 times or by specified
- Increased file buffer size to **64 mb** for writing MDL, VTX, VVD.
- Improved compilation time when generating indices (re-sorting) by replace **nvtristrip** to **meshoptimizer** (nvtristrip can be reuse by using **$uselegacystripify/-uselegacystripify** commands).
- Large addresses are allowed (LARGEADDRESSAWARE) so that more complex models can be compiled **(e.g. a model with 1 million vertices)**.
- Changed logic of bones collapse, now when using **$alwayscollapse** - it will be collapsed always, even if this bone has weights on vertices.
- Slightly changed debugging information when cutting model into multiple models (Which model is in process and how many vertices it has).
- Increased flex rules operations from **512** to **2048**.
- **renamemat** now support DMX.

## Known issues
- **BUG** With some models when scaling (by **$scale**) to some larger values, may causes problems with the weights.
- **TODO** At the moment cutting a model into several only works with group 0 and model 0, the other groups and models may be missing some parts of the meshes!

##### [Full Changelog](./changelog.md)