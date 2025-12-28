{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/25.05";
  inputs.nix-github-actions.url = "github:nix-community/nix-github-actions";
  inputs.nix-github-actions.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, nix-github-actions }: {
    packages.x86_64-linux.default = import ./default.nix { nixpkgs = nixpkgs.legacyPackages.x86_64-linux.extend (import ./overlay.nix { withCcache = false; smp = false; disableTargetWarning = true; }); };
    checks.x86_64-linux.build = self.packages.x86_64-linux.default;
    githubActions = nix-github-actions.lib.mkGithubMatrix { inherit (self) checks; };
  };
}