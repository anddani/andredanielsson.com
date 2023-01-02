module Config where

import Network.Wai.Middleware.RequestLogger (logStdoutDev, logStdout)
import Control.Monad.Trans.Reader (ReaderT, asks)
import Servant.Server (Handler)
import Network.Wai (Middleware)

type AppM = ReaderT Config Handler

data Config = Config
  { appEnv :: Environment
  , htmlPath :: FilePath
  , staticDir :: FilePath
  }

data Environment
  = Development
  | Production
  deriving (Eq, Show, Read)

defaultConfig :: FilePath -> Environment -> Config
defaultConfig _htmlPath env =
  Config
    { appEnv = env
    , htmlPath = _htmlPath
    }

makeLogger :: Environment -> Middleware
makeLogger Development = logStdoutDev
makeLogger Production = logStdout