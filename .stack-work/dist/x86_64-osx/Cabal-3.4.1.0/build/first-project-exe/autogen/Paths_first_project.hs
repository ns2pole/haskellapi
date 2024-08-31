{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_first_project (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/nakamura/Program/haskell_exercise/first-project/.stack-work/install/x86_64-osx/27a34771af5de5433f1212e79f3fb6f0d293e00751bcc505c16102f18daba332/9.0.2/bin"
libdir     = "/Users/nakamura/Program/haskell_exercise/first-project/.stack-work/install/x86_64-osx/27a34771af5de5433f1212e79f3fb6f0d293e00751bcc505c16102f18daba332/9.0.2/lib/x86_64-osx-ghc-9.0.2/first-project-0.1.0.0-DiXjhw7omWeBZnpJLITHaG-first-project-exe"
dynlibdir  = "/Users/nakamura/Program/haskell_exercise/first-project/.stack-work/install/x86_64-osx/27a34771af5de5433f1212e79f3fb6f0d293e00751bcc505c16102f18daba332/9.0.2/lib/x86_64-osx-ghc-9.0.2"
datadir    = "/Users/nakamura/Program/haskell_exercise/first-project/.stack-work/install/x86_64-osx/27a34771af5de5433f1212e79f3fb6f0d293e00751bcc505c16102f18daba332/9.0.2/share/x86_64-osx-ghc-9.0.2/first-project-0.1.0.0"
libexecdir = "/Users/nakamura/Program/haskell_exercise/first-project/.stack-work/install/x86_64-osx/27a34771af5de5433f1212e79f3fb6f0d293e00751bcc505c16102f18daba332/9.0.2/libexec/x86_64-osx-ghc-9.0.2/first-project-0.1.0.0"
sysconfdir = "/Users/nakamura/Program/haskell_exercise/first-project/.stack-work/install/x86_64-osx/27a34771af5de5433f1212e79f3fb6f0d293e00751bcc505c16102f18daba332/9.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "first_project_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "first_project_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "first_project_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "first_project_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "first_project_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "first_project_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
