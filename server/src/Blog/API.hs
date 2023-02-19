{-# LANGUAGE DeriveGeneric #-}

module Blog.API (BlogAPI, blogAPI) where

import Servant.API.ContentTypes (JSON)
import Servant (ServerT)
import Servant.Elm (deriveBoth, deriveBoth)

import qualified Config as C

type BlogAPI = Get '[JSON] TestResponse

data TestResponse = TestResponse
  { value :: String
  } deriving (Eq, Show)

blogAPI :: ServerT BlogAPI C.AppM
blogAPI = root'
  where
    root' :: C.AppM TestResponse
    root' = do
      return TestResponse { name = "example" }

deriveBoth defaultOptions ''BlogAPI
