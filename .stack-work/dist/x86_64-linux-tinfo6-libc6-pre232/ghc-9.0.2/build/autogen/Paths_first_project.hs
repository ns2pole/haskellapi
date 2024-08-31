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

bindir     = "/app/first-project/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/4ed4d1bc8861d80ea3472a066b6e945721c5f36e370d846fd87d540872f0a24b/9.0.2/bin"
libdir     = "/app/first-project/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/4ed4d1bc8861d80ea3472a066b6e945721c5f36e370d846fd87d540872f0a24b/9.0.2/lib/x86_64-linux-ghc-9.0.2/first-project-0.1.0.0-voqUzw8CueG4LEodmnJFE"
dynlibdir  = "/app/first-project/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/4ed4d1bc8861d80ea3472a066b6e945721c5f36e370d846fd87d540872f0a24b/9.0.2/lib/x86_64-linux-ghc-9.0.2"
datadir    = "/app/first-project/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/4ed4d1bc8861d80ea3472a066b6e945721c5f36e370d846fd87d540872f0a24b/9.0.2/share/x86_64-linux-ghc-9.0.2/first-project-0.1.0.0"
libexecdir = "/app/first-project/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/4ed4d1bc8861d80ea3472a066b6e945721c5f36e370d846fd87d540872f0a24b/9.0.2/libexec/x86_64-linux-ghc-9.0.2/first-project-0.1.0.0"
sysconfdir = "/app/first-project/.stack-work/install/x86_64-linux-tinfo6-libc6-pre232/4ed4d1bc8861d80ea3472a066b6e945721c5f36e370d846fd87d540872f0a24b/9.0.2/etc"

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
