{ lib
, buildGoModule
, go
}:

buildGoModule {
  pname = "lazyssh";
  version = "0.3.1";

  src = ./.;

  vendorHash = "sha256-OMlpqe7FJDqgppxt4t8lJ1KnXICOh6MXVXoKkYJ74Ks=";

  ldflags = [
    "-X=main.version=0.3.1"
    "-X=main.gitCommit=v0.3.1"
  ];

  postInstall = ''
    mv $out/bin/cmd $out/bin/lazyssh
  '';

  meta = {
    description = "Terminal-based SSH manager";
    homepage = "https://github.com/barthofu/lazyssh";
    license = lib.licenses.asl20;
    mainProgram = "lazyssh";
  };
}
