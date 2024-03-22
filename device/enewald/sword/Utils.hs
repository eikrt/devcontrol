module Utils (Package(..),compile,get, createDirectoryIfNotExists) where
import System.Directory (createDirectoryIfMissing)
import System.Process

data Package = Package
  {
    name :: String
  , version :: String
  , sha256 :: String
  , url :: String
  } deriving (Show)

createDirectoryIfNotExists :: FilePath -> IO ()
createDirectoryIfNotExists dir = do
    createDirectoryIfMissing True dir 
    putStrLn $ "Directory '" ++ dir ++ "' created or already exists."

get :: String -> IO ()
get url = do
    let outputFileName = "pkgs/hello/source.tar.gz"
    (_, _, _, processHandle) <- createProcess (shell $ "wget " ++ url ++ " -O " ++ outputFileName)
    _ <- waitForProcess processHandle
    putStrLn "Download complete"


compile :: Package -> IO ()
compile pkg = do
    get (url pkg)
    putStrLn $ "Compiling package " ++ url pkg
