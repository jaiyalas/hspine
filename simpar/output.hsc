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

-- | SpTimeline
data SpTimeline = SpTimeline
    { type :: SpTimelineType
    , vtable :: Ptr ()
    } deriving (Show, Eq)
instance Storable SpTimeline where
    alignment _ = #{alignment spTimeline}
    sizeOf _    = #{size spTimeline}
    peek ptr = do
        a <- #{peek spTimeline, type} ptr
        b <- #{peek spTimeline, vtable} ptr
        return (SpTimeline a b)
    poke ptr (SpTimeline a b) = do
        #{poke spTimeline, type} ptr a
        #{poke spTimeline, vtable} ptr b

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

-- | SpColorTimeline
data SpColorTimeline = SpColorTimeline
    { super :: SpCurveTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, r, g, b, a, ...
    , slotIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpColorTimeline where
    alignment _ = #{alignment spColorTimeline}
    sizeOf _    = #{size spColorTimeline}
    peek ptr = do
        a <- #{peek spColorTimeline, super} ptr
        b <- #{peek spColorTimeline, framesCount} ptr
        c <- #{peek spColorTimeline, frames} ptr
        d <- #{peek spColorTimeline, slotIndex} ptr
        return (SpColorTimeline a b c d)
    poke ptr (SpColorTimeline a b c d) = do
        #{poke spColorTimeline, super} ptr a
        #{poke spColorTimeline, framesCount} ptr b
        #{poke spColorTimeline, frames} ptr c
        #{poke spColorTimeline, slotIndex} ptr d

-- | SpAttachmentTimeline
data SpAttachmentTimeline = SpAttachmentTimeline
    { super :: SpTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, ...
    , slotIndex :: CInt
    , attachmentNames :: Ptr CString
    } deriving (Show, Eq)
instance Storable SpAttachmentTimeline where
    alignment _ = #{alignment spAttachmentTimeline}
    sizeOf _    = #{size spAttachmentTimeline}
    peek ptr = do
        a <- #{peek spAttachmentTimeline, super} ptr
        b <- #{peek spAttachmentTimeline, framesCount} ptr
        c <- #{peek spAttachmentTimeline, frames} ptr
        d <- #{peek spAttachmentTimeline, slotIndex} ptr
        e <- #{peek spAttachmentTimeline, attachmentNames} ptr
        return (SpAttachmentTimeline a b c d e)
    poke ptr (SpAttachmentTimeline a b c d e) = do
        #{poke spAttachmentTimeline, super} ptr a
        #{poke spAttachmentTimeline, framesCount} ptr b
        #{poke spAttachmentTimeline, frames} ptr c
        #{poke spAttachmentTimeline, slotIndex} ptr d
        #{poke spAttachmentTimeline, attachmentNames} ptr e

-- | SpEventTimeline
data SpEventTimeline = SpEventTimeline
    { super :: SpTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, ...
    , events :: Ptr ( Ptr SpEvent )
    } deriving (Show, Eq)
instance Storable SpEventTimeline where
    alignment _ = #{alignment spEventTimeline}
    sizeOf _    = #{size spEventTimeline}
    peek ptr = do
        a <- #{peek spEventTimeline, super} ptr
        b <- #{peek spEventTimeline, framesCount} ptr
        c <- #{peek spEventTimeline, frames} ptr
        d <- #{peek spEventTimeline, events} ptr
        return (SpEventTimeline a b c d)
    poke ptr (SpEventTimeline a b c d) = do
        #{poke spEventTimeline, super} ptr a
        #{poke spEventTimeline, framesCount} ptr b
        #{poke spEventTimeline, frames} ptr c
        #{poke spEventTimeline, events} ptr d

-- | SpDrawOrderTimeline
data SpDrawOrderTimeline = SpDrawOrderTimeline
    { super :: SpTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, ...
    , drawOrders :: Ptr ( Ptr CInt )
    , slotsCount :: CInt
    } deriving (Show, Eq)
instance Storable SpDrawOrderTimeline where
    alignment _ = #{alignment spDrawOrderTimeline}
    sizeOf _    = #{size spDrawOrderTimeline}
    peek ptr = do
        a <- #{peek spDrawOrderTimeline, super} ptr
        b <- #{peek spDrawOrderTimeline, framesCount} ptr
        c <- #{peek spDrawOrderTimeline, frames} ptr
        d <- #{peek spDrawOrderTimeline, drawOrders} ptr
        e <- #{peek spDrawOrderTimeline, slotsCount} ptr
        return (SpDrawOrderTimeline a b c d e)
    poke ptr (SpDrawOrderTimeline a b c d e) = do
        #{poke spDrawOrderTimeline, super} ptr a
        #{poke spDrawOrderTimeline, framesCount} ptr b
        #{poke spDrawOrderTimeline, frames} ptr c
        #{poke spDrawOrderTimeline, drawOrders} ptr d
        #{poke spDrawOrderTimeline, slotsCount} ptr e

-- | SpDeformTimeline
data SpDeformTimeline = SpDeformTimeline
    { super :: SpCurveTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, ...
    , frameVerticesCount :: CInt
    , frameVertices :: Ptr ( Ptr CFloat )
    , slotIndex :: CInt
    , attachment :: Ptr SpAttachment
    } deriving (Show, Eq)
instance Storable SpDeformTimeline where
    alignment _ = #{alignment spDeformTimeline}
    sizeOf _    = #{size spDeformTimeline}
    peek ptr = do
        a <- #{peek spDeformTimeline, super} ptr
        b <- #{peek spDeformTimeline, framesCount} ptr
        c <- #{peek spDeformTimeline, frames} ptr
        d <- #{peek spDeformTimeline, frameVerticesCount} ptr
        e <- #{peek spDeformTimeline, frameVertices} ptr
        f <- #{peek spDeformTimeline, slotIndex} ptr
        g <- #{peek spDeformTimeline, attachment} ptr
        return (SpDeformTimeline a b c d e f g)
    poke ptr (SpDeformTimeline a b c d e f g) = do
        #{poke spDeformTimeline, super} ptr a
        #{poke spDeformTimeline, framesCount} ptr b
        #{poke spDeformTimeline, frames} ptr c
        #{poke spDeformTimeline, frameVerticesCount} ptr d
        #{poke spDeformTimeline, frameVertices} ptr e
        #{poke spDeformTimeline, slotIndex} ptr f
        #{poke spDeformTimeline, attachment} ptr g

-- | SpIkConstraintTimeline
data SpIkConstraintTimeline = SpIkConstraintTimeline
    { super :: SpCurveTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, mix, bendDirection, ...
    , ikConstraintIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpIkConstraintTimeline where
    alignment _ = #{alignment spIkConstraintTimeline}
    sizeOf _    = #{size spIkConstraintTimeline}
    peek ptr = do
        a <- #{peek spIkConstraintTimeline, super} ptr
        b <- #{peek spIkConstraintTimeline, framesCount} ptr
        c <- #{peek spIkConstraintTimeline, frames} ptr
        d <- #{peek spIkConstraintTimeline, ikConstraintIndex} ptr
        return (SpIkConstraintTimeline a b c d)
    poke ptr (SpIkConstraintTimeline a b c d) = do
        #{poke spIkConstraintTimeline, super} ptr a
        #{poke spIkConstraintTimeline, framesCount} ptr b
        #{poke spIkConstraintTimeline, frames} ptr c
        #{poke spIkConstraintTimeline, ikConstraintIndex} ptr d

-- | SpTransformConstraintTimeline
data SpTransformConstraintTimeline = SpTransformConstraintTimeline
    { super :: SpCurveTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , transformConstraintIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpTransformConstraintTimeline where
    alignment _ = #{alignment spTransformConstraintTimeline}
    sizeOf _    = #{size spTransformConstraintTimeline}
    peek ptr = do
        a <- #{peek spTransformConstraintTimeline, super} ptr
        b <- #{peek spTransformConstraintTimeline, framesCount} ptr
        c <- #{peek spTransformConstraintTimeline, frames} ptr
        d <- #{peek spTransformConstraintTimeline, transformConstraintIndex} ptr
        return (SpTransformConstraintTimeline a b c d)
    poke ptr (SpTransformConstraintTimeline a b c d) = do
        #{poke spTransformConstraintTimeline, super} ptr a
        #{poke spTransformConstraintTimeline, framesCount} ptr b
        #{poke spTransformConstraintTimeline, frames} ptr c
        #{poke spTransformConstraintTimeline, transformConstraintIndex} ptr d

-- | SpPathConstraintPositionTimeline
data SpPathConstraintPositionTimeline = SpPathConstraintPositionTimeline
    { super :: SpCurveTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , pathConstraintIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpPathConstraintPositionTimeline where
    alignment _ = #{alignment spPathConstraintPositionTimeline}
    sizeOf _    = #{size spPathConstraintPositionTimeline}
    peek ptr = do
        a <- #{peek spPathConstraintPositionTimeline, super} ptr
        b <- #{peek spPathConstraintPositionTimeline, framesCount} ptr
        c <- #{peek spPathConstraintPositionTimeline, frames} ptr
        d <- #{peek spPathConstraintPositionTimeline, pathConstraintIndex} ptr
        return (SpPathConstraintPositionTimeline a b c d)
    poke ptr (SpPathConstraintPositionTimeline a b c d) = do
        #{poke spPathConstraintPositionTimeline, super} ptr a
        #{poke spPathConstraintPositionTimeline, framesCount} ptr b
        #{poke spPathConstraintPositionTimeline, frames} ptr c
        #{poke spPathConstraintPositionTimeline, pathConstraintIndex} ptr d

-- | SpPathConstraintSpacingTimeline
data SpPathConstraintSpacingTimeline = SpPathConstraintSpacingTimeline
    { super :: SpCurveTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , pathConstraintIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpPathConstraintSpacingTimeline where
    alignment _ = #{alignment spPathConstraintSpacingTimeline}
    sizeOf _    = #{size spPathConstraintSpacingTimeline}
    peek ptr = do
        a <- #{peek spPathConstraintSpacingTimeline, super} ptr
        b <- #{peek spPathConstraintSpacingTimeline, framesCount} ptr
        c <- #{peek spPathConstraintSpacingTimeline, frames} ptr
        d <- #{peek spPathConstraintSpacingTimeline, pathConstraintIndex} ptr
        return (SpPathConstraintSpacingTimeline a b c d)
    poke ptr (SpPathConstraintSpacingTimeline a b c d) = do
        #{poke spPathConstraintSpacingTimeline, super} ptr a
        #{poke spPathConstraintSpacingTimeline, framesCount} ptr b
        #{poke spPathConstraintSpacingTimeline, frames} ptr c
        #{poke spPathConstraintSpacingTimeline, pathConstraintIndex} ptr d

-- | SpPathConstraintMixTimeline
data SpPathConstraintMixTimeline = SpPathConstraintMixTimeline
    { super :: SpCurveTimeline
    , framesCount :: CInt
    , frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , pathConstraintIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpPathConstraintMixTimeline where
    alignment _ = #{alignment spPathConstraintMixTimeline}
    sizeOf _    = #{size spPathConstraintMixTimeline}
    peek ptr = do
        a <- #{peek spPathConstraintMixTimeline, super} ptr
        b <- #{peek spPathConstraintMixTimeline, framesCount} ptr
        c <- #{peek spPathConstraintMixTimeline, frames} ptr
        d <- #{peek spPathConstraintMixTimeline, pathConstraintIndex} ptr
        return (SpPathConstraintMixTimeline a b c d)
    poke ptr (SpPathConstraintMixTimeline a b c d) = do
        #{poke spPathConstraintMixTimeline, super} ptr a
        #{poke spPathConstraintMixTimeline, framesCount} ptr b
        #{poke spPathConstraintMixTimeline, frames} ptr c
        #{poke spPathConstraintMixTimeline, pathConstraintIndex} ptr d

    , data SpAnimation(..)
    , data SpTimeline(..)
    , data SpCurveTimeline(..)
    , data SpBaseTimeline(..)
    , data SpColorTimeline(..)
    , data SpAttachmentTimeline(..)
    , data SpEventTimeline(..)
    , data SpDrawOrderTimeline(..)
    , data SpDeformTimeline(..)
    , data SpIkConstraintTimeline(..)
    , data SpTransformConstraintTimeline(..)
    , data SpPathConstraintPositionTimeline(..)
    , data SpPathConstraintSpacingTimeline(..)
    , data SpPathConstraintMixTimeline(..)
