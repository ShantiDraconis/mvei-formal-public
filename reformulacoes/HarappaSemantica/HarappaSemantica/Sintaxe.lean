/-
  HarappaSemantica/Sintaxe.lean — as 55 cadeias `L####` de harappan-00-universal (`INDUS-KERNEL-CORE/formal/lean/`)
  contra a matriz de adjacência do autor (MVEI; não é arquivo do autor).

  ESTA NÃO É A GRAMÁTICA OPERACIONAL: ela está formalizada em `Compilador.lean` (o `compile_sentence` do autor), onde
  30 sentenças são válidas e 25 têm operação não resolvida. A matriz `analysis/connectivity_matrix.json` sai de
  `analyze_connectivity` em `build_indus_kernel.py`, que guarda só os 50 pares mais frequentes das 55 linhas
  (`sorted(...)[:50]`). Um par fora dela não é proibido: só ficou abaixo do corte.

  O que se prova aqui, sobre os dados (glifo `G###` ↦ `###`; um elemento que não é glifo ↦ `0`):
  * 29 cadeias têm todos os elementos no inventário `data/glyphs_417.json` e todos os pares vizinhos no top 50;
  * a L1030 tem o par `G401 → G201`, que não está no top 50 (e compila normalmente: `Compilador.L1030_compila`);
  * em 25 arquivos a cadeia é `["Gujarat"]`, um nome de sítio no lugar dos glifos (igual em
    `data/compiled_first_batch.json` e `data/lines_1001_8302.csv`).
-/

namespace HarappaSemantica.Sintaxe

/-- `adjacency_matrix` do autor: os 50 pares mais frequentes (glifo, glifo seguinte, contagem). -/
def adjacencia : List (Nat × Nat × Nat) :=
  [(161, 31, 6), (1, 1, 5), (201, 161, 5), (201, 31, 3), (31, 161, 3), (1, 2, 3),
   (291, 161, 3), (161, 201, 3), (31, 1, 3), (161, 291, 2), (2, 3, 2), (131, 161, 2),
   (381, 201, 2), (61, 31, 2), (251, 161, 2), (31, 291, 2), (1, 11, 2), (291, 31, 2),
   (201, 381, 2), (16, 16, 2), (1, 20, 1), (20, 16, 1), (16, 41, 1), (3, 4, 1),
   (4, 5, 1), (251, 31, 1), (321, 291, 1), (1, 16, 1), (16, 201, 1), (101, 381, 1),
   (201, 201, 1), (11, 16, 1), (16, 31, 1), (401, 31, 1), (31, 201, 1), (321, 131, 1),
   (291, 291, 1), (381, 101, 1), (101, 131, 1), (61, 61, 1), (251, 251, 1), (131, 131, 1),
   (131, 201, 1), (16, 11, 1), (321, 161, 1), (101, 201, 1), (61, 161, 1), (201, 131, 1),
   (251, 291, 1), (3, 11, 1)]

/-- Glifo do inventário `glyphs_417.json`. -/
def ehGlifo (n : Nat) : Bool := 1 ≤ n && n ≤ 417

def permitido (a b : Nat) : Bool := adjacencia.any fun p => p.1 == a && p.2.1 == b

def paresPermitidos : List Nat → Bool
  | a :: b :: r => permitido a b && paresPermitidos (b :: r)
  | _ => true

def noTop50 (c : List Nat) : Bool := c.all ehGlifo && paresPermitidos c

/-- `L####_glyph_chain` de cada `formal/lean/L####.lean` (0 = `"Gujarat"`). -/
def cadeias : List (Nat × List Nat) :=
  [(1001, [1, 20, 16, 41]),
   (1002, [201, 31, 161, 291]),
   (1003, [1, 2, 3, 4, 5]),
   (1004, [251, 31, 161]),
   (1005, [321, 291, 161, 31]),
   (1006, [1, 1, 1, 16, 201]),
   (1007, [131, 161, 201, 31]),
   (1008, [101, 381, 201]),
   (1009, [61, 31, 1, 2]),
   (1010, [251, 161, 31, 291]),
   (1011, [201, 201, 161, 31]),
   (1012, [1, 11, 16, 31]),
   (1013, [291, 161, 201]),
   (1014, [401, 31, 201, 161]),
   (1015, [321, 131, 161]),
   (1016, [1, 1, 1, 1, 11]),
   (1017, [291, 291, 31, 1]),
   (1018, [201, 381, 101, 131]),
   (1019, [61, 61, 31, 161]),
   (1020, [251, 251, 161, 31]),
   (1021, [131, 131, 201, 381]),
   (1022, [16, 16, 16, 11]),
   (1023, [201, 161, 291, 31]),
   (1024, [321, 161, 31, 1]),
   (1025, [101, 201, 161]),
   (1026, [61, 161, 201, 31]),
   (1027, [381, 201, 131]),
   (1028, [251, 291, 161]),
   (1029, [1, 2, 3, 11]),
   (1030, [401, 201, 161, 31, 291]),
   (1035, [0]),
   (1037, [0]),
   (1042, [0]),
   (1043, [0]),
   (1050, [0]),
   (1051, [0]),
   (1059, [0]),
   (1060, [0]),
   (1066, [0]),
   (1068, [0]),
   (1073, [0]),
   (1077, [0]),
   (1081, [0]),
   (1086, [0]),
   (1089, [0]),
   (1093, [0]),
   (1096, [0]),
   (1101, [0]),
   (1104, [0]),
   (1109, [0]),
   (1112, [0]),
   (1118, [0]),
   (1121, [0]),
   (1126, [0]),
   (1129, [0])]

theorem matriz_conta : adjacencia.length = 50 ∧ (adjacencia.map (·.2.2)).sum = 86 := by decide

theorem cadeias_conta : cadeias.length = 55 ∧ (cadeias.filter fun c => noTop50 c.2).length = 29 := by decide

/-- As 26 cadeias fora do top 50: a L1030 (um par abaixo do corte) e as 25 cuja cadeia é `["Gujarat"]`. -/
theorem fora_do_top50 :
    (cadeias.filter fun c => !noTop50 c.2).map (·.1) = [1030, 1035, 1037, 1042, 1043, 1050, 1051, 1059, 1060, 1066, 1068, 1073, 1077, 1081, 1086, 1089, 1093, 1096, 1101, 1104, 1109, 1112, 1118, 1121, 1126, 1129] := by decide

theorem sem_glifos : (cadeias.filter fun c => c.2 = [0]).map (·.1) = [1035, 1037, 1042, 1043, 1050, 1051, 1059, 1060, 1066, 1068, 1073, 1077, 1081, 1086, 1089, 1093, 1096, 1101, 1104, 1109, 1112, 1118, 1121, 1126, 1129] := by decide

/-- O par da L1030 que ficou abaixo do corte dos 50 mais frequentes. -/
theorem L1030_par_fora : permitido 401 201 = false := by decide

theorem L1001_pares_no_top50 : noTop50 [1, 20, 16, 41] = true := by decide
theorem L1002_pares_no_top50 : noTop50 [201, 31, 161, 291] = true := by decide
theorem L1003_pares_no_top50 : noTop50 [1, 2, 3, 4, 5] = true := by decide
theorem L1004_pares_no_top50 : noTop50 [251, 31, 161] = true := by decide
theorem L1005_pares_no_top50 : noTop50 [321, 291, 161, 31] = true := by decide
theorem L1006_pares_no_top50 : noTop50 [1, 1, 1, 16, 201] = true := by decide
theorem L1007_pares_no_top50 : noTop50 [131, 161, 201, 31] = true := by decide
theorem L1008_pares_no_top50 : noTop50 [101, 381, 201] = true := by decide
theorem L1009_pares_no_top50 : noTop50 [61, 31, 1, 2] = true := by decide
theorem L1010_pares_no_top50 : noTop50 [251, 161, 31, 291] = true := by decide
theorem L1011_pares_no_top50 : noTop50 [201, 201, 161, 31] = true := by decide
theorem L1012_pares_no_top50 : noTop50 [1, 11, 16, 31] = true := by decide
theorem L1013_pares_no_top50 : noTop50 [291, 161, 201] = true := by decide
theorem L1014_pares_no_top50 : noTop50 [401, 31, 201, 161] = true := by decide
theorem L1015_pares_no_top50 : noTop50 [321, 131, 161] = true := by decide
theorem L1016_pares_no_top50 : noTop50 [1, 1, 1, 1, 11] = true := by decide
theorem L1017_pares_no_top50 : noTop50 [291, 291, 31, 1] = true := by decide
theorem L1018_pares_no_top50 : noTop50 [201, 381, 101, 131] = true := by decide
theorem L1019_pares_no_top50 : noTop50 [61, 61, 31, 161] = true := by decide
theorem L1020_pares_no_top50 : noTop50 [251, 251, 161, 31] = true := by decide
theorem L1021_pares_no_top50 : noTop50 [131, 131, 201, 381] = true := by decide
theorem L1022_pares_no_top50 : noTop50 [16, 16, 16, 11] = true := by decide
theorem L1023_pares_no_top50 : noTop50 [201, 161, 291, 31] = true := by decide
theorem L1024_pares_no_top50 : noTop50 [321, 161, 31, 1] = true := by decide
theorem L1025_pares_no_top50 : noTop50 [101, 201, 161] = true := by decide
theorem L1026_pares_no_top50 : noTop50 [61, 161, 201, 31] = true := by decide
theorem L1027_pares_no_top50 : noTop50 [381, 201, 131] = true := by decide
theorem L1028_pares_no_top50 : noTop50 [251, 291, 161] = true := by decide
theorem L1029_pares_no_top50 : noTop50 [1, 2, 3, 11] = true := by decide
theorem L1030_par_fora_do_top50 : noTop50 [401, 201, 161, 31, 291] = false := by decide
theorem L1035_sem_glifos : noTop50 [0] = false := by decide
theorem L1037_sem_glifos : noTop50 [0] = false := by decide
theorem L1042_sem_glifos : noTop50 [0] = false := by decide
theorem L1043_sem_glifos : noTop50 [0] = false := by decide
theorem L1050_sem_glifos : noTop50 [0] = false := by decide
theorem L1051_sem_glifos : noTop50 [0] = false := by decide
theorem L1059_sem_glifos : noTop50 [0] = false := by decide
theorem L1060_sem_glifos : noTop50 [0] = false := by decide
theorem L1066_sem_glifos : noTop50 [0] = false := by decide
theorem L1068_sem_glifos : noTop50 [0] = false := by decide
theorem L1073_sem_glifos : noTop50 [0] = false := by decide
theorem L1077_sem_glifos : noTop50 [0] = false := by decide
theorem L1081_sem_glifos : noTop50 [0] = false := by decide
theorem L1086_sem_glifos : noTop50 [0] = false := by decide
theorem L1089_sem_glifos : noTop50 [0] = false := by decide
theorem L1093_sem_glifos : noTop50 [0] = false := by decide
theorem L1096_sem_glifos : noTop50 [0] = false := by decide
theorem L1101_sem_glifos : noTop50 [0] = false := by decide
theorem L1104_sem_glifos : noTop50 [0] = false := by decide
theorem L1109_sem_glifos : noTop50 [0] = false := by decide
theorem L1112_sem_glifos : noTop50 [0] = false := by decide
theorem L1118_sem_glifos : noTop50 [0] = false := by decide
theorem L1121_sem_glifos : noTop50 [0] = false := by decide
theorem L1126_sem_glifos : noTop50 [0] = false := by decide
theorem L1129_sem_glifos : noTop50 [0] = false := by decide

end HarappaSemantica.Sintaxe
