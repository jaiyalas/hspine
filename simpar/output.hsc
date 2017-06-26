-- | SpAnimationStateData
data SpAnimationStateData = SpAnimationStateData
    { skeletonData :: Ptr SpSkeletonData
    , defaultMix :: CFloat
    , entries :: Ptr ()
    } deriving (Show, Eq)
instance Storable SpAnimationStateData where
    alignment _ = #{alignment spAnimationStateData}
    sizeOf _    = #{size spAnimationStateData}
    peek ptr = do
        a <- #{peek spAnimationStateData, skeletonData} ptr
        b <- #{peek spAnimationStateData, defaultMix} ptr
        c <- #{peek spAnimationStateData, entries} ptr
        return (SpAnimationStateData a b c)
    poke ptr (SpAnimationStateData a b c) = do
        #{poke spAnimationStateData, skeletonData} ptr a
        #{poke spAnimationStateData, defaultMix} ptr b
        #{poke spAnimationStateData, entries} ptr c

    , data SpAnimationStateData(..)
