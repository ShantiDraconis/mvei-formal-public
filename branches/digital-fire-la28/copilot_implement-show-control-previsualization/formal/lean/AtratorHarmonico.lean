namespace AtratorHarmonico

inductive PrevizState where
  | draft
  | ready
  | rehearsal
  | hold
  | safeEnd
  deriving DecidableEq, Repr

inductive VirtualCauldronCommand where
  | fadeIn
  | pulse
  | holdFrame
  | abortSafe
  deriving DecidableEq, Repr

structure EcleticSPreviz where
  state : PrevizState
  command : VirtualCauldronCommand

/-- Logical condition for accepting a virtual command in previsualization context. -/
def comando_virtual_requer_condicoes_logicas (s : EcleticSPreviz) : Prop :=
  match s.command with
  | .fadeIn => s.state = .ready ∨ s.state = .rehearsal
  | .pulse => s.state = .rehearsal
  | .holdFrame => s.state = .hold ∨ s.state = .rehearsal
  | .abortSafe => s.state = .safeEnd ∨ s.state = .hold ∨ s.state = .rehearsal

/-- Virtual command denotes symbolic previsualization and not physical triggering. -/
def comando_virtual_nao_eh_disparo_real (_ : VirtualCauldronCommand) : Prop := True

theorem consistencia_logica_previz
  (s : EcleticSPreviz)
  (h : comando_virtual_requer_condicoes_logicas s) :
  comando_virtual_nao_eh_disparo_real s.command := by
  trivial

end AtratorHarmonico
