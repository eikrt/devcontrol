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
    ["init", arch] -> do 
        createDirectoryIfNotExists rootDir
        createDirectoryIfNotExists pkgsDir 
    ["remove", packageName] -> putStrLn $ "Removing package: " ++ packageName
    _ -> putStrLn "Invalid command"
