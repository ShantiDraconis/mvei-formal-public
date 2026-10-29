/-
  O Maná (הַמָּן): A Matriz de Cristalização
  
  Versículo Chave (Êxodo 16:31):
  וַיִּקְרְאוּ בֵית-יִשְׂרָאֵל אֶת-שְׁמוֹ, מָן; וְהוּא, כְּזֶרַע גַּד לָבָן, וְטַעְמוֹ, כְּצַפִּיחִת בִּדְבָשׁ.
  
  "E a casa de Israel chamou seu nome Maná; e era como semente de coentro branco, 
   e o seu sabor como bolos de mel."
  
  Função Sistêmica: Sustento / Dado Sólido
  Processo Principal: Cristalização Térmica
-/

namespace MishkanIII.Chemistry.Mana

/-- Nome hebraico: מָן (Man) --/
def hebrew_name : String := "מָן"

/-- Pergunta fundamental: Man Hu? (O que é isto?) --/
def man_hu : String := "מָן הוּא"

/-- 
  Confecção Técnica do Maná
  Base: Exsudato de Acacia (Goma) + Manitol (Tamarix)
-/
structure ManaFormula where
  /-- Exsudato de Acacia (Goma) como base estrutural --/
  acacia_gum : ℝ
  
  /-- Manitol extraído de Tamarix --/
  manitol_tamarix : ℝ
  
  /-- Alcaloides de acácia em suspensão térmica --/
  acacia_alkaloids : ℝ
  
  /-- Temperatura de infusão (Celsius) --/
  temperature : ℝ
  
  /-- Tempo de evaporação rápida (minutos) --/
  evaporation_time : ℝ
  
  /-- Propriedade: Temperatura deve estar na faixa térmica adequada --/
  temp_valid : 60 ≤ temperature ∧ temperature ≤ 80
  
  /-- Propriedade: Componentes devem ser positivos --/
  components_positive : 0 < acacia_gum ∧ 0 < manitol_tamarix ∧ 0 < acacia_alkaloids

/-- 
  Processo de Cristalização Térmica
  Resultado: Precipitação por evaporação rápida (o efeito "geada")
-/
def thermal_crystallization (formula : ManaFormula) : String :=
  "Cristalização térmica a " ++ toString formula.temperature ++ "°C resultando em precipitação tipo geada"

/--
  Aparência Bíblica: Como semente de coentro branco
-/
def biblical_appearance : String := "כְּזֶרַע גַּד לָבָן"

/--
  Sabor Bíblico: Como bolos de mel
-/
def biblical_taste : String := "כְּצַפִּיחִת בִּדְבָשׁ"

/--
  Validação da fórmula do Maná conforme as Leis da Natureza
-/
theorem mana_is_valid (formula : ManaFormula) : 
  (60 ≤ formula.temperature ∧ formula.temperature ≤ 80) ∧ 
  (0 < formula.acacia_gum ∧ 0 < formula.manitol_tamarix ∧ 0 < formula.acacia_alkaloids) := by
  constructor
  · exact formula.temp_valid
  · exact formula.components_positive

end MishkanIII.Chemistry.Mana
