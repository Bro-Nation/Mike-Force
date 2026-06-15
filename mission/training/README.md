# Training Server Guide

Important: content under `mission/training/` is training-only and does not ship in the non-training mission build.

## Training Server Detection

File: `mission/para_server_init.sqf`

```
vn_mf_is_training_server = isClass (missionConfigFile >> "CfgFunctions" >> "vn_mf" >> "training");
publicVariable "vn_mf_is_training_server";
```

## Basic Branch Example

```
if (vn_mf_is_training_server) then {
    // training behavior
} else {
    // live server behavior
};
```
