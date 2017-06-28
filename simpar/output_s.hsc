-- | SpCurveTimeline
data SpCurveTimeline = SpCurveTimeline
    { super :: SpTimeline
    , curves :: Ptr CFloat -- ^ type, x, y, ...
    } deriving (Show, Eq)
instance Storable SpCurveTimeline where
    alignment _ = #{alignment spCurveTimeline}
    sizeOf _    = #{size spCurveTimeline}
    peek ptr = do
        a <- #{peek spCurveTimeline, super} ptr
        b <- #{peek spCurveTimeline, curves} ptr
        return (SpCurveTimeline a b)
    poke ptr (SpCurveTimeline a b) = do
        #{poke spCurveTimeline, super} ptr a
        #{poke spCurveTimeline, curves} ptr b

-- | SpBaseTimeline
data SpBaseTimeline = SpBaseTimeline
    { super :: SpCurveTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, angle, ... for rotate. time, x, y, ... for translate and scale.
    , boneIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpBaseTimeline where
    alignment _ = #{alignment spBaseTimeline}
    sizeOf _    = #{size spBaseTimeline}
    peek ptr = do
        a <- #{peek spBaseTimeline, super} ptr
        b <- #{peek spBaseTimeline, framesCount} ptr
        c <- #{peek spBaseTimeline, frames} ptr
        d <- #{peek spBaseTimeline, boneIndex} ptr
        return (SpBaseTimeline a b c d)
    poke ptr (SpBaseTimeline a b c d) = do
        #{poke spBaseTimeline, super} ptr a
        #{poke spBaseTimeline, framesCount} ptr b
        #{poke spBaseTimeline, frames} ptr c
        #{poke spBaseTimeline, boneIndex} ptr d



    , data SpCurveTimeline(..)
    , data SpBaseTimeline(..)
