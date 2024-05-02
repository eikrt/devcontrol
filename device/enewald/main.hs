import Hello (genesis)
import Utils(createDirectoryIfNotExists)
import Globals(rootDir, pkgsDir)
import System.Environment (getArgs)

installPackage :: String -> IO ()
installPackage packageName = do 
    putStrLn $ "Installing package: " ++ packageName
    genesis 


main :: IO ()
main = do
  args <- getArgs
  case args of
    ["build", packageName] -> installPackage packageName
    ["buildos", packageName] -> installPackage packageName
    ["init"] -> do 
        createDirectoryIfNotExists rootDir
        createDirectoryIfNotExists pkgsDir 
    ["remove", packageName] -> putStrLn $ "TODO! Removing package: " ++ packageName
    _ -> putStrLn "Invalid command"
