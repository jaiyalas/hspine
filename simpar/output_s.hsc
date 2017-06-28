-- | SpAnimation
data SpAnimation = SpAnimation
    { name :: CString
    , duration :: CFloat
    , timelinesCount :: CInt
    , timelines :: Ptr ( Ptr SpTimeline )
    } deriving (Show, Eq)
instance Storable SpAnimation where
    alignment _ = #{alignment spAnimation}
    sizeOf _    = #{size spAnimation}
    peek ptr = do
        a <- #{peek spAnimation, name} ptr
        b <- #{peek spAnimation, duration} ptr
        c <- #{peek spAnimation, timelinesCount} ptr
        d <- #{peek spAnimation, timelines} ptr
        return (SpAnimation a b c d)
    poke ptr (SpAnimation a b c d) = do
        #{poke spAnimation, name} ptr a
        #{poke spAnimation, duration} ptr b
        #{poke spAnimation, timelinesCount} ptr c
        #{poke spAnimation, timelines} ptr d



    , data SpAnimation(..)
