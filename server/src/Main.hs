module Main where

import App (app)
import Network.Wai.Handler.Warp (run)
import Network.Wai.Middleware.RequestLogger (logStdoutDev, logStdout)
import System.Environment (lookupEnv, getEnv)
import Config (defaultConfig, makeLogger, Config (..), Environment (..))

lookupSetting :: Read a => String -> a -> IO a
lookupSetting env def = do
  p <- lookupEnv env
  return $ maybe def read p

main :: IO ()
main = do
  port <- lookupSetting "PORT" 8080
  htmlPath <- getEnv "HTMLFILE"
  isProduction <- (== "1") <$> getEnv "PRODUCTION"
  let env = if isProduction then Production else Development
      cfg = defaultConfig htmlPath env
      logger = makeLogger env
  putStrLn $ "Running on port: " ++ show port
  putStrLn $ "HtmlPath: " ++ show htmlPath
  putStrLn $ "Environment: " ++ show env
  run port $ logger $ app cfg
