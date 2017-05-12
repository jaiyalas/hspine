module Spine
    ( module Spine.Raw.AnimationState
    , module Spine.Raw.AnimationStateData
    , module Spine.Raw.Atlas
    , module Spine.Raw.Attachment
    , module Spine.Raw.Bone
    , module Spine.Raw.MeshAttachment
    , module Spine.Raw.RegionAttachment
    , module Spine.Raw.Skeleton
    , module Spine.Raw.SkeletonData
    , module Spine.Raw.Slot
    , test01, test02
    ) where
--
import Spine.Raw.Test
--
import Spine.Raw.AnimationState
import Spine.Raw.AnimationStateData
import Spine.Raw.Atlas
import Spine.Raw.Attachment
import Spine.Raw.Bone
import Spine.Raw.MeshAttachment
import Spine.Raw.RegionAttachment
import Spine.Raw.Skeleton
import Spine.Raw.SkeletonData
import Spine.Raw.Slot
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
