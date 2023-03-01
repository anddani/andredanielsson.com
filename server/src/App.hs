{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}

module App (app) where

import Servant ((:>), (:<|>) (..), Raw, serveDirectoryFileServer)
import Servant.Server (ServerT, Tagged(..), Application, serve, hoistServer)
import Control.Monad.Trans.Reader (ReaderT, asks)
import Data.Proxy (Proxy (Proxy))
import Control.Monad.Trans.Reader (runReaderT)
import Network.HTTP.Types (status200)
import Network.Wai (responseFile)

import Blog.API (BlogAPI, blogAPI)
import Config (Config(..), AppM)

type API = "blog" :> BlogAPI
  :<|> Raw

appApi :: Proxy API
appApi = Proxy

files :: Config -> ServerT Raw AppM
files cfg = Tagged $ \req res ->
  res $ responseFile status200 [("Content-Type", "text/html")] (htmlPath cfg) Nothing

server :: Config -> ServerT API AppM
server cfg = blogAPI
  :<|> files cfg

app :: Config -> Application
app cfg = serve appApi $ hoistServer appApi (`runReaderT` cfg) (server cfg)
