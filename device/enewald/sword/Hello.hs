module Hello (create) where
import Utils (compile,get,Package(..), createDirectoryIfNotExists)


ver = "2.12.1"
hellopkg :: Package
hellopkg = Package
  {
    name = "Hello"
  , version = ver
  , sha256 = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA="
  , url = "https://www.nic.funet.fi/pub/gnu/ftp.gnu.org/pub/gnu/hello-" ++ ver ++ ".tar.gz"
  }

create :: IO () = do
    putStrLn "Creating package hello"
    createDirectoryIfNotExists "pkgs/hello"
    compile hellopkg
