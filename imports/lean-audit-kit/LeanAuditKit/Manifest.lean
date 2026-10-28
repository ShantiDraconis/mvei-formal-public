import LeanAuditKit.Core

namespace LeanAuditKit

structure ReleaseManifest where
  product : String
  version : String
  releaseState : String
  deriving Repr, DecidableEq

def expectedManifest : ReleaseManifest := {
  product := "Lean Audit Kit"
  version := "1.0.0"
  releaseState := "GITHUB_RELEASE_PUBLISHED_PENDING_STOREFRONT"
}

theorem manifestConsistent :
    expectedManifest.product = "Lean Audit Kit" ∧
    expectedManifest.version = LeanAuditKit.version ∧
    expectedManifest.releaseState = "GITHUB_RELEASE_PUBLISHED_PENDING_STOREFRONT" := by
  simp [expectedManifest, LeanAuditKit.version]

end LeanAuditKit
