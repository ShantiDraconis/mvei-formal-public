/-
  Dados.lean — reformulacoes/SemanticaMishkan (MVEI; NÃO é do autor). Gerado por tools/semantica_mishkan.py a partir do
  mesmo texto da camada de nomes de mishkan-iii-core (core/MveiEstrutura/Mishkan.lean).

  O que os números do próprio autor decidem, sem nenhuma hipótese. As datas modernas são as que as 600 provas
  `precedence_N` do gerador gravam (h2 : m.date = …); as datas dos sinais, −2600 + N (h1); os pares de
  `absolute_precedence_N` são os `carbon14_date_N` e `modern_publication_N` de MILLENNIUM_SOLUTIONS.
-/
import SemanticaMishkan.Catalogo

set_option autoImplicit false

namespace MveiSemantica.Mishkan

/-! ## Datas do gerador (FORMAL_VERIFICATIONS) -/

/-- Data moderna do conceito N (N = 1 … 600), como as provas `precedence_N` gravam. -/
def modernDates : List Int := [1601, 1602, 1603, 1604, 1605, 1606, 1607, 1608, 1609, 1610, 1611, 1612, 1613, 1614, 1615, 1616, 1617, 1618, 1619, 1620, 1621, 1622, 1623, 1624, 1625, 1626, 1627, 1628, 1629, 1630, 1631, 1632, 1633, 1634, 1635, 1636, 1637, 1638, 1639, 1640, 1641, 1642, 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, 1653, 1654, 1655, 1656, 1657, 1658, 1659, 1660, 1661, 1662, 1663, 1664, 1665, 1666, 1667, 1668, 1669, 1670, 1671, 1672, 1673, 1674, 1675, 1676, 1677, 1678, 1679, 1680, 1681, 1682, 1683, 1684, 1685, 1686, 1687, 1688, 1689, 1690, 1691, 1692, 1693, 1694, 1695, 1696, 1697, 1698, 1699, 1700, 1701, 1702, 1703, 1704, 1705, 1706, 1707, 1708, 1709, 1710, 1711, 1712, 1713, 1714, 1715, 1716, 1717, 1718, 1719, 1720, 1721, 1722, 1723, 1724, 1725, 1726, 1727, 1728, 1729, 1730, 1731, 1732, 1733, 1734, 1735, 1736, 1737, 1738, 1739, 1740, 1741, 1742, 1743, 1744, 1745, 1746, 1747, 1748, 1749, 1750, 1751, 1752, 1753, 1754, 1755, 1756, 1757, 1758, 1759, 1760, 1761, 1762, 1763, 1764, 1765, 1766, 1767, 1768, 1769, 1770, 1771, 1772, 1773, 1774, 1775, 1776, 1777, 1778, 1779, 1780, 1781, 1782, 1783, 1784, 1785, 1786, 1787, 1788, 1789, 1790, 1791, 1792, 1793, 1794, 1795, 1796, 1797, 1798, 1799, 1800, 1801, 1802, 1803, 1804, 1805, 1806, 1807, 1808, 1809, 1810, 1811, 1812, 1813, 1814, 1815, 1816, 1817, 1818, 1819, 1820, 1821, 1822, 1823, 1824, 1825, 1826, 1827, 1828, 1829, 1830, 1831, 1832, 1833, 1834, 1835, 1836, 1837, 1838, 1839, 1840, 1841, 1842, 1843, 1844, 1845, 1846, 1847, 1848, 1849, 1850, 1851, 1852, 1853, 1854, 1855, 1856, 1857, 1858, 1859, 1860, 1861, 1862, 1863, 1864, 1865, 1866, 1867, 1868, 1869, 1870, 1871, 1872, 1873, 1874, 1875, 1876, 1877, 1878, 1879, 1880, 1881, 1882, 1883, 1884, 1885, 1886, 1887, 1888, 1889, 1890, 1891, 1892, 1893, 1894, 1895, 1896, 1897, 1898, 1899, 1900, 1901, 1902, 1903, 1904, 1905, 1906, 1907, 1908, 1909, 1910, 1911, 1912, 1913, 1914, 1915, 1916, 1917, 1918, 1919, 1920, 1921, 1922, 1923, 1924, 1925, 1926, 1927, 1928, 1929, 1930, 1931, 1932, 1933, 1934, 1935, 1936, 1937, 1938, 1939, 1940, 1941, 1942, 1943, 1944, 1945, 1946, 1947, 1948, 1949, 1950, 1951, 1952, 1953, 1954, 1955, 1956, 1957, 1958, 1959, 1960, 1961, 1962, 1963, 1964, 1965, 1966, 1967, 1968, 1969, 1970, 1971, 1972, 1973, 1974, 1975, 1976, 1977, 1978, 1979, 1980, 1981, 1982, 1983, 1984, 1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 1600, 1601, 1602, 1603, 1604, 1605, 1606, 1607, 1608, 1609, 1610, 1611, 1612, 1613, 1614, 1615, 1616, 1617, 1618, 1619, 1620, 1621, 1622, 1623, 1624, 1625, 1626, 1627, 1628, 1629, 1630, 1631, 1632, 1633, 1634, 1635, 1636, 1637, 1638, 1639, 1640, 1641, 1642, 1643, 1644, 1645, 1646, 1647, 1648, 1649, 1650, 1651, 1652, 1653, 1654, 1655, 1656, 1657, 1658, 1659, 1660, 1661, 1662, 1663, 1664, 1665, 1666, 1667, 1668, 1669, 1670, 1671, 1672, 1673, 1674, 1675, 1676, 1677, 1678, 1679, 1680, 1681, 1682, 1683, 1684, 1685, 1686, 1687, 1688, 1689, 1690, 1691, 1692, 1693, 1694, 1695, 1696, 1697, 1698, 1699, 1700, 1701, 1702, 1703, 1704, 1705, 1706, 1707, 1708, 1709, 1710, 1711, 1712, 1713, 1714, 1715, 1716, 1717, 1718, 1719, 1720, 1721, 1722, 1723, 1724, 1725, 1726, 1727, 1728, 1729, 1730, 1731, 1732, 1733, 1734, 1735, 1736, 1737, 1738, 1739, 1740, 1741, 1742, 1743, 1744, 1745, 1746, 1747, 1748, 1749, 1750, 1751, 1752, 1753, 1754, 1755, 1756, 1757, 1758, 1759, 1760, 1761, 1762, 1763, 1764, 1765, 1766, 1767, 1768, 1769, 1770, 1771, 1772, 1773, 1774, 1775]

def dataModerna (n : Nat) : Int := modernDates.getD (n - 1) 0

/-- Data do sinal N, como as provas `precedence_N` gravam. -/
def dataSinal (n : Nat) : Int := -2600 + n

/-- As 600 precedências valem nos dados do gerador: o sinal N é anterior ao conceito N. -/
theorem precedencias_do_gerador : ∀ n < 601, 1 ≤ n → dataSinal n < dataModerna n := by decide +kernel

/-- E os 600 sinais caem no período que o axioma `harappa_period` do autor afirma (−2600 … −1900). -/
theorem sinais_no_periodo : ∀ n < 601, 1 ≤ n → -2600 ≤ dataSinal n ∧ dataSinal n ≤ -1900 := by decide +kernel

/-- O conceito 425 do gerador tem data 1600 … -/
theorem conceito_425 : dataModerna 425 = 1600 := by decide +kernel

/-- … e é o único fora de `modern_mathematics` (data > 1600). -/
theorem so_o_425 : ∀ n < 601, 1 ≤ n → dataModerna n ≤ 1600 → n = 425 := by decide +kernel

/-- Com o axioma do autor (`modern_mathematics`: toda data moderna > 1600) e a datação do gerador, nenhum conceito tem
    id 425: a hipótese de `precedence_0425` (m.id = 425) nunca é satisfeita, o teorema vale por vacuidade. -/
theorem precedence_0425_vazio (C : Type) (ident : C → Nat) (data : C → Int)
    (autor : ∀ m, data m > 1600)
    (gerador : ∀ m n, ident m = n → 1 ≤ n ∧ n ≤ 600 → data m = dataModerna n) :
    ∀ m, ident m ≠ 425 := by
  intro m hm
  have h1 := autor m
  rw [gerador m 425 hm ⟨by decide, by decide⟩, conceito_425] at h1
  exact absurd h1 (by decide)

/-! ## MILLENNIUM_SOLUTIONS: `absolute_precedence_N` -/

/-- (carbon14_date_N, modern_publication_N) das 71 `absolute_precedence_N`. -/
def precedenciasAbsolutas : List (Int × Nat) := [(-2575, 1862), (-2570, 1865), (-2565, 1868), (-2560, 1871), (-2555, 1874), (-2550, 1877), (-2545, 1880), (-2540, 1883), (-2535, 1886), (-2530, 1889), (-2525, 1892), (-2520, 1895), (-2515, 1898), (-2510, 1901), (-2505, 1904), (-2500, 1907), (-2495, 1910), (-2490, 1913), (-2485, 1916), (-2480, 1919), (-2475, 1922), (-2470, 1925), (-2465, 1928), (-2460, 1931), (-2455, 1934), (-2450, 1937), (-2445, 1940), (-2440, 1943), (-2435, 1946), (-2430, 1949), (-2425, 1952), (-2420, 1955), (-2415, 1958), (-2410, 1961), (-2405, 1964), (-2400, 1967), (-2395, 1970), (-2390, 1973), (-2385, 1976), (-2380, 1979), (-2375, 1982), (-2370, 1985), (-2365, 1988), (-2360, 1991), (-2355, 1994), (-2350, 1997), (-2345, 2000), (-2340, 2003), (-2335, 2006), (-2330, 1859), (-2325, 1862), (-2320, 1865), (-2315, 1868), (-2310, 1871), (-2305, 1874), (-2300, 1877), (-2295, 1880), (-2290, 1883), (-2285, 1886), (-2280, 1889), (-2275, 1892), (-2270, 1895), (-2265, 1898), (-2260, 1901), (-2255, 1904), (-2250, 1907), (-2245, 1910), (-2240, 1913), (-2235, 1916), (-2230, 1919), (-2225, 1922)]

/-- Como escritas (`carbon14_date_N + modern_publication_N > 4000`), as 71 são falsas: a data negativa é somada ao ano. -/
theorem absolute_precedence_falsas : ∀ p ∈ precedenciasAbsolutas, ¬ (p.1 + p.2 > 4000) := by decide +kernel

/-- Com a diferença (`modern_publication_N − carbon14_date_N`), as 71 valem. -/
theorem absolute_precedence_pela_diferenca : ∀ p ∈ precedenciasAbsolutas, (p.2 : Int) - p.1 > 4000 := by decide +kernel

/-! ## Gematria (TIMELINE_ANALYSIS: `gematria_value := 316` em 99 registros) -/

/-- Valor numérico padrão das letras hebraicas (as formas finais valem o mesmo que as comuns). -/
def gematria : Char → Nat
  | 'א' => 1
  | 'ב' => 2
  | 'ג' => 3
  | 'ד' => 4
  | 'ה' => 5
  | 'ו' => 6
  | 'ז' => 7
  | 'ח' => 8
  | 'ט' => 9
  | 'י' => 10
  | 'כ' => 20
  | 'ך' => 20
  | 'ל' => 30
  | 'מ' => 40
  | 'ם' => 40
  | 'נ' => 50
  | 'ן' => 50
  | 'ס' => 60
  | 'ע' => 70
  | 'פ' => 80
  | 'ף' => 80
  | 'צ' => 90
  | 'ץ' => 90
  | 'ק' => 100
  | 'ר' => 200
  | 'ש' => 300
  | 'ת' => 400
  | _ => 0

def gematriaPalavra (s : String) : Nat := (s.toList.map gematria).foldl (· + ·) 0

/-- 316 é a gematria de ישו (י 10 + ש 300 + ו 6): o valor que os `yeshu_connection_N` gravam tem essa origem. -/
theorem gematria_yeshu : gematriaPalavra "ישו" = 316 := by decide +kernel

/-! ## `meta_N_decidability` (FORMAL_VERIFICATIONS, 500 teoremas) -/

/-- O lado direito de `meta_N_decidability` é `∀ formula, Decidable (derivable system formula)`, um TIPO (`Decidable` é
    uma classe de dados), e `↔` só liga proposições: o enunciado não é bem formado. Lido como proposição
    (`Nonempty …`), vale para qualquer predicado, pela lógica clássica: -/
theorem decidabilidade_classica {S F : Type} (derivable : S → F → Prop) (s : S) :
    Nonempty (∀ f, Decidable (derivable s f)) := ⟨fun _ => Classical.dec _⟩

end MveiSemantica.Mishkan
