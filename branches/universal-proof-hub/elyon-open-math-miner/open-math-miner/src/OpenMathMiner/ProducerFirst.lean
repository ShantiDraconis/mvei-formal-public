namespace OpenMathMiner

/-- Producer-first representation of an open obligation. -/
structure ProducerTarget where
  D : Type
  W : Type
  Valid : W → Prop
  Endpoint : Prop
  producer : D → W
  verifies : ∀ d : D, Valid (producer d)
  closes : ∀ w : W, Valid w → Endpoint

theorem close_from_producer (T : ProducerTarget) (d : T.D) : T.Endpoint :=
  T.closes (T.producer d) (T.verifies d)

def ProducerGap (D W : Type) : Type := D → W

end OpenMathMiner
