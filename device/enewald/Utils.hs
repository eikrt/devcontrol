{-# LANGUAGE OverloadedStrings #-}
module Utils (Package(..),fetch,preBuild,build,install,computeHash,get,createDirectoryIfNotExists) where
import Globals(rootDir, pkgsDir) 
import System.Directory (createDirectoryIfMissing)
import System.Process
import Data.ByteString.Char8 (pack)
import Crypto.Hash (hash, Digest, SHA256)
import Data.Text(Text, replace)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
data Package = Package
  {
    name :: String
  , version :: String
  , sha256 :: String
  , url :: String
  , buildInstructions :: String
  , preBuildInstructions :: String
  , installInstructions :: String
  } deriving (Show)

replaceText :: Text -> Text -> Text -> Text
replaceText old new = T.replace old new

performSubstitutionsPre :: Package -> String -> Text 
performSubstitutionsPre pkg hash =
  let dir = pkgsDir ++ name pkg ++ "-" ++ hash
      replacedText = replaceText "$dir" (T.pack dir) (T.pack (preBuildInstructions pkg))
  in replacedText

performSubstitutionsBuild :: Package -> String -> Text 
performSubstitutionsBuild pkg hash =
  let dir = pkgsDir ++ name pkg ++ "-" ++ hash
      replacedText = replaceText "$dir" (T.pack dir) (T.pack (buildInstructions pkg))
  in replacedText

createDirectoryIfNotExists :: FilePath -> IO ()
createDirectoryIfNotExists dir = do
    createDirectoryIfMissing True dir 
    putStrLn $ "Directory '" ++ dir ++ "' created or already exists."

get :: Package -> String -> IO ()
get pkg hash = do
    let outputFileName =  pkgsDir ++ name pkg ++ "-" ++ hash ++ "/source.tar.gz"
    (_, _, _, processHandle) <- createProcess (shell $ "wget " ++ url pkg ++ " -O " ++ outputFileName)
    _ <- waitForProcess processHandle
    putStrLn "Download complete"

extract :: Package -> String -> IO ()
extract pkg hash = do
    let pkgName =  pkgsDir ++ name pkg ++ "-" ++ hash ++ "/source.tar.gz"
    (_, _, _, processHandle) <- createProcess (shell $ "tar -xvf " ++ pkgName ++ " -C " ++ pkgsDir ++ name pkg ++ "-" ++ hash ++ " --strip-components=1")
    _ <- waitForProcess processHandle
    putStrLn "Download complete"

fetch :: Package -> String -> IO ()
fetch pkg hash = do
    get pkg hash
    extract pkg hash 
    putStrLn $ "Fetching package " ++ name pkg

preBuild :: Package -> String -> IO ()
preBuild pkg hash = do
    let s = performSubstitutionsPre pkg hash
    (_, _, _, processHandle) <- createProcess (shell $ T.unpack s)
    _ <- waitForProcess processHandle
    putStrLn $ "Building package " ++ name pkg

build :: Package -> String -> IO ()
build pkg hash = do
    let s = performSubstitutionsBuild pkg hash
    (_, _, _, processHandle) <- createProcess (shell $ T.unpack s)
    _ <- waitForProcess processHandle
    putStrLn $ "Building package " ++ name pkg

install :: Package -> IO ()
install pkg = do
    (_, _, _, processHandle) <- createProcess (shell $ installInstructions pkg)
    _ <- waitForProcess processHandle
    putStrLn $ "Installing package " ++ name pkg

computeHash :: Package -> Digest SHA256
computeHash = hash . Data.ByteString.Char8.pack . show
