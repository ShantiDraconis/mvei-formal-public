import Lake
open Lake DSL

package «federated-trivalent-manifold» where
  name := "federated-trivalent-manifold"

lean_lib «FederatedTrivalentManifold» where
  roots := #[`Regra1, `Regra2, `Regra3, `Regra4, `Regra5, `Regra6, `Regra7, `Pesquisa,
             `MedidaClassica]
