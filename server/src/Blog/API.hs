{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeOperators     #-}


module Blog.API (BlogAPI, blogAPI) where

import Servant.API.ContentTypes (JSON)
import Servant (ServerT, Get)
import Servant.Elm (deriveBoth, defaultOptions)

import Config (AppM)

type BlogAPI = Get '[JSON] TestResponse

data TestResponse = TestResponse
  { name :: String
  } deriving (Eq, Show)

blogAPI :: ServerT BlogAPI AppM
blogAPI = root'
  where
    root' :: AppM TestResponse
    root' = do
      return TestResponse { name = "example" }

deriveBoth defaultOptions ''TestResponse

