module Spine
    ( test01
    , test02
    ) where
--
-- import Spine.Raw
import Spine.Raw.InternalTest
--
--
test01 :: IO ()
test01 = do
  putStrLn $ "\nhello world: " ++ (show AA)

test02 :: IO ()
test02 = do
    i <- spBone_isYDown_haskell
    putStrLn $ "YO2=["++(show i)++"]"
    spBone_setYDown_haskell $ toEnum 10
    i2 <- spBone_isYDown_haskell
    putStrLn $ "YO2=["++(show i2)++"]"
