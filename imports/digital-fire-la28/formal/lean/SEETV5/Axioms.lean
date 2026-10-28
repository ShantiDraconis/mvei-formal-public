namespace SEETV5

inductive SystemState where
  | boot
  | calibration
  | idle
  | armed
  | running
  | braking
  | fault
  | shutdown
deriving DecidableEq, Repr

inductive SafetyState where
  | unsafe
  | safe
deriving DecidableEq, Repr

inductive FaultType where
  | overCurrent
  | underVoltage
  | overVoltage
  | hallTimeout
  | dmxLoss
  | overTemperature
  | invalidCommand
deriving DecidableEq, Repr

structure PowerInput where
  watts : Nat

structure PowerRecovered where
  watts : Nat

structure Efficiency where
  numerator : Nat
  denominator : Nat
  denominator_nonzero : denominator ≠ 0

structure DMXCommand where
  channel : Nat
  value : Nat

structure Pulse where
  id : Nat
  enabled : Bool

structure TelemetryRecord where
  pulseId : Nat
  inputWatts : Nat
  recoveredWatts : Nat

inductive ShowLifecycleStage where
  | boot
  | calibration
  | idle
  | armed
  | running
  | braking
  | fault
  | shutdown
deriving DecidableEq, Repr

def actuationAllowed (enable : Bool) (safety : SafetyState) : Prop :=
  enable = true ∧ safety = SafetyState.safe

def dissipative (input : PowerInput) (recovered : PowerRecovered) : Prop :=
  recovered.watts ≤ input.watts

end SEETV5
