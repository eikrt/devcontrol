import Hello (create)
import Utils(createDirectoryIfNotExists)
import System.Environment (getArgs)

installPackage :: String -> IO ()
installPackage packageName = do 
    putStrLn $ "Installing package: " ++ packageName
    create


main :: IO ()
main = do
  let rootDir = "./enewald/"
  let pkgsDir = "./enewald/pkgs/"
  args <- getArgs
  case args of
    ["install", packageName] -> installPackage packageName
    ["init", arch] -> do 
        createDirectoryIfNotExists rootDir
        createDirectoryIfNotExists pkgsDir 
    ["remove", packageName] -> putStrLn $ "Removing package: " ++ packageName
    _ -> putStrLn "Invalid command"
