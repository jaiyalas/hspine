module Spine.Raw.InternalStruct(
    -- * spine/Animation
      SpAnimation(..)
    , SpTimeline(..)
    , SpCurveTimeline(..)
    , SpBaseTimeline(..)
    , SpColorTimeline(..)
    , SpAttachmentTimeline(..)
    , SpEventTimeline(..)
    , SpDrawOrderTimeline(..)
    , SpDeformTimeline(..)
    , SpIkConstraintTimeline(..)
    , SpTransformConstraintTimeline(..)
    , SpPathConstraintPositionTimeline(..)
    , SpPathConstraintSpacingTimeline(..)
    , SpPathConstraintMixTimeline(..)
    -- * spine/AnimationState
    , SpAnimationStateListener
    , SpTrackEntry(..)
    , SpAnimationState(..)
    -- * spine/AnimationStateData
    , SpAnimationStateData(..)
    -- * spine/Atlas
    , SpAtlasPage(..)
    , SpAtlas(..)
    , SpAtlasRegion(..)
    -- * spine/AtlasAttachmentLoader
    -- * spine/Attachment
    -- * spine/AttachmentLoader
    ) where
--
#include "spine/Animation.h"
#include "spine/AnimationState.h"
#include "spine/AnimationStateData.h"
#include "spine/Atlas.h"
#include "spine/AtlasAttachmentLoader.h"
#include "spine/Attachment.h"
#include "spine/AttachmentLoader.h"
#include "spine/Bone.h"
#include "spine/BoneData.h"
#include "spine/BoundingBoxAttachment.h"
#include "spine/Event.h"
#include "spine/EventData.h"
#include "spine/IkConstraint.h"
#include "spine/IkConstraintData.h"
#include "spine/MeshAttachment.h"
#include "spine/PathAttachment.h"
#include "spine/PathConstraint.h"
#include "spine/PathConstraintData.h"
#include "spine/RegionAttachment.h"
#include "spine/Skeleton.h"
#include "spine/SkeletonBinary.h"
#include "spine/SkeletonBounds.h"
#include "spine/SkeletonData.h"
#include "spine/SkeletonJson.h"
#include "spine/Skin.h"
#include "spine/Slot.h"
#include "spine/SlotData.h"
#include "spine/TransformConstraint.h"
#include "spine/TransformConstraintData.h"
#include "spine/VertexAttachment.h"
--
import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String
import Foreign.Storable
--
import Data.Default
import Spine.Raw.InternalEnum
--
#if __GLASGOW_HASKELL__ < 800
#let alignment t = "%lu", (unsigned long)offsetof(struct {char x__; t (y__); }, y__)
#endif
--

-- #####################
--  "spine/Animation"
-- #####################

-- | SpAnimation
data SpAnimation = SpAnimation
    { animationName :: CString
    , animationDuration :: CFloat
    , animationTimelinesCount :: CInt
    , animationTimelines :: Ptr ( Ptr SpTimeline )
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
    { timelineType :: SpTimelineType
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
    { ct_super :: SpTimeline
    , ct_curves :: Ptr CFloat -- ^ type, x, y, ...
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
    { bt_super :: SpCurveTimeline
    , bt_framesCount :: CInt
    , bt_frames :: Ptr CFloat -- ^ time, angle, ... for rotate. time, x, y, ... for translate and scale.
    , bt_boneIndex :: CInt
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
    { ct_super :: SpCurveTimeline
    , ct_framesCount :: CInt
    , ct_frames :: Ptr CFloat -- ^ time, r, g, b, a, ...
    , ct_slotIndex :: CInt
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
    { at_super :: SpTimeline
    , at_framesCount :: CInt
    , at_frames :: Ptr CFloat -- ^ time, ...
    , at_slotIndex :: CInt
    , at_attachmentNames :: Ptr CString
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
    { et_super :: SpTimeline
    , et_framesCount :: CInt
    , et_frames :: Ptr CFloat -- ^ time, ...
    , et_events :: Ptr ( Ptr SpEvent )
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
    { dot_super :: SpTimeline
    , dot_framesCount :: CInt
    , dot_frames :: Ptr CFloat -- ^ time, ...
    , dot_drawOrders :: Ptr ( Ptr CInt )
    , dot_slotsCount :: CInt
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
    { dt_super :: SpCurveTimeline
    , dt_framesCount :: CInt
    , dt_frames :: Ptr CFloat -- ^ time, ...
    , dt_frameVerticesCount :: CInt
    , dt_frameVertices :: Ptr ( Ptr CFloat )
    , dt_slotIndex :: CInt
    , dt_attachment :: Ptr SpAttachment
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
    { ict_super :: SpCurveTimeline
    , ict_framesCount :: CInt
    , ict_frames :: Ptr CFloat -- ^ time, mix, bendDirection, ...
    , ict_ikConstraintIndex :: CInt
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
    { tct_super :: SpCurveTimeline
    , tct_framesCount :: CInt
    , tct_frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , tct_transformConstraintIndex :: CInt
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
    { pcpt_super :: SpCurveTimeline
    , pcpt_framesCount :: CInt
    , pcpt_frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , pcpt_pathConstraintIndex :: CInt
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
    { pcst_super :: SpCurveTimeline
    , pcst_framesCount :: CInt
    , pcst_frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , pcst_pathConstraintIndex :: CInt
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
    { pcmt_super :: SpCurveTimeline
    , pcmt_framesCount :: CInt
    , pcmt_frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , pcmt_pathConstraintIndex :: CInt
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

-- #####################
--  "spine/AnimationState"
-- #####################

-- | SpAnimationStateListener
-- typedef void (*spAnimationStateListener)
--     (spAnimationState* state, spEventType type, spTrackEntry* entry, spEvent* event);
type SpAnimationStateListener
    =  Ptr SpAnimationState -- ^ state
    -> SpEventType -- ^ type
    -> Ptr SpTrackEntry -- ^ entry
    -> Ptr SpEvent -- ^ event
    -> IO ()

-- | SpTrackEntry
data SpTrackEntry = SpTrackEntry
    { te_animation :: Ptr SpAnimation
    , te_next :: Ptr SpTrackEntry
    , te_mixingFrom :: Ptr SpTrackEntry
    , te_listener :: SpAnimationStateListener
    , te_trackIndex :: CInt
    , te_loop :: CInt -- ^ boolean
    , te_eventThreshold :: CFloat
    , te_attachmentThreshold :: CFloat
    , te_drawOrderThreshold :: CFloat
    , te_animationStart :: CFloat
    , te_animationEnd :: CFloat
    , te_animationLast :: CFloat
    , te_nextAnimationLast :: CFloat
    , te_delay :: CFloat
    , te_trackTime :: CFloat
    , te_trackLast :: CFloat
    , te_nextTrackLast :: CFloat
    , te_trackEnd :: CFloat
    , te_timeScale :: CFloat
    , te_alpha :: CFloat
    , te_mixTime :: CFloat
    , te_mixDuration :: CFloat
    , te_mixAlpha :: CFloat
    , te_timelinesFirst :: Ptr CInt -- ^ boolean
    , te_timelinesFirstCount :: CInt
    , te_timelinesRotation :: Ptr CFloat
    , te_timelinesRotationCount :: CInt
    , te_rendererObject :: Ptr ()
    , te_userData :: Ptr ()
    } deriving (Show, Eq)
instance Storable SpTrackEntry where
    alignment _ = #{alignment spTrackEntry}
    sizeOf _    = #{size spTrackEntry}
    peek ptr = do
        a <- #{peek spTrackEntry, animation} ptr
        b <- #{peek spTrackEntry, next} ptr
        c <- #{peek spTrackEntry, mixingFrom} ptr
        d <- #{peek spTrackEntry, listener} ptr
        e <- #{peek spTrackEntry, trackIndex} ptr
        f <- #{peek spTrackEntry, loop} ptr
        g <- #{peek spTrackEntry, eventThreshold} ptr
        h <- #{peek spTrackEntry, attachmentThreshold} ptr
        i <- #{peek spTrackEntry, drawOrderThreshold} ptr
        j <- #{peek spTrackEntry, animationStart} ptr
        k <- #{peek spTrackEntry, animationEnd} ptr
        l <- #{peek spTrackEntry, animationLast} ptr
        m <- #{peek spTrackEntry, nextAnimationLast} ptr
        n <- #{peek spTrackEntry, delay} ptr
        o <- #{peek spTrackEntry, trackTime} ptr
        p <- #{peek spTrackEntry, trackLast} ptr
        q <- #{peek spTrackEntry, nextTrackLast} ptr
        r <- #{peek spTrackEntry, trackEnd} ptr
        s <- #{peek spTrackEntry, timeScale} ptr
        t <- #{peek spTrackEntry, alpha} ptr
        u <- #{peek spTrackEntry, mixTime} ptr
        v <- #{peek spTrackEntry, mixDuration} ptr
        w <- #{peek spTrackEntry, mixAlpha} ptr
        x <- #{peek spTrackEntry, timelinesFirst} ptr
        y <- #{peek spTrackEntry, timelinesFirstCount} ptr
        z <- #{peek spTrackEntry, timelinesRotation} ptr
        a2 <- #{peek spTrackEntry, timelinesRotationCount} ptr
        b2 <- #{peek spTrackEntry, rendererObject} ptr
        c2 <- #{peek spTrackEntry, userData} ptr
        return (SpTrackEntry a b c d e f g h i j k l m n o p q r s t u v w x y z a2 b2 c2)
    poke ptr (SpTrackEntry a b c d e f g h i j k l m n o p q r s t u v w x y z a2 b2 c2) = do
        #{poke spTrackEntry, animation} ptr a
        #{poke spTrackEntry, next} ptr b
        #{poke spTrackEntry, mixingFrom} ptr c
        #{poke spTrackEntry, listener} ptr d
        #{poke spTrackEntry, trackIndex} ptr e
        #{poke spTrackEntry, loop} ptr f
        #{poke spTrackEntry, eventThreshold} ptr g
        #{poke spTrackEntry, attachmentThreshold} ptr h
        #{poke spTrackEntry, drawOrderThreshold} ptr i
        #{poke spTrackEntry, animationStart} ptr j
        #{poke spTrackEntry, animationEnd} ptr k
        #{poke spTrackEntry, animationLast} ptr l
        #{poke spTrackEntry, nextAnimationLast} ptr m
        #{poke spTrackEntry, delay} ptr n
        #{poke spTrackEntry, trackTime} ptr o
        #{poke spTrackEntry, trackLast} ptr p
        #{poke spTrackEntry, nextTrackLast} ptr q
        #{poke spTrackEntry, trackEnd} ptr r
        #{poke spTrackEntry, timeScale} ptr s
        #{poke spTrackEntry, alpha} ptr t
        #{poke spTrackEntry, mixTime} ptr u
        #{poke spTrackEntry, mixDuration} ptr v
        #{poke spTrackEntry, mixAlpha} ptr w
        #{poke spTrackEntry, timelinesFirst} ptr x
        #{poke spTrackEntry, timelinesFirstCount} ptr y
        #{poke spTrackEntry, timelinesRotation} ptr z
        #{poke spTrackEntry, timelinesRotationCount} ptr a2
        #{poke spTrackEntry, rendererObject} ptr b2
        #{poke spTrackEntry, userData} ptr c2

-- | SpAnimationState
data SpAnimationState = SpAnimationState
    { at_stateData :: Ptr SpAnimationStateData
    , at_tracksCount :: CInt
    , at_tracks :: Ptr ( Ptr SpTrackEntry )
    , at_listener :: SpAnimationStateListener
    , at_timeScale :: CFloat
    , at_rendererObject :: Ptr ()
    } deriving (Show, Eq)
instance Storable SpAnimationState where
    alignment _ = #{alignment spAnimationState}
    sizeOf _    = #{size spAnimationState}
    peek ptr = do
        a <- #{peek spAnimationState, data} ptr
        b <- #{peek spAnimationState, tracksCount} ptr
        c <- #{peek spAnimationState, tracks} ptr
        d <- #{peek spAnimationState, listener} ptr
        e <- #{peek spAnimationState, timeScale} ptr
        f <- #{peek spAnimationState, rendererObject} ptr
        return (SpAnimationState a b c d e f)
    poke ptr (SpAnimationState a b c d e f) = do
        #{poke spAnimationState, data} ptr a
        #{poke spAnimationState, tracksCount} ptr b
        #{poke spAnimationState, tracks} ptr c
        #{poke spAnimationState, listener} ptr d
        #{poke spAnimationState, timeScale} ptr e
        #{poke spAnimationState, rendererObject} ptr f

-- #####################
--  "spine/AnimationStateData"
-- #####################

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

-- #####################
--  "spine/Atlas"
-- #####################

-- | SpAtlasPage
data SpAtlasPage = SpAtlasPage
    { ap_atlas :: Ptr SpAtlas
    , ap_name :: CString
    , ap_format :: SpAtlasFormat
    , ap_minFilter :: SpAtlasFilter
    , ap_magFilter :: SpAtlasFilter
    , ap_uWrap :: SpAtlasWrap
    , ap_vWrap :: SpAtlasWrap
    , ap_rendererObject :: Ptr ()
    , ap_width :: CInt
    , ap_height :: CInt
    , ap_next :: Ptr SpAtlasPage
    } deriving (Show, Eq)
instance Storable SpAtlasPage where
    alignment _ = #{alignment spAtlasPage}
    sizeOf _    = #{size spAtlasPage}
    peek ptr = do
        a <- #{peek spAtlasPage, atlas} ptr
        b <- #{peek spAtlasPage, name} ptr
        c <- #{peek spAtlasPage, format} ptr
        d <- #{peek spAtlasPage, minFilter} ptr
        e <- #{peek spAtlasPage, magFilter} ptr
        f <- #{peek spAtlasPage, uWrap} ptr
        g <- #{peek spAtlasPage, vWrap} ptr
        h <- #{peek spAtlasPage, rendererObject} ptr
        i <- #{peek spAtlasPage, width} ptr
        j <- #{peek spAtlasPage, height} ptr
        k <- #{peek spAtlasPage, next} ptr
        return (SpAtlasPage a b c d e f g h i j k)
    poke ptr (SpAtlasPage a b c d e f g h i j k) = do
        #{poke spAtlasPage, atlas} ptr a
        #{poke spAtlasPage, name} ptr b
        #{poke spAtlasPage, format} ptr c
        #{poke spAtlasPage, minFilter} ptr d
        #{poke spAtlasPage, magFilter} ptr e
        #{poke spAtlasPage, uWrap} ptr f
        #{poke spAtlasPage, vWrap} ptr g
        #{poke spAtlasPage, rendererObject} ptr h
        #{poke spAtlasPage, width} ptr i
        #{poke spAtlasPage, height} ptr j
        #{poke spAtlasPage, next} ptr k

-- | SpAtlas
data SpAtlas = SpAtlas
    { atlasPages :: Ptr SpAtlasPage
    , atlasRegions :: Ptr SpAtlasRegion
    , atlasRendererObject :: Ptr ()
    } deriving (Show, Eq)
instance Storable SpAtlas where
    alignment _ = #{alignment spAtlas}
    sizeOf _    = #{size spAtlas}
    peek ptr = do
        a <- #{peek spAtlas, pages} ptr
        b <- #{peek spAtlas, regions} ptr
        c <- #{peek spAtlas, rendererObject} ptr
        return (SpAtlas a b c)
    poke ptr (SpAtlas a b c) = do
        #{poke spAtlas, pages} ptr a
        #{poke spAtlas, regions} ptr b
        #{poke spAtlas, rendererObject} ptr c

-- | SpAtlasRegion
data SpAtlasRegion = SpAtlasRegion
    { ar_name :: CString
    , ar_x :: CInt
    , ar_y :: CInt
    , ar_width :: CInt
    , ar_height :: CInt
    , ar_u :: CFloat
    , ar_v :: CFloat
    , ar_u2 :: CFloat
    , ar_v2 :: CFloat
    , ar_offsetX :: CInt
    , ar_offsetY :: CInt
    , ar_originalWidth :: CInt
    , ar_originalHeight :: CInt
    , ar_index :: CInt
    , ar_rotate :: CInt -- ^ boolean
    , ar_flip :: CInt -- ^ boolean
    , ar_splits :: Ptr CInt
    , ar_pads :: Ptr CInt
    , ar_page :: Ptr SpAtlasPage
    , ar_next :: Ptr SpAtlasRegion
    } deriving (Show, Eq)
instance Storable SpAtlasRegion where
    alignment _ = #{alignment spAtlasRegion}
    sizeOf _    = #{size spAtlasRegion}
    peek ptr = do
        a <- #{peek spAtlasRegion, name} ptr
        b <- #{peek spAtlasRegion, x} ptr
        c <- #{peek spAtlasRegion, y} ptr
        d <- #{peek spAtlasRegion, width} ptr
        e <- #{peek spAtlasRegion, height} ptr
        f <- #{peek spAtlasRegion, u} ptr
        g <- #{peek spAtlasRegion, v} ptr
        h <- #{peek spAtlasRegion, u2} ptr
        i <- #{peek spAtlasRegion, v2} ptr
        j <- #{peek spAtlasRegion, offsetX} ptr
        k <- #{peek spAtlasRegion, offsetY} ptr
        l <- #{peek spAtlasRegion, originalWidth} ptr
        m <- #{peek spAtlasRegion, originalHeight} ptr
        n <- #{peek spAtlasRegion, index} ptr
        o <- #{peek spAtlasRegion, rotate} ptr
        p <- #{peek spAtlasRegion, flip} ptr
        q <- #{peek spAtlasRegion, splits} ptr
        r <- #{peek spAtlasRegion, pads} ptr
        s <- #{peek spAtlasRegion, page} ptr
        t <- #{peek spAtlasRegion, next} ptr
        return (SpAtlasRegion a b c d e f g h i j k l m n o p q r s t)
    poke ptr (SpAtlasRegion a b c d e f g h i j k l m n o p q r s t) = do
        #{poke spAtlasRegion, name} ptr a
        #{poke spAtlasRegion, x} ptr b
        #{poke spAtlasRegion, y} ptr c
        #{poke spAtlasRegion, width} ptr d
        #{poke spAtlasRegion, height} ptr e
        #{poke spAtlasRegion, u} ptr f
        #{poke spAtlasRegion, v} ptr g
        #{poke spAtlasRegion, u2} ptr h
        #{poke spAtlasRegion, v2} ptr i
        #{poke spAtlasRegion, offsetX} ptr j
        #{poke spAtlasRegion, offsetY} ptr k
        #{poke spAtlasRegion, originalWidth} ptr l
        #{poke spAtlasRegion, originalHeight} ptr m
        #{poke spAtlasRegion, index} ptr n
        #{poke spAtlasRegion, rotate} ptr o
        #{poke spAtlasRegion, flip} ptr p
        #{poke spAtlasRegion, splits} ptr q
        #{poke spAtlasRegion, pads} ptr r
        #{poke spAtlasRegion, page} ptr s
        #{poke spAtlasRegion, next} ptr t

--  "spine/AtlasAttachmentLoader"



--  "spine/Attachment"



--  "spine/AttachmentLoader"



--  "spine/Bone"



--  "spine/BoneData"

data SpBoneData = SpBoneData
    { spBoneData_index    :: CInt
    , spBoneData_name     :: CString
    , spBoneData_parent   :: Ptr SpBoneData
    , spBoneData_length   :: CFloat
    , spBoneData_x        :: CFloat
    , spBoneData_y        :: CFloat
    , spBoneData_rotation :: CFloat
    , spBoneData_scaleX   :: CFloat
    , spBoneData_scaleY   :: CFloat
    , spBoneData_shearX   :: CFloat
    , spBoneData_shearY   :: CFloat
    , spBoneData_transformMode :: TransformMode
    } deriving (Show, Eq)
instance Storable SpBoneData where
    alignment _ = #{alignment spBoneData}
    sizeOf _ = #{size spBoneData}
    peek ptr = do
        i <-   #{peek spBoneData, index} ptr
        n <-   #{peek spBoneData, name} ptr
        p <-   #{peek spBoneData, parent} ptr
        l <-   #{peek spBoneData, length} ptr
        x <-   #{peek spBoneData, x} ptr
        y <-   #{peek spBoneData, y} ptr
        r <-   #{peek spBoneData, rotation} ptr
        sx <-  #{peek spBoneData, scaleX} ptr
        sy <-  #{peek spBoneData, scaleY} ptr
        shx <- #{peek spBoneData, shearX} ptr
        shy <- #{peek spBoneData, shearY} ptr
        t <-   #{peek spBoneData, transformMode} ptr
        return (SpBoneData i n p l x y r sx sy shx shy t)
    poke ptr (SpBoneData i n p l x y r sx sy shx shy t) = do
        #{poke spBoneData, index} ptr i
        #{poke spBoneData, name} ptr n
        #{poke spBoneData, parent} ptr p
        #{poke spBoneData, length} ptr l
        #{poke spBoneData, x} ptr x
        #{poke spBoneData, y} ptr y
        #{poke spBoneData, rotation} ptr r
        #{poke spBoneData, scaleX} ptr sx
        #{poke spBoneData, scaleY} ptr sy
        #{poke spBoneData, shearX} ptr shx
        #{poke spBoneData, shearY} ptr shy
        #{poke spBoneData, transformMode} ptr t
instance Default SpBoneData where
    def = SpBoneData 0 nullPtr nullPtr 0 0 0 0 0 0 0 0 TRANSFORMMODE_NORMAL

-- "spine/BoneData.h"



-- "spine/BoundingBoxAttachment.h"



-- "spine/Event.h"



-- "spine/EventData.h"



-- "spine/IkConstraint.h"



-- "spine/IkConstraintData.h"



-- "spine/MeshAttachment.h"



-- "spine/PathAttachment.h"



-- "spine/PathConstraint.h"



-- "spine/PathConstraintData.h"



-- "spine/RegionAttachment.h"



-- "spine/Skeleton.h"



-- "spine/SkeletonBinary.h"



-- "spine/SkeletonBounds.h"



-- "spine/SkeletonData.h"



-- "spine/SkeletonJson.h"



-- "spine/Skin.h"



-- "spine/Slot.h"



-- "spine/SlotData.h"



-- "spine/TransformConstraint.h"



-- "spine/TransformConstraintData.h"



-- "spine/VertexAttachment.h"
