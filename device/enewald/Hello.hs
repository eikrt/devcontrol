module Hello (genesis) where
import Helpers (create)
import Utils(Package(..))
import Globals(rootDir, pkgsDir)

ver = "2.12.1"

pkg :: Package
pkg = Package
  {
    name = "Hello"
  , version = ver
  , sha256 = "sha256-jZkUKv2SV28wsM18tCqNxoCZmLxdYH2Idh9RLibH2yA="
  , url = "https://www.nic.funet.fi/pub/gnu/ftp.gnu.org/pub/gnu/hello/hello-" ++ ver ++ ".tar.gz"
  , preBuildInstructions = "cd $dir && ./configure"
  , buildInstructions = "make -C $dir"
  , installInstructions = "echo todo!"
  }
genesis :: IO()
genesis = do
    create pkg
