/-
  HarappaSemantica/Compilador.lean — a "operational grammar" de harappan-00-universal formalizada como o próprio autor
  a implementou (MVEI; não é arquivo do autor).

  Os 55 `L####_syntax_valid : True` de `INDUS-KERNEL-CORE/formal/lean/` propõem no comentário: "The sentence L#### is
  syntactically valid under the operational grammar". A gramática operacional (INTENT → OP → STATE → RESULT) é a
  função `compile_sentence` de `build_indus_kernel.py`: `classify_subject` (sujeito pelos dois primeiros glifos),
  `classify_verb` (operador dominante pela prioridade AUTH_EXEC, ACTION_EXEC, FLOW_TRANSFER, VALIDATION_SEAL,
  STORAGE_BUFFER, HARVEST_PRODUCE; senão o papel do segundo glifo; senão UNRESOLVED_OPERATION), `find_quantity`,
  `collect_modifiers` e `synthesize_predicate`. Aqui cada uma é traduzida linha a linha, com os papéis, permissões,
  nomes e vocalizações dos 20 glifos que aparecem nas cadeias, copiados de `data/glyphs_417.json`.

  O compilador aceita qualquer cadeia; a única falha é a operação não resolvida. "Sintaticamente válida" =
  o compilador resolve a operação. Resultado no kernel:
  * `compilador_reproduz_registro`: o compilador aplicado às 55 cadeias dá exatamente o que o autor gravou em
    `data/compiled_first_batch.json` (sujeito, verbo, quantidade, predicado, modificadores);
  * 30 sentenças válidas, inclusive a L1030;
  * 25 com operação não resolvida: a cadeia gravada é `["Gujarat"]`, um nome de sítio, que não é glifo do inventário.
  A matriz de adjacência de `analysis/connectivity_matrix.json` NÃO é a gramática: `analyze_connectivity` guarda só os
  50 pares mais frequentes (ver `Sintaxe.lean`).
-/

namespace HarappaSemantica.Compilador

/-- Ocorrência de `p` em `s` como substring (o `p in s` do Python). -/
def prefixoEm (p : List Char) : List Char → Bool
  | [] => p.isEmpty
  | c :: r => p.isPrefixOf (c :: r) || prefixoEm p r

def contem (p s : String) : Bool := prefixoEm p.toList s.toList

structure Glifo where
  id : String
  nameFunctional : String
  role : String
  permission : String
  vocalization : String
  deriving DecidableEq, Repr

/-- Os glifos de `data/glyphs_417.json` que aparecem nas 55 cadeias (cópia dos campos). -/
def glifos : List Glifo :=
  [⟨"G001", "NUM_TALLY_001", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G002", "NUM_TALLY_002", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G003", "NUM_TALLY_003", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G004", "NUM_TALLY_004", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G005", "NUM_TALLY_005", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G011", "NUM_TALLY_011", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G016", "NUM_TALLY_016", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G020", "NUM_TALLY_020", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G031", "NUM_TALLY_031", "QUANTITY_PARAM", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G041", "CONTAINER_041", "STORAGE_BUFFER", "PROTECTED_ACCESS", ""⟩,
   ⟨"G061", "CONTAINER_061", "STORAGE_BUFFER", "PROTECTED_ACCESS", ""⟩,
   ⟨"G101", "GRID_FIELD_101", "ALLOCATION_ZONE", "INSTITUTIONAL_CONTROL", ""⟩,
   ⟨"G131", "CIRCLE_CYCLE_131", "TEMPORAL_CYCLE", "PUBLIC_VISIBLE", ""⟩,
   ⟨"G161", "OPERATOR_TRIDENT_161", "ACTION_EXEC", "HIGH_AUTHORITY", ""⟩,
   ⟨"G201", "HUMAN_AGENT_201", "ACTOR_AGENT", "HIGH_AUTHORITY", ""⟩,
   ⟨"G251", "ANIMAL_NONFISH_251", "RESOURCE_ASSET", "INSTITUTIONAL_CONTROL", ""⟩,
   ⟨"G291", "PLANT_CROP_291", "HARVEST_PRODUCE", "INSTITUTIONAL_CONTROL", ""⟩,
   ⟨"G321", "ABSTRACT_LIGATURE_321", "RELATION_LINK", "PROTECTED_ACCESS", ""⟩,
   ⟨"G381", "ARCH_BUILDING_381", "STRUCTURE_SPACE", "INSTITUTIONAL_CONTROL", ""⟩,
   ⟨"G401", "MISC_RARE_401", "SPECIAL_UNIQUE", "HIGH_AUTHORITY", ""⟩]

/-- Os ids do inventário: G001 .. G417. -/
def pad3 (n : Nat) : String := if n < 10 then "00" ++ toString n else if n < 100 then "0" ++ toString n else toString n
def inventario : List String := (List.range 417).map fun i => "G" ++ pad3 (i + 1)

/-- `glyphs.get(gid)`: só os 20 glifos acima entram nas cadeias; um token fora do inventário dá `none`. -/
def buscar (gid : String) : Option Glifo := glifos.find? (·.id == gid)

def prioridade : List String :=
  ["AUTH_EXEC", "ACTION_EXEC", "FLOW_TRANSFER", "VALIDATION_SEAL", "STORAGE_BUFFER", "HARVEST_PRODUCE"]

/-- `classify_verb`. -/
def verbo (c : List String) : String :=
  match prioridade.find? (fun p => c.any fun gid => (buscar gid).any fun g => contem p g.role) with
  | some p => p
  | none =>
    match c with
    | _ :: b :: _ => match buscar b with
      | some g => g.role
      | none => "UNRESOLVED_OPERATION"
    | _ => "UNRESOLVED_OPERATION"

/-- `classify_subject`: os dois primeiros glifos, em ordem. -/
def sujeitoDe : List String → String
  | [] => "COLLECTIVE_ENTITY"
  | gid :: r => match buscar gid with
    | none => sujeitoDe r
    | some g =>
      if contem "HIGH_AUTHORITY" g.permission || contem "INSTITUTIONAL" g.permission then "INSTITUTIONAL_AUTHORITY"
      else if contem "AGENT" g.role || contem "ACTOR" g.role then "HUMAN_AGENT"
      else sujeitoDe r

def sujeito (c : List String) : String := sujeitoDe (c.take 2)

def romano : String → Option Nat
  | "I" => some 1 | "II" => some 2 | "III" => some 3 | "IV" => some 4 | "V" => some 5 | _ => none

def contagem (c : List String) : Nat :=
  (c.filter fun gid => (buscar gid).any fun g => contem "NUM_TALLY" g.nameFunctional).length

/-- `find_quantity`. -/
def quantidadeDe (c : List String) : List String → Option Nat
  | [] => none
  | gid :: r => match buscar gid with
    | none => quantidadeDe c r
    | some g =>
      if contem "QUANTITY" g.role || contem "NUM_TALLY" g.nameFunctional then
        match romano (String.mk (g.vocalization.toList.map Char.toUpper)) with
        | some n => some n
        | none => if contagem c > 0 then some (contagem c) else quantidadeDe c r
      else quantidadeDe c r

def quantidade (c : List String) : Option Nat := quantidadeDe c c

/-- `collect_modifiers`. -/
def modificadores (c : List String) : List (String × String) :=
  c.filterMap fun gid => (buscar gid).bind fun g =>
    if ["DIRECTION", "ORIENT", "TEMPORAL", "CYCLE", "RELATION", "LINK"].any (contem · (String.mk (g.role.toList.map Char.toUpper)))
    then some (g.role, gid) else none

/-- `synthesize_predicate`. -/
def predicado (v : String) : String :=
  if contem "SEAL" v || contem "VALIDATION" v then "VALIDATED_SEALED"
  else if contem "TRANSFER" v then "TRANSFERRED_COMMITTED"
  else if contem "AUTH_EXEC" v || contem "ACTION_EXEC" v then "EXECUTED_RECORDED"
  else if contem "HARVEST" v || contem "PRODUCE" v then "ACCUMULATED_STORED"
  else if contem "STORAGE" v || contem "BUFFER" v then "STORED_PROTECTED"
  else "STATE_MODIFIED"

structure Registro where
  sujeito : String
  verbo : String
  quantidade : Option Nat
  predicado : String
  modificadores : List (String × String)
  deriving DecidableEq, Repr

/-- `compile_sentence`. -/
def compila (c : List String) : Registro :=
  ⟨sujeito c, verbo c, quantidade c, predicado (verbo c), modificadores c⟩

/-- Sintaticamente válida na gramática operacional do autor: o compilador resolve a operação. -/
def sintaxeValida (c : List String) : Bool := verbo c != "UNRESOLVED_OPERATION"

/-- As 55 linhas: id, cadeia (de `formal/lean/L####.lean`, igual à de `compiled_first_batch.json`) e o registro que o
    autor gravou em `compiled_first_batch.json`. -/
def linhas : List (Nat × List String × Registro) :=
  [(1001, ["G001", "G020", "G016", "G041"], ⟨"COLLECTIVE_ENTITY", "STORAGE_BUFFER", some 3, "STORED_PROTECTED", []⟩),
   (1002, ["G201", "G031", "G161", "G291"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1003, ["G001", "G002", "G003", "G004", "G005"], ⟨"COLLECTIVE_ENTITY", "QUANTITY_PARAM", some 5, "STATE_MODIFIED", []⟩),
   (1004, ["G251", "G031", "G161"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1005, ["G321", "G291", "G161", "G031"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", [("RELATION_LINK", "G321")]⟩),
   (1006, ["G001", "G001", "G001", "G016", "G201"], ⟨"COLLECTIVE_ENTITY", "QUANTITY_PARAM", some 4, "STATE_MODIFIED", []⟩),
   (1007, ["G131", "G161", "G201", "G031"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", [("TEMPORAL_CYCLE", "G131")]⟩),
   (1008, ["G101", "G381", "G201"], ⟨"INSTITUTIONAL_AUTHORITY", "STRUCTURE_SPACE", none, "STATE_MODIFIED", []⟩),
   (1009, ["G061", "G031", "G001", "G002"], ⟨"COLLECTIVE_ENTITY", "STORAGE_BUFFER", some 3, "STORED_PROTECTED", []⟩),
   (1010, ["G251", "G161", "G031", "G291"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1011, ["G201", "G201", "G161", "G031"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1012, ["G001", "G011", "G016", "G031"], ⟨"COLLECTIVE_ENTITY", "QUANTITY_PARAM", some 4, "STATE_MODIFIED", []⟩),
   (1013, ["G291", "G161", "G201"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", none, "EXECUTED_RECORDED", []⟩),
   (1014, ["G401", "G031", "G201", "G161"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1015, ["G321", "G131", "G161"], ⟨"COLLECTIVE_ENTITY", "ACTION_EXEC", none, "EXECUTED_RECORDED", [("RELATION_LINK", "G321"), ("TEMPORAL_CYCLE", "G131")]⟩),
   (1016, ["G001", "G001", "G001", "G001", "G011"], ⟨"COLLECTIVE_ENTITY", "QUANTITY_PARAM", some 5, "STATE_MODIFIED", []⟩),
   (1017, ["G291", "G291", "G031", "G001"], ⟨"INSTITUTIONAL_AUTHORITY", "HARVEST_PRODUCE", some 2, "ACCUMULATED_STORED", []⟩),
   (1018, ["G201", "G381", "G101", "G131"], ⟨"INSTITUTIONAL_AUTHORITY", "STRUCTURE_SPACE", none, "STATE_MODIFIED", [("TEMPORAL_CYCLE", "G131")]⟩),
   (1019, ["G061", "G061", "G031", "G161"], ⟨"COLLECTIVE_ENTITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1020, ["G251", "G251", "G161", "G031"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1021, ["G131", "G131", "G201", "G381"], ⟨"COLLECTIVE_ENTITY", "TEMPORAL_CYCLE", none, "STATE_MODIFIED", [("TEMPORAL_CYCLE", "G131"), ("TEMPORAL_CYCLE", "G131")]⟩),
   (1022, ["G016", "G016", "G016", "G011"], ⟨"COLLECTIVE_ENTITY", "QUANTITY_PARAM", some 4, "STATE_MODIFIED", []⟩),
   (1023, ["G201", "G161", "G291", "G031"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1024, ["G321", "G161", "G031", "G001"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 2, "EXECUTED_RECORDED", [("RELATION_LINK", "G321")]⟩),
   (1025, ["G101", "G201", "G161"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", none, "EXECUTED_RECORDED", []⟩),
   (1026, ["G061", "G161", "G201", "G031"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1027, ["G381", "G201", "G131"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTOR_AGENT", none, "STATE_MODIFIED", [("TEMPORAL_CYCLE", "G131")]⟩),
   (1028, ["G251", "G291", "G161"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", none, "EXECUTED_RECORDED", []⟩),
   (1029, ["G001", "G002", "G003", "G011"], ⟨"COLLECTIVE_ENTITY", "QUANTITY_PARAM", some 4, "STATE_MODIFIED", []⟩),
   (1030, ["G401", "G201", "G161", "G031", "G291"], ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩),
   (1035, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1037, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1042, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1043, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1050, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1051, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1059, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1060, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1066, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1068, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1073, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1077, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1081, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1086, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1089, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1093, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1096, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1101, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1104, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1109, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1112, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1118, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1121, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1126, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩),
   (1129, ["Gujarat"], ⟨"COLLECTIVE_ENTITY", "UNRESOLVED_OPERATION", none, "STATE_MODIFIED", []⟩)]

set_option maxRecDepth 400000 in
theorem glifos_no_inventario : (glifos.all fun g => inventario.contains g.id) = true ∧
    inventario.contains "Gujarat" = false := by decide

set_option maxRecDepth 400000 in
/-- O compilador traduzido reproduz exatamente o que o autor gravou para as 55 linhas. -/
theorem compilador_reproduz_registro : (linhas.all fun l => compila l.2.1 == l.2.2) = true := by decide

set_option maxRecDepth 400000 in
theorem validas :
    (linhas.filter fun l => sintaxeValida l.2.1).map (·.1) = [1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028, 1029, 1030] := by decide

set_option maxRecDepth 400000 in
/-- As 25 com operação não resolvida são exatamente as de cadeia `["Gujarat"]`. -/
theorem nao_resolvidas :
    (linhas.filter fun l => !sintaxeValida l.2.1).map (·.1) = [1035, 1037, 1042, 1043, 1050, 1051, 1059, 1060, 1066, 1068, 1073, 1077, 1081, 1086, 1089, 1093, 1096, 1101, 1104, 1109, 1112, 1118, 1121, 1126, 1129] ∧
    (linhas.filter fun l => l.2.1 = ["Gujarat"]).map (·.1) = [1035, 1037, 1042, 1043, 1050, 1051, 1059, 1060, 1066, 1068, 1073, 1077, 1081, 1086, 1089, 1093, 1096, 1101, 1104, 1109, 1112, 1118, 1121, 1126, 1129] := by decide

/-- A L1030, que a leitura por adjacência rejeitava, compila: autoridade institucional executa e registra. -/
theorem L1030_compila : compila ["G401", "G201", "G161", "G031", "G291"] =
    ⟨"INSTITUTIONAL_AUTHORITY", "ACTION_EXEC", some 1, "EXECUTED_RECORDED", []⟩ := by decide

theorem L1001_syntax_valid : sintaxeValida ["G001", "G020", "G016", "G041"] = true := by decide
theorem L1002_syntax_valid : sintaxeValida ["G201", "G031", "G161", "G291"] = true := by decide
theorem L1003_syntax_valid : sintaxeValida ["G001", "G002", "G003", "G004", "G005"] = true := by decide
theorem L1004_syntax_valid : sintaxeValida ["G251", "G031", "G161"] = true := by decide
theorem L1005_syntax_valid : sintaxeValida ["G321", "G291", "G161", "G031"] = true := by decide
theorem L1006_syntax_valid : sintaxeValida ["G001", "G001", "G001", "G016", "G201"] = true := by decide
theorem L1007_syntax_valid : sintaxeValida ["G131", "G161", "G201", "G031"] = true := by decide
theorem L1008_syntax_valid : sintaxeValida ["G101", "G381", "G201"] = true := by decide
theorem L1009_syntax_valid : sintaxeValida ["G061", "G031", "G001", "G002"] = true := by decide
theorem L1010_syntax_valid : sintaxeValida ["G251", "G161", "G031", "G291"] = true := by decide
theorem L1011_syntax_valid : sintaxeValida ["G201", "G201", "G161", "G031"] = true := by decide
theorem L1012_syntax_valid : sintaxeValida ["G001", "G011", "G016", "G031"] = true := by decide
theorem L1013_syntax_valid : sintaxeValida ["G291", "G161", "G201"] = true := by decide
theorem L1014_syntax_valid : sintaxeValida ["G401", "G031", "G201", "G161"] = true := by decide
theorem L1015_syntax_valid : sintaxeValida ["G321", "G131", "G161"] = true := by decide
theorem L1016_syntax_valid : sintaxeValida ["G001", "G001", "G001", "G001", "G011"] = true := by decide
theorem L1017_syntax_valid : sintaxeValida ["G291", "G291", "G031", "G001"] = true := by decide
theorem L1018_syntax_valid : sintaxeValida ["G201", "G381", "G101", "G131"] = true := by decide
theorem L1019_syntax_valid : sintaxeValida ["G061", "G061", "G031", "G161"] = true := by decide
theorem L1020_syntax_valid : sintaxeValida ["G251", "G251", "G161", "G031"] = true := by decide
theorem L1021_syntax_valid : sintaxeValida ["G131", "G131", "G201", "G381"] = true := by decide
theorem L1022_syntax_valid : sintaxeValida ["G016", "G016", "G016", "G011"] = true := by decide
theorem L1023_syntax_valid : sintaxeValida ["G201", "G161", "G291", "G031"] = true := by decide
theorem L1024_syntax_valid : sintaxeValida ["G321", "G161", "G031", "G001"] = true := by decide
theorem L1025_syntax_valid : sintaxeValida ["G101", "G201", "G161"] = true := by decide
theorem L1026_syntax_valid : sintaxeValida ["G061", "G161", "G201", "G031"] = true := by decide
theorem L1027_syntax_valid : sintaxeValida ["G381", "G201", "G131"] = true := by decide
theorem L1028_syntax_valid : sintaxeValida ["G251", "G291", "G161"] = true := by decide
theorem L1029_syntax_valid : sintaxeValida ["G001", "G002", "G003", "G011"] = true := by decide
theorem L1030_syntax_valid : sintaxeValida ["G401", "G201", "G161", "G031", "G291"] = true := by decide
theorem L1035_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1037_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1042_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1043_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1050_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1051_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1059_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1060_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1066_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1068_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1073_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1077_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1081_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1086_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1089_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1093_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1096_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1101_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1104_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1109_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1112_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1118_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1121_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1126_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide
theorem L1129_operacao_nao_resolvida : sintaxeValida ["Gujarat"] = false := by decide

end HarappaSemantica.Compilador
