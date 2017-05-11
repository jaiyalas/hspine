module Spine where

import Spine.Raw.Test

yo :: IO ()
yo = do
  putStrLn $ "\nhello world: " ++ (show AA)

yo2 :: IO ()
yo2 = do
    i <- spBone_isYDown_haskell
    putStrLn $ "YO2=["++(show i)++"]"
    spBone_setYDown_haskell $ toEnum 10
    i2 <- spBone_isYDown_haskell
    putStrLn $ "YO2=["++(show i2)++"]"
