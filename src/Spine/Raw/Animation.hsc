module Spine.Raw.Animation
    (
    -- * ...
      pattern ROTATE_PREV_TIME
    , pattern ROTATE_PREV_ROTATION
    , pattern ROTATE_ROTATION
    , pattern ROTATE_ENTRIES
    , pattern TRANSLATE_ENTRIES
    , pattern COLOR_ENTRIES
    , pattern IKCONSTRAINT_ENTRIES
    , pattern TRANSFORMCONSTRAINT_ENTRIES
    , pattern PATHCONSTRAINTPOSITION_ENTRIES
    , pattern PATHCONSTRAINTSPACING_ENTRIES
    , pattern PATHCONSTRAINTMIX_ENTRIES
    )where
--
#include "spine/Animation.h"
--
-- import Foreign.C.Types
--

-- | SpAnimation
data SpAnimation = SpAnimation
    { spAnimation_name :: CString
    , spAnimation_duration :: CFloat
    , spAnimation_timelinesCount :: CInt
    , spAnimation_timelines :: Ptr (Ptr SpTimeline)
    } deriving (Show, Eq)
instance Storable SpAnimation where
    alignment _ = #{alignment spAnimation}
    sizeOf _ = #{size spAnimation}
    peek ptr = do
        n  <- #{peek spBoneData, name} ptr
        d  <- #{peek spBoneData, duration} ptr
        t  <- #{peek spBoneData, timelinesCount} ptr
        ts <- #{peek spBoneData, timelines} ptr
        return (SpAnimation n d t ts)
    poke ptr (SpAnimation n d t ts) = do
        #{poke spBoneData, name} ptr n
        #{poke spBoneData, duration} ptr d
        #{poke spBoneData, timelinesCount} ptr t
        #{poke spBoneData, timelines} ptr ts
instance Default SpAnimation where
    def = SpAnimation nullPtr 0 0 nullPtr


-- | SpTimeline
data SpTimeline = SpTimeline
    { spTimeline_type :: SpTimelineType
    , spTimeline_vtable :: Ptr () -- ^ const void* const vtable;
    } deriving (Show, Eq)
instance Storable SpTimeline where
    alignment _ = #{alignment spTimeline}
    sizeOf _ = #{size spTimeline}
    peek ptr = do
        t  <- #{peek spTimeline, type} ptr
        vt <- #{peek spTimeline, vtable} ptr
        return (SpTimeline t vt)
    poke ptr (SpTimeline t vt) = do
        #{poke spTimeline, type} ptr t
        #{poke spTimeline, vtable} ptr vt
instance Default SpTimeline where
    def = SpTimeline SP_TIMELINE_SCALE nullPtr

-- | SpCurveTimeline
data SpCurveTimeline = SpCurveTimeline
    { spCurveTimeline_super :: SpTimeline
    , spCurveTimeline_curves :: Ptr CFloat -- ^ type, x, y, ...
    } deriving (Show, Eq)
instance Storable SpCurveTimeline where
    alignment _ = #{alignment spCurveTimeline}
    sizeOf _ = #{size spCurveTimeline}
    peek ptr = do
        s <- #{peek spCurveTimeline, super} ptr
        c <- #{peek spCurveTimeline, curves} ptr
        return (SpCurveTimeline s c)
    poke ptr (SpCurveTimeline s c) = do
        #{poke spCurveTimeline, super} ptr s
        #{poke spCurveTimeline, curves} ptr c
instance Default SpCurveTimeline where
    def = SpCurveTimeline (def :: SpTimeline) nullPtr

-- | SpBaseTimeline
data SpBaseTimeline = SpBaseTimeline
    { spBaseTimeline_super :: SpCurveTimeline
    , spBaseTimeline_framesCount :: CInt
    , spBaseTimeline_frames :: Ptr CFloat
    , spBaseTimeline_boneIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpBaseTimeline where
    alignment _ = #{alignment spBaseTimeline}
    sizeOf _ = #{size spBaseTimeline}
    peek ptr = do
        s <- #{peek spBaseTimeline,  super} ptr
        fc <- #{peek spBaseTimeline, framesCount} ptr
        fs <- #{peek spBaseTimeline, frames} ptr
        b <- #{peek spBaseTimeline,  boneIndex} ptr
        return (SpBaseTimeline s fc fs b)
    poke ptr (SpBaseTimeline s fc fs b) = do
        #{poke spBaseTimeline, super} ptr s
        #{poke spBaseTimeline, framesCount} ptr fc
        #{poke spBaseTimeline, frames} ptr fs
        #{poke spBaseTimeline, boneIndex} ptr b
instance Default SpBaseTimeline where
    def = SpBaseTimeline nullPtr 0 nullPtr 0

-- | SpRotateTimeline
type SpRotateTimeline    = SpBaseTimeline

-- | SpTranslateTimeline
type SpTranslateTimeline = SpBaseTimeline

-- | SpScaleTimeline
type SpScaleTimeline     = SpBaseTimeline

-- | SpShearTimeline
type SpShearTimeline     = SpBaseTimeline

-- | SpColorTimeline
data SpColorTimeline = SpColorTimeline
    { spColorTimeline_super :: SpCurveTimeline
    , spColorTimeline_framesCount :: CInt
    , spColorTimeline_frames :: Ptr CFloat
    , spColorTimeline_slotIndex :: CInt
    } deriving (Show, Eq)
instance Storable SpColorTimeline where
    alignment _ = #{alignment spColorTimeline}
    sizeOf _ = #{size spColorTimeline}
    peek ptr = do
        s <- #{peek spColorTimeline,  super} ptr
        fc <- #{peek spColorTimeline, framesCount} ptr
        fs <- #{peek spColorTimeline, frames} ptr
        b <- #{peek spColorTimeline,  slotIndex} ptr
        return (SpColorTimeline s fc fs b)
    poke ptr (SpColorTimeline s fc fs b) = do
        #{poke spColorTimeline, super} ptr s
        #{poke spColorTimeline, framesCount} ptr fc
        #{poke spColorTimeline, frames} ptr fs
        #{poke spColorTimeline, slotIndex} ptr b
instance Default SpColorTimeline where
    def = SpColorTimeline nullPtr 0 nullPtr 0

-- | SpAttachmentTimeline
data SpAttachmentTimeline = SpAttachmentTimeline
    { spAttachmentTimeline_super       :: SpTimeline
    , spAttachmentTimeline_framesCount :: CInt
    , spAttachmentTimeline_frames      :: Ptr CFloat -- ^ time, ...
    , spAttachmentTimeline_slotIndex   :: CInt
    , spAttachmentTimeline_attachmentNames :: Ptr CString
    } deriving (Show, Eq)
instance Storable SpAttachmentTimeline where
    alignment _ = #{alignment spAttachmentTimeline}
    sizeOf _    = #{size      spAttachmentTimeline}
    peek ptr = do
        s <- #{peek spAttachmentTimeline, super} ptr
        fc <- #{peek spAttachmentTimeline, framesCount} ptr
        fs <- #{peek spAttachmentTimeline, frames} ptr
        si <- #{peek spAttachmentTimeline, slotIndex} ptr
        an <- #{peek spAttachmentTimeline, attachmentNames} ptr
        return (SpAttachmentTimeline s fc fs si an)
    poke ptr (SpAttachmentTimeline s fc fs si an) = do
        #{poke spAttachmentTimeline, super}           ptr s
        #{poke spAttachmentTimeline, framesCount}     ptr fc
        #{poke spAttachmentTimeline, frames}          ptr fs
        #{poke spAttachmentTimeline, slotIndex}       ptr si
        #{poke spAttachmentTimeline, attachmentNames} ptr an
instance Default SpAttachmentTimeline where
    def = SpAttachmentTimeline nullPtr 0 nullPtr 0 nullPtr






















typedef struct spAttachmentTimeline {
	spTimeline super;
	int const framesCount;
	float* const frames; /* time, ... */
	int slotIndex;
	const char** const attachmentNames;

#ifdef __cplusplus
	spAttachmentTimeline() :
		super(),
		framesCount(0),
		frames(0),
		slotIndex(0),
		attachmentNames(0) {
	}
#endif
} spAttachmentTimeline;




typedef struct spEventTimeline {
	spTimeline super;
	int const framesCount;
	float* const frames; /* time, ... */
	spEvent** const events;

#ifdef __cplusplus
	spEventTimeline() :
		super(),
		framesCount(0),
		frames(0),
		events(0) {
	}
#endif
} spEventTimeline;




typedef struct spDrawOrderTimeline {
	spTimeline super;
	int const framesCount;
	float* const frames; /* time, ... */
	const int** const drawOrders;
	int const slotsCount;
#ifdef __cplusplus
	spDrawOrderTimeline() :
		super(),
		framesCount(0),
		frames(0),
		drawOrders(0),
		slotsCount(0) {
	}
#endif
} spDrawOrderTimeline;




typedef struct spDeformTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, ... */
	int const frameVerticesCount;
	const float** const frameVertices;
	int slotIndex;
	spAttachment* attachment;

#ifdef __cplusplus
	spDeformTimeline() :
		super(),
		framesCount(0),
		frames(0),
		frameVerticesCount(0),
		frameVertices(0),
		slotIndex(0) {
	}
#endif
} spDeformTimeline;



typedef struct spIkConstraintTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, mix, bendDirection, ... */
	int ikConstraintIndex;

#ifdef __cplusplus
	spIkConstraintTimeline() :
		super(),
		framesCount(0),
		frames(0),
		ikConstraintIndex(0) {
	}
#endif
} spIkConstraintTimeline;




typedef struct spTransformConstraintTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */
	int transformConstraintIndex;

#ifdef __cplusplus
	spTransformConstraintTimeline() :
		super(),
		framesCount(0),
		frames(0),
		transformConstraintIndex(0) {
	}
#endif
} spTransformConstraintTimeline;




typedef struct spPathConstraintPositionTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */
	int pathConstraintIndex;

#ifdef __cplusplus
	spPathConstraintPositionTimeline() :
		super(),
		framesCount(0),
		frames(0),
		pathConstraintIndex(0) {
	}
#endif
} spPathConstraintPositionTimeline;




typedef struct spPathConstraintSpacingTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */
	int pathConstraintIndex;

#ifdef __cplusplus
	spPathConstraintSpacingTimeline() :
		super(),
		framesCount(0),
		frames(0),
		pathConstraintIndex(0) {
	}
#endif
} spPathConstraintSpacingTimeline;




typedef struct spPathConstraintMixTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */
	int pathConstraintIndex;

#ifdef __cplusplus
	spPathConstraintMixTimeline() :
		super(),
		framesCount(0),
		frames(0),
		pathConstraintIndex(0) {
	}
#endif
} spPathConstraintMixTimeline;
































































-- SpAnimation
-- -- -- -- -- --
foreign import ccall "spAnimation_create" spAnimation_create_FFI
    :: CString -- ^ name
    -> CInt -- ^ timelinesCount
    -> IO (Ptr SpAnimation)
foreign import ccall "spAnimation_dispose" spAnimation_dispose_FFI
    :: Ptr SpAnimation -- ^ self
    -> IO ()
foreign import ccall "spAnimation_apply" spAnimation_apply_FFI
    :: Ptr SpAnimation -- ^ self
    -> Ptr SpSkeleton -- ^ skeleton
    -> CFloat -- ^ lastTime
    -> CFloat -- ^ time
    -> CInt -- ^ loop
    -> Ptr (Ptr SpEvent) -- ^ events
    -> Ptr CInt -- ^ eventsCount
    -> CFloat -- ^ alpha
    -> CInt -- ^ (boolean) setupPose
    -> CInt -- ^ (boolean) mixingOut
    -> IO ()

-- SpTimeline
-- -- -- -- -- --
foreign import ccall "spTimeline_dispose" spTimeline_dispose_FFI
    :: Ptr SpTimeline -- ^ self
    -> IO ()
foreign import ccall "spTimeline_apply" spTimeline_apply_FFI
    :: Ptr SpTimeline -- ^ self
    -> Ptr SpSkeleton -- ^ skeleton
    -> CFloat -- ^ lastTime
    -> CFloat -- ^ time
    -> Ptr (Ptr SpEvent) -- ^ firedEvents
    -> Ptr CInt -- ^ eventsCount
    -> CFloat -- ^ alpha
    -> CInt -- ^ (boolean) setupPose
    -> CInt -- ^ (boolean) mixingOut
    -> IO ()
foreign import ccall "spTimeline_getPropertyId" spTimeline_getPropertyId_FFI
    :: Ptr SpTimeline -- ^ self
    -> IO CInt

-- SpCurveTimeline
-- -- -- -- -- --
foreign import ccall "spCurveTimeline_setLinear" spCurveTimeline_setLinear_FFI ::
    Ptr SpCurveTimeline -> CInt -> IO ()
foreign import ccall "spCurveTimeline_setStepped" spCurveTimeline_setStepped_FFI ::
    Ptr SpCurveTimeline -> CInt -> IO ()
foreign import ccall "spCurveTimeline_setCurve" spCurveTimeline_setCurve_FFI
    :: Ptr SpCurveTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ cx1
    -> CFloat -- ^ cy1
    -> CFloat -- ^ cx2
    -> CFloat -- ^ cy2
    -> IO ()
foreign import ccall "spCurveTimeline_getCurvePercent" spCurveTimeline_getCurvePercent_FFI
    :: Ptr SpCurveTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ percent
    -> IO CFloat

-- SpRotateTimeline
-- -- -- -- -- --
foreign import ccall "spRotateTimeline_create" spRotateTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpRotateTimeline)
foreign import ccall "spRotateTimeline_setFrame" spRotateTimeline_setFrame_FFI
    :: Ptr SpRotateTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ angle
    -> IO ()

-- SpTranslateTimeline
-- -- -- -- -- --
foreign import ccall "spTranslateTimeline_create" spTranslateTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpTranslateTimeline)
foreign import ccall "spTranslateTimeline_setFrame" spTranslateTimeline_setFrame_FFI
    :: Ptr SpTranslateTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO ()

-- SpScaleTimeline
-- -- -- -- -- --
foreign import ccall "spScaleTimeline_create" spScaleTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpScaleTimeline)
foreign import ccall "spScaleTimeline_setFrame" spScaleTimeline_setFrame _FFI
    :: Ptr SpScaleTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO ()

-- SpShearTimeline
-- -- -- -- -- --
foreign import ccall "spShearTimeline_create" spShearTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpShearTimeline)
foreign import ccall "spShearTimeline_setFrame" spShearTimeline_setFrame_FFI
    :: Ptr SpShearTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO ()

-- SpColorTimeline
-- -- -- -- -- --
foreign import ccall "spColorTimeline_create" spColorTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpColorTimeline)
foreign import ccall "spColorTimeline_setFrame" spColorTimeline_setFrame_FFI
    :: Ptr SpColorTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ r
    -> CFloat -- ^ g
    -> CFloat -- ^ b
    -> CFloat -- ^ a
    -> IO ()

-- SpAttachmentTimeline
-- -- -- -- -- --
foreign import ccall "spAttachmentTimeline_create" spAttachmentTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpAttachmentTimeline)
foreign import ccall "spAttachmentTimeline_setFrame" spAttachmentTimeline_setFrame_FFI
    :: Ptr SpAttachmentTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CString -- ^ attachmentName
    -> IO ()

-- SpEventTimeline
-- -- -- -- -- --
foreign import ccall "spEventTimeline_create" spEventTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpEventTimeline)
foreign import ccall "spEventTimeline_setFrame" spEventTimeline_setFrame_FFI
    :: Ptr SpEventTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> Ptr SpEvent -- ^ event
    -> IO ()

-- SpDrawOrderTimeline
-- -- -- -- -- --
foreign import ccall "spDrawOrderTimeline_create" spDrawOrderTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> CInt -- ^ slotsCount
    -> IO (Ptr SpDrawOrderTimeline)
foreign import ccall "spDrawOrderTimeline_setFrame" spDrawOrderTimeline_setFrame_FFI
    :: Ptr SpDrawOrderTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> Ptr CInt -- ^ drawOrder
    -> IO ()

-- SpDeformTimeline
-- -- -- -- -- --
foreign import ccall "spDeformTimeline_create" spDeformTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> CInt -- ^ frameVerticesCount
    -> IO (Ptr SpDeformTimeline)
foreign import ccall "spDeformTimeline_setFrame" spDeformTimeline_setFrame_FFI
    :: Ptr SpDeformTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> Ptr CFloat -- ^ vertices
    -> IO ()

-- SpIkConstraintTimeline
-- -- -- -- -- --
foreign import ccall "spIkConstraintTimeline_create" spIkConstraintTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpIkConstraintTimeline)
foreign import ccall "spIkConstraintTimeline_setFrame" spIkConstraintTimeline_setFrame_FFI
    :: Ptr SpIkConstraintTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ mix
    -> CInt -- ^ bendDirection
    -> IO ()

-- SpTransformConstraintTimeline
-- -- -- -- -- --
foreign import ccall "spTransformConstraintTimeline_create" spTransformConstraintTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpTransformConstraintTimeline)
foreign import ccall "spTransformConstraintTimeline_setFrame" spTransformConstraintTimeline_setFrame_FFI
    :: Ptr SpTransformConstraintTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ rotateMix
    -> CFloat -- ^ translateMix
    -> CFloat -- ^ scaleMix
    -> CFloat -- ^ shearMix
    -> IO ()

-- SpPathConstraintPositionTimeline
-- -- -- -- -- --
foreign import ccall "spPathConstraintPositionTimeline_create" spPathConstraintPositionTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpPathConstraintPositionTimeline)
foreign import ccall "spPathConstraintPositionTimeline_setFrame" spPathConstraintPositionTimeline_setFrame_FFI
    :: Ptr SpPathConstraintPositionTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ value
    -> IO ()

-- SpPathConstraintSpacingTimeline
-- -- -- -- -- --
foreign import ccall "spPathConstraintSpacingTimeline_create" spPathConstraintSpacingTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpPathConstraintSpacingTimeline)
foreign import ccall "spPathConstraintSpacingTimeline_setFrame" spPathConstraintSpacingTimeline_setFrame_FFI
    :: Ptr SpPathConstraintSpacingTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ value
    -> IO ()

-- SpPathConstraintMixTimeline
-- -- -- -- -- --
foreign import ccall "spPathConstraintMixTimeline_create" spPathConstraintMixTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO (Ptr SpPathConstraintMixTimeline)
foreign import ccall "spPathConstraintMixTimeline_setFrame" spPathConstraintMixTimeline_setFrame_FFI
    :: spPathConstraintMixTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ rotateMix
    -> CFloat -- ^ translateMix
    -> IO ()





pattern ROTATE_PREV_TIME :: CInt
pattern ROTATE_PREV_TIME = #{const ROTATE_PREV_TIME}
pattern ROTATE_PREV_ROTATION :: CInt
pattern ROTATE_PREV_ROTATION = #{const ROTATE_PREV_ROTATION}
pattern ROTATE_ROTATION :: CInt
pattern ROTATE_ROTATION = #{const ROTATE_ROTATION}
pattern ROTATE_ENTRIES :: CInt
pattern ROTATE_ENTRIES = #{const ROTATE_ENTRIES}
pattern TRANSLATE_ENTRIES :: CInt
pattern TRANSLATE_ENTRIES = #{const TRANSLATE_ENTRIES}
pattern COLOR_ENTRIES :: CInt
pattern COLOR_ENTRIES = #{const COLOR_ENTRIES}
pattern IKCONSTRAINT_ENTRIES :: CInt
pattern IKCONSTRAINT_ENTRIES = #{const IKCONSTRAINT_ENTRIES}
pattern TRANSFORMCONSTRAINT_ENTRIES :: CInt
pattern TRANSFORMCONSTRAINT_ENTRIES = #{const TRANSFORMCONSTRAINT_ENTRIES}
pattern PATHCONSTRAINTPOSITION_ENTRIES :: CInt
pattern PATHCONSTRAINTPOSITION_ENTRIES = #{const PATHCONSTRAINTPOSITION_ENTRIES}
pattern PATHCONSTRAINTSPACING_ENTRIES :: CInt
pattern PATHCONSTRAINTSPACING_ENTRIES = #{const PATHCONSTRAINTSPACING_ENTRIES}
pattern PATHCONSTRAINTMIX_ENTRIES :: CInt
pattern PATHCONSTRAINTMIX_ENTRIES = #{const PATHCONSTRAINTMIX_ENTRIES}



--
