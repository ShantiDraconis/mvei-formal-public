import SEETV5.Axioms

namespace SEETV5

def TelemetryForPulse (p : Pulse) (t : TelemetryRecord) : Prop :=
  t.pulseId = p.id

theorem telemetry_required_for_pulse
  (p : Pulse)
  (t : TelemetryRecord)
  (h : TelemetryForPulse p t) :
  t.pulseId = p.id := h

end SEETV5
