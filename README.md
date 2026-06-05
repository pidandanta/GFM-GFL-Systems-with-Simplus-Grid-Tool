# GFM-GFL Systems with Simplus Grid Tool

This repository provides modified power-system test cases for studying
grid-forming (GFM) and grid-following (GFL) inverter configurations in
MATLAB/Simulink. The models are built on top of the open-source
[Simplus Grid Tool](https://github.com/Future-Power-Networks/Simplus-Grid-Tool)
and keep the original toolbox structure so that the cases can be opened,
compiled, and simulated with the standard SimplusGT workflow.

The repository is intended as a reproducible model library for mixed
synchronous-generator and inverter-based-resource systems, including modified
14-bus, 39-bus, 68-bus, and 9-bus cases.

## Repository Contents

- `modified_14bus_shan/`: modified IEEE 14-bus inverter-based cases.
- `modified_39bus_shan/`: modified IEEE 39-bus GFM/GFL penetration and siting
  cases.
- `modified_68bus_shan/`: modified NETS/NYPS 68-bus mixed SG+IBR cases,
  including generated Simulink models, workspace data, Excel inputs, and a
  dedicated README.
- `modified_9bus_shan/`: modified WSCC 9-bus cases.
- `+SimplusGT/`, `App/`, `Documentations/`, `Examples/`, and `Library/`:
  Simplus Grid Tool files required to run the modified cases.

## Requirements

- MATLAB R2020a or later
- Simulink
- Simscape Electrical / Specialized Power Systems
- Python 3 with `openpyxl` for optional Excel scenario-generation scripts

## Quick Start

1. Clone or download this repository.
2. Open MATLAB and set the repository root as the working directory.
3. Install the SimplusGT path:

```matlab
InstallSimplusGT
```

4. Open a modified case folder. For example:

```matlab
cd modified_68bus_shan
load Data_NETS_68Bus_GFM_80pct.mat
open_system('Model_NETS_68Bus_GFM_80pct')
```

5. Run the Simulink model from the model window or from MATLAB:

```matlab
sim('Model_NETS_68Bus_GFM_80pct')
```

For the 68-bus system, see
[`modified_68bus_shan/README.md`](modified_68bus_shan/README.md) for the
available scenarios and regeneration workflow.

## Notes

- Each generated Simulink model should be used together with its matching
  `Data_*.mat` workspace file.
- The `.xlsx` files are the main editable system input files. The `.json` files
  are generated input files used by Simplus Grid Tool.
- Some MATLAB warnings may appear when opening generated models because of
  Simulink version or mask-display compatibility. Check the solver status and
  output variables to confirm whether the simulation finished successfully.

## Based On

This repository is based on Simplus Grid Tool:

```text
https://github.com/Future-Power-Networks/Simplus-Grid-Tool
```

If you use the underlying toolbox, please follow the citation guidance from the
original Simplus Grid Tool project.
