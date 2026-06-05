# Modified NETS/NYPS 68-Bus Mixed-Source Testbed

This folder contains a modified NETS/NYPS 68-bus test system built with
[Simplus Grid Tool](https://github.com/Future-Power-Networks/Simplus-Grid-Tool).
It is intended for Simulink validation of mixed synchronous-generator,
grid-forming inverter, and grid-following inverter configurations.

The files are organized so that a reader can either run the provided Simulink
models directly or regenerate the models from the Excel input files.

## Requirements

- MATLAB R2020a or later
- Simulink
- Simscape Electrical / Specialized Power Systems
- Simplus Grid Tool installed by running `InstallSimplusGT.m` from the toolbox
  root directory
- Python 3 with `openpyxl`, only if the Excel scenario-generation scripts are
  used

## Test-System Description

The base input file is:

- `NETS_NYPS_68Bus.xlsx`

The modified system keeps buses 13--16 as synchronous-generator backbone buses.
The internal generation buses 1--12 are used for inverter siting studies:

- GFM inverter: apparatus type `20`
- GFL inverter: apparatus type `11`
- Synchronous generator: apparatus type `0`

The JSON files are converted versions of the Excel input files and are used by
Simplus Grid Tool during model generation.

## Provided Scenarios

### GFM-Penetration Scenarios

| Scenario | Excel input | Simulink model | Workspace data |
| --- | --- | --- | --- |
| 20% GFM | `NETS_68Bus_GFM_20pct.xlsx` | `Model_NETS_68Bus_GFM_20pct.slx` | `Data_NETS_68Bus_GFM_20pct.mat` |
| 40% GFM | `NETS_68Bus_GFM_40pct.xlsx` | `Model_NETS_68Bus_GFM_40pct.slx` | `Data_NETS_68Bus_GFM_40pct.mat` |
| 50% GFM | `NETS_68Bus_GFM_50pct.xlsx` | `Model_NETS_68Bus_GFM_50pct.slx` | `Data_NETS_68Bus_GFM_50pct.mat` |
| 60% GFM | `NETS_68Bus_GFM_60pct.xlsx` | `Model_NETS_68Bus_GFM_60pct.slx` | `Data_NETS_68Bus_GFM_60pct.mat` |
| 80% GFM | `NETS_68Bus_GFM_80pct.xlsx` | `Model_NETS_68Bus_GFM_80pct.slx` | `Data_NETS_68Bus_GFM_80pct.mat` |

### GFM-Siting Schemes

These three cases compare different placements of three additional GFM units.
The base GFM buses are 1, 2, 3, and 4.

| Scheme | Additional GFM buses | Excel input | Simulink model |
| --- | --- | --- | --- |
| Uniform | 6, 10, 12 | `NETS_68Bus_Scheme1_Uniform.xlsx` | `Model_NETS_68Bus_Scheme1_Uniform.slx` |
| Hsys-guided | 10, 11, 12 | `NETS_68Bus_Scheme2_Hsys.xlsx` | `Model_NETS_68Bus_Scheme2_Hsys.slx` |
| gCSR-guided | 7, 8, 9 | `NETS_68Bus_Scheme3_gCSR.xlsx` | `Model_NETS_68Bus_Scheme3_gCSR.slx` |

## Quick Start: Run an Existing Model

1. Start MATLAB.
2. Go to the Simplus Grid Tool root directory.
3. Run the installer once if needed:

```matlab
InstallSimplusGT
```

4. Go to this folder:

```matlab
cd modified_68bus_shan
```

5. Load the workspace data and open the corresponding Simulink model. For
   example, to run the 80% GFM case:

```matlab
load Data_NETS_68Bus_GFM_80pct.mat
open_system('Model_NETS_68Bus_GFM_80pct')
```

6. Click **Run** in Simulink, or start the simulation from MATLAB:

```matlab
sim('Model_NETS_68Bus_GFM_80pct')
```

The helper script `QuickStart_Simulation_68bus.m` performs the same loading and
model-opening steps. Edit the variable `Pct` in that script to choose one of
`20`, `40`, `50`, `60`, or `80`.

## Regenerate the GFM-Penetration Models

From the Simplus Grid Tool root directory, run:

```matlab
UserMain_Shan_bus68
```

This script calls `SimplusGT.Toolbox.Main()` for each penetration scenario and
saves:

- `Model_NETS_68Bus_GFM_*pct.slx`
- `Data_NETS_68Bus_GFM_*pct.mat`

## Regenerate the Three Siting-Scheme Models

First generate the Excel inputs:

```bash
python modified_68bus_shan/generate_schemes.py
```

Then, from MATLAB, run:

```matlab
cd modified_68bus_shan
generate_3schemes
```

The script compiles the three Excel inputs with Simplus Grid Tool and saves the
corresponding Simulink models and workspace-data files.

## Common Warnings

When opening or running the generated Simulink models, MATLAB may report
warnings such as deprecated System object mixins or transformer `MaskDisplay`
messages. These warnings are usually related to toolbox or Simulink block-display
compatibility. Check the simulation output variables and solver status to confirm
whether a run finished successfully.

## Reproducibility Notes

- Keep each `.slx` file paired with its matching `Data_*.mat` file.
- If a model is regenerated, reload the newly saved `Data_*.mat` file before
  running the Simulink model.
- Large descriptor/state-space variables can consume substantial memory. Close
  unused Simulink models between batch runs.
- The generated `.json` files are intermediate Simplus Grid Tool input files.
  If an Excel file is modified, regenerate the JSON/model pair before using the
  case for validation.

## Citation

This testbed is based on Simplus Grid Tool. If you use these files, please cite
the original toolbox as requested by its authors:

```text
github.com/Future-Power-Networks/Simplus-Grid-Tool
```
