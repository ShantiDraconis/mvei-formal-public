/-
  HLG - Local-Global Hypothesis Framework
  
  Main module that imports all HLG sub-modules.
-/

import HLG.Framework
import HLG.RH_LocalGlobal
import HLG.NS_LocalGlobal

/-!
# Local-Global Hypothesis Framework

This module provides the complete formalization of the Local-Global Hypothesis (HLG)
which unifies the Millennium Problems through a common framework.

## Key Components

* `HLG.Framework` - Core definitions: Framework, HasBridge, LocalGlobalHypothesis
* `HLG.RH_LocalGlobal` - Riemann Hypothesis specific framework
* `HLG.NS_LocalGlobal` - Navier-Stokes specific framework

## Main Theorem

For each Millennium Problem Cᵢ with framework Fᵢ:
  Cᵢ  ⟺  HasBridge Fᵢ
-/
