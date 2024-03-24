module Helpers (create) where

import Utils (preBuild,build,fetch,install,get,computeHash,Package(..), createDirectoryIfNotExists)
import Globals(pkgsDir)

create :: Package -> IO () 
create pkg = do
    putStrLn $ "Creating package " ++ (name pkg)
    let hash = computeHash pkg 
    createDirectoryIfNotExists $ pkgsDir ++ name pkg ++ "-" ++ show hash
    fetch pkg (show hash)
    preBuild pkg (show hash)
    build pkg (show hash)
    install pkg 
