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
    , SpAtlasAttachmentLoader(..)
    -- * spine/Attachment
    , SpAttachment(..)
    -- * spine/AttachmentLoader
    , SpAttachmentLoader(..)
    -- * spine/Bone
    , SpBone(..)
    -- * spine/BoneData
    , SpBoneData(..)
    -- * spine/BoundingBoxAttachment
    , SpBoundingBoxAttachment(..)
    -- * spine/Event
    , SpEvent(..)
    -- * spine/EventData
    , SpEventData(..)
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
    { spAnimation_name :: CString
    , spAnimation_duration :: CFloat
    , spAnimation_timelinesCount :: CInt
    , spAnimation_timelines :: Ptr ( Ptr SpTimeline )
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
    { spTimeline_type :: SpTimelineType
    , spTimeline_vtable :: Ptr ()
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
    { spCurveTimeline_super :: SpTimeline
    , spCurveTimeline_curves :: Ptr CFloat -- ^ type, x, y, ...
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
    { spBaseTimeline_super :: SpCurveTimeline
    , spBaseTimeline_framesCount :: CInt
    , spBaseTimeline_frames :: Ptr CFloat -- ^ time, angle, ... for rotate. time, x, y, ... for translate and scale.
    , spBaseTimeline_boneIndex :: CInt
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
    { spColorTimeline_super :: SpCurveTimeline
    , spColorTimeline_framesCount :: CInt
    , spColorTimeline_frames :: Ptr CFloat -- ^ time, r, g, b, a, ...
    , spColorTimeline_slotIndex :: CInt
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
    { spAttachmentTimeline_super :: SpTimeline
    , spAttachmentTimeline_framesCount :: CInt
    , spAttachmentTimeline_frames :: Ptr CFloat -- ^ time, ...
    , spAttachmentTimeline_slotIndex :: CInt
    , spAttachmentTimeline_attachmentNames :: Ptr CString
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
    { spEventTimeline_super :: SpTimeline
    , spEventTimeline_framesCount :: CInt
    , spEventTimeline_frames :: Ptr CFloat -- ^ time, ...
    , spEventTimeline_events :: Ptr ( Ptr SpEvent )
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
    { spDrawOrderTimeline_super :: SpTimeline
    , spDrawOrderTimeline_framesCount :: CInt
    , spDrawOrderTimeline_frames :: Ptr CFloat -- ^ time, ...
    , spDrawOrderTimeline_drawOrders :: Ptr ( Ptr CInt )
    , spDrawOrderTimeline_slotsCount :: CInt
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
    { spDeformTimeline_super :: SpCurveTimeline
    , spDeformTimeline_framesCount :: CInt
    , spDeformTimeline_frames :: Ptr CFloat -- ^ time, ...
    , spDeformTimeline_frameVerticesCount :: CInt
    , spDeformTimeline_frameVertices :: Ptr ( Ptr CFloat )
    , spDeformTimeline_slotIndex :: CInt
    , spDeformTimeline_attachment :: Ptr SpAttachment
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
    { spIkConstraintTimeline_super :: SpCurveTimeline
    , spIkConstraintTimeline_framesCount :: CInt
    , spIkConstraintTimeline_frames :: Ptr CFloat -- ^ time, mix, bendDirection, ...
    , spIkConstraintTimeline_ikConstraintIndex :: CInt
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
    { spTransformConstraintTimeline_super :: SpCurveTimeline
    , spTransformConstraintTimeline_framesCount :: CInt
    , spTransformConstraintTimeline_frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , spTransformConstraintTimeline_transformConstraintIndex :: CInt
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
    { spPathConstraintPositionTimeline_super :: SpCurveTimeline
    , spPathConstraintPositionTimeline_framesCount :: CInt
    , spPathConstraintPositionTimeline_frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , spPathConstraintPositionTimeline_pathConstraintIndex :: CInt
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
    { spPathConstraintSpacingTimeline_super :: SpCurveTimeline
    , spPathConstraintSpacingTimeline_framesCount :: CInt
    , spPathConstraintSpacingTimeline_frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , spPathConstraintSpacingTimeline_pathConstraintIndex :: CInt
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
    { spPathConstraintMixTimeline_super :: SpCurveTimeline
    , spPathConstraintMixTimeline_framesCount :: CInt
    , spPathConstraintMixTimeline_frames :: Ptr CFloat -- ^ time, rotate mix, translate mix, scale mix, shear mix, ...
    , spPathConstraintMixTimeline_pathConstraintIndex :: CInt
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
    { spTrackEntry_animation :: Ptr SpAnimation
    , spTrackEntry_next :: Ptr SpTrackEntry
    , spTrackEntry_mixingFrom :: Ptr SpTrackEntry
    , spTrackEntry_listener :: SpAnimationStateListener
    , spTrackEntry_trackIndex :: CInt
    , spTrackEntry_loop :: CInt -- ^ boolean
    , spTrackEntry_eventThreshold :: CFloat
    , spTrackEntry_attachmentThreshold :: CFloat
    , spTrackEntry_drawOrderThreshold :: CFloat
    , spTrackEntry_animationStart :: CFloat
    , spTrackEntry_animationEnd :: CFloat
    , spTrackEntry_animationLast :: CFloat
    , spTrackEntry_nextAnimationLast :: CFloat
    , spTrackEntry_delay :: CFloat
    , spTrackEntry_trackTime :: CFloat
    , spTrackEntry_trackLast :: CFloat
    , spTrackEntry_nextTrackLast :: CFloat
    , spTrackEntry_trackEnd :: CFloat
    , spTrackEntry_timeScale :: CFloat
    , spTrackEntry_alpha :: CFloat
    , spTrackEntry_mixTime :: CFloat
    , spTrackEntry_mixDuration :: CFloat
    , spTrackEntry_mixAlpha :: CFloat
    , spTrackEntry_timelinesFirst :: Ptr CInt -- ^ boolean
    , spTrackEntry_timelinesFirstCount :: CInt
    , spTrackEntry_timelinesRotation :: Ptr CFloat
    , spTrackEntry_timelinesRotationCount :: CInt
    , spTrackEntry_rendererObject :: Ptr ()
    , spTrackEntry_userData :: Ptr ()
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
    { spAnimationState_data :: Ptr SpAnimationStateData
    , spAnimationState_tracksCount :: CInt
    , spAnimationState_tracks :: Ptr ( Ptr SpTrackEntry )
    , spAnimationState_listener :: SpAnimationStateListener
    , spAnimationState_timeScale :: CFloat
    , spAnimationState_rendererObject :: Ptr ()
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
    { spAnimationStateData_skeletonData :: Ptr SpSkeletonData
    , spAnimationStateData_defaultMix :: CFloat
    , spAnimationStateData_entries :: Ptr ()
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
    { spAtlasPage_atlas :: Ptr SpAtlas
    , spAtlasPage_name :: CString
    , spAtlasPage_format :: SpAtlasFormat
    , spAtlasPage_minFilter :: SpAtlasFilter
    , spAtlasPage_magFilter :: SpAtlasFilter
    , spAtlasPage_uWrap :: SpAtlasWrap
    , spAtlasPage_vWrap :: SpAtlasWrap
    , spAtlasPage_rendererObject :: Ptr ()
    , spAtlasPage_width :: CInt
    , spAtlasPage_height :: CInt
    , spAtlasPage_next :: Ptr SpAtlasPage
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

-- | SpAtlasRegion
data SpAtlasRegion = SpAtlasRegion
    { spAtlasRegion_name :: CString
    , spAtlasRegion_x :: CInt
    , spAtlasRegion_y :: CInt
    , spAtlasRegion_width :: CInt
    , spAtlasRegion_height :: CInt
    , spAtlasRegion_u :: CFloat
    , spAtlasRegion_v :: CFloat
    , spAtlasRegion_u2 :: CFloat
    , spAtlasRegion_v2 :: CFloat
    , spAtlasRegion_offsetX :: CInt
    , spAtlasRegion_offsetY :: CInt
    , spAtlasRegion_originalWidth :: CInt
    , spAtlasRegion_originalHeight :: CInt
    , spAtlasRegion_index :: CInt
    , spAtlasRegion_rotate :: CInt -- ^ boolean
    , spAtlasRegion_flip :: CInt -- ^ boolean
    , spAtlasRegion_splits :: Ptr CInt
    , spAtlasRegion_pads :: Ptr CInt
    , spAtlasRegion_page :: Ptr SpAtlasPage
    , spAtlasRegion_next :: Ptr SpAtlasRegion
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

-- | SpAtlas
data SpAtlas = SpAtlas
    { spAtlas_pages :: Ptr SpAtlasPage
    , spAtlas_regions :: Ptr SpAtlasRegion
    , spAtlas_rendererObject :: Ptr ()
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

-- #####################
--  "spine/AtlasAttachmentLoader"
-- #####################

-- | SpAtlasAttachmentLoader
data SpAtlasAttachmentLoader = SpAtlasAttachmentLoader
    { spAtlasAttachmentLoader_super :: SpAttachmentLoader
    , spAtlasAttachmentLoader_atlas :: Ptr SpAtlas
    } deriving (Show, Eq)
instance Storable SpAtlasAttachmentLoader where
    alignment _ = #{alignment spAtlasAttachmentLoader}
    sizeOf _    = #{size spAtlasAttachmentLoader}
    peek ptr = do
        a <- #{peek spAtlasAttachmentLoader, super} ptr
        b <- #{peek spAtlasAttachmentLoader, atlas} ptr
        return (SpAtlasAttachmentLoader a b)
    poke ptr (SpAtlasAttachmentLoader a b) = do
        #{poke spAtlasAttachmentLoader, super} ptr a
        #{poke spAtlasAttachmentLoader, atlas} ptr b

-- #####################
--  "spine/Attachment"
-- #####################

-- | SpAttachment
data SpAttachment = SpAttachment
    { spAttachment_name :: CString
    , spAttachment_type :: SpAttachmentType
    , spAttachment_vtable :: Ptr ()
    , spAttachment_attachmentLoader :: Ptr SpAttachmentLoader
    } deriving (Show, Eq)
instance Storable SpAttachment where
    alignment _ = #{alignment spAttachment}
    sizeOf _    = #{size spAttachment}
    peek ptr = do
        a <- #{peek spAttachment, name} ptr
        b <- #{peek spAttachment, type} ptr
        c <- #{peek spAttachment, vtable} ptr
        d <- #{peek spAttachment, attachmentLoader} ptr
        return (SpAttachment a b c d)
    poke ptr (SpAttachment a b c d) = do
        #{poke spAttachment, name} ptr a
        #{poke spAttachment, type} ptr b
        #{poke spAttachment, vtable} ptr c
        #{poke spAttachment, attachmentLoader} ptr d

-- #####################
--  "spine/AttachmentLoader"
-- #####################

-- | SpAttachmentLoader
data SpAttachmentLoader = SpAttachmentLoader
    { spAttachmentLoader_error1 :: CString
    , spAttachmentLoader_error2 :: CString
    , spAttachmentLoader_vtable :: Ptr ()
    } deriving (Show, Eq)
instance Storable SpAttachmentLoader where
    alignment _ = #{alignment spAttachmentLoader}
    sizeOf _    = #{size spAttachmentLoader}
    peek ptr = do
        a <- #{peek spAttachmentLoader, error1} ptr
        b <- #{peek spAttachmentLoader, error2} ptr
        c <- #{peek spAttachmentLoader, vtable} ptr
        return (SpAttachmentLoader a b c)
    poke ptr (SpAttachmentLoader a b c) = do
        #{poke spAttachmentLoader, error1} ptr a
        #{poke spAttachmentLoader, error2} ptr b
        #{poke spAttachmentLoader, vtable} ptr c

-- #####################
--  "spine/Bone"
-- #####################

-- | SpBone
data SpBone = SpBone
    { spBone_data :: Ptr SpBoneData
    , spBone_skeleton :: Ptr SpSkeleton
    , spBone_parent :: Ptr SpBone
    , spBone_childrenCount :: CInt
    , spBone_children :: Ptr ( Ptr SpBone )
    , spBone_x :: CFloat
    , spBone_y :: CFloat
    , spBone_rotation :: CFloat
    , spBone_scaleX :: CFloat
    , spBone_scaleY :: CFloat
    , spBone_shearX :: CFloat
    , spBone_shearY :: CFloat
    , spBone_ax :: CFloat
    , spBone_ay :: CFloat
    , spBone_arotation :: CFloat
    , spBone_ascaleX :: CFloat
    , spBone_ascaleY :: CFloat
    , spBone_ashearX :: CFloat
    , spBone_ashearY :: CFloat
    , spBone_appliedValid :: CInt -- ^ boolean
    , spBone_a :: CFloat
    , spBone_b :: CFloat
    , spBone_worldX :: CFloat
    , spBone_c :: CFloat
    , spBone_d :: CFloat
    , spBone_worldY :: CFloat
    , spBone_sorted :: CInt -- ^ boolean
    } deriving (Show, Eq)
instance Storable SpBone where
    alignment _ = #{alignment spBone}
    sizeOf _    = #{size spBone}
    peek ptr = do
        a <- #{peek spBone, data} ptr
        b <- #{peek spBone, skeleton} ptr
        c <- #{peek spBone, parent} ptr
        d <- #{peek spBone, childrenCount} ptr
        e <- #{peek spBone, children} ptr
        f <- #{peek spBone, x} ptr
        g <- #{peek spBone, y} ptr
        h <- #{peek spBone, rotation} ptr
        i <- #{peek spBone, scaleX} ptr
        j <- #{peek spBone, scaleY} ptr
        k <- #{peek spBone, shearX} ptr
        l <- #{peek spBone, shearY} ptr
        m <- #{peek spBone, ax} ptr
        n <- #{peek spBone, ay} ptr
        o <- #{peek spBone, arotation} ptr
        p <- #{peek spBone, ascaleX} ptr
        q <- #{peek spBone, ascaleY} ptr
        r <- #{peek spBone, ashearX} ptr
        s <- #{peek spBone, ashearY} ptr
        t <- #{peek spBone, appliedValid} ptr
        u <- #{peek spBone, a} ptr
        v <- #{peek spBone, b} ptr
        w <- #{peek spBone, worldX} ptr
        x <- #{peek spBone, c} ptr
        y <- #{peek spBone, d} ptr
        z <- #{peek spBone, worldY} ptr
        a2 <- #{peek spBone, sorted} ptr
        return (SpBone a b c d e f g h i j k l m n o p q r s t u v w x y z a2)
    poke ptr (SpBone a b c d e f g h i j k l m n o p q r s t u v w x y z a2) = do
        #{poke spBone, data} ptr a
        #{poke spBone, skeleton} ptr b
        #{poke spBone, parent} ptr c
        #{poke spBone, childrenCount} ptr d
        #{poke spBone, children} ptr e
        #{poke spBone, x} ptr f
        #{poke spBone, y} ptr g
        #{poke spBone, rotation} ptr h
        #{poke spBone, scaleX} ptr i
        #{poke spBone, scaleY} ptr j
        #{poke spBone, shearX} ptr k
        #{poke spBone, shearY} ptr l
        #{poke spBone, ax} ptr m
        #{poke spBone, ay} ptr n
        #{poke spBone, arotation} ptr o
        #{poke spBone, ascaleX} ptr p
        #{poke spBone, ascaleY} ptr q
        #{poke spBone, ashearX} ptr r
        #{poke spBone, ashearY} ptr s
        #{poke spBone, appliedValid} ptr t
        #{poke spBone, a} ptr u
        #{poke spBone, b} ptr v
        #{poke spBone, worldX} ptr w
        #{poke spBone, c} ptr x
        #{poke spBone, d} ptr y
        #{poke spBone, worldY} ptr z
        #{poke spBone, sorted} ptr a2

-- #####################
--  "spine/BoneData"
-- #####################

-- | SpBoneData
data SpBoneData = SpBoneData
    { spBoneData_index :: CInt
    , spBoneData_name :: CString
    , spBoneData_parent :: Ptr SpBoneData
    , spBoneData_length :: CFloat
    , spBoneData_x :: CFloat
    , spBoneData_y :: CFloat
    , spBoneData_rotation :: CFloat
    , spBoneData_scaleX :: CFloat
    , spBoneData_scaleY :: CFloat
    , spBoneData_shearX :: CFloat
    , spBoneData_shearY :: CFloat
    , spBoneData_transformMode :: SpTransformMode
    } deriving (Show, Eq)
instance Storable SpBoneData where
    alignment _ = #{alignment spBoneData}
    sizeOf _    = #{size spBoneData}
    peek ptr = do
        a <- #{peek spBoneData, index} ptr
        b <- #{peek spBoneData, name} ptr
        c <- #{peek spBoneData, parent} ptr
        d <- #{peek spBoneData, length} ptr
        e <- #{peek spBoneData, x} ptr
        f <- #{peek spBoneData, y} ptr
        g <- #{peek spBoneData, rotation} ptr
        h <- #{peek spBoneData, scaleX} ptr
        i <- #{peek spBoneData, scaleY} ptr
        j <- #{peek spBoneData, shearX} ptr
        k <- #{peek spBoneData, shearY} ptr
        l <- #{peek spBoneData, transformMode} ptr
        return (SpBoneData a b c d e f g h i j k l)
    poke ptr (SpBoneData a b c d e f g h i j k l) = do
        #{poke spBoneData, index} ptr a
        #{poke spBoneData, name} ptr b
        #{poke spBoneData, parent} ptr c
        #{poke spBoneData, length} ptr d
        #{poke spBoneData, x} ptr e
        #{poke spBoneData, y} ptr f
        #{poke spBoneData, rotation} ptr g
        #{poke spBoneData, scaleX} ptr h
        #{poke spBoneData, scaleY} ptr i
        #{poke spBoneData, shearX} ptr j
        #{poke spBoneData, shearY} ptr k
        #{poke spBoneData, transformMode} ptr l

-- #####################
-- "spine/BoundingBoxAttachment.h"
-- #####################

-- | SpBoundingBoxAttachment
data SpBoundingBoxAttachment = SpBoundingBoxAttachment
    { spBoundingBoxAttachment_super :: SpVertexAttachment
    } deriving (Show, Eq)
instance Storable SpBoundingBoxAttachment where
    alignment _ = #{alignment spBoundingBoxAttachment}
    sizeOf _    = #{size spBoundingBoxAttachment}
    peek ptr = do
        a <- #{peek spBoundingBoxAttachment, super} ptr
        return (SpBoundingBoxAttachment a)
    poke ptr (SpBoundingBoxAttachment a) = do
        #{poke spBoundingBoxAttachment, super} ptr a

-- #####################
-- "spine/Event.h"
-- #####################

-- | SpEvent
data SpEvent = SpEvent
    { spEvent_data :: Ptr SpEventData
    , spEvent_time :: CFloat
    , spEvent_intValue :: CInt
    , spEvent_floatValue :: CFloat
    , spEvent_stringValue :: CString
    } deriving (Show, Eq)
instance Storable SpEvent where
    alignment _ = #{alignment spEvent}
    sizeOf _    = #{size spEvent}
    peek ptr = do
        a <- #{peek spEvent, data} ptr
        b <- #{peek spEvent, time} ptr
        c <- #{peek spEvent, intValue} ptr
        d <- #{peek spEvent, floatValue} ptr
        e <- #{peek spEvent, stringValue} ptr
        return (SpEvent a b c d e)
    poke ptr (SpEvent a b c d e) = do
        #{poke spEvent, data} ptr a
        #{poke spEvent, time} ptr b
        #{poke spEvent, intValue} ptr c
        #{poke spEvent, floatValue} ptr d
        #{poke spEvent, stringValue} ptr e

-- #####################
-- "spine/EventData.h"
-- #####################

-- | SpEventData
data SpEventData = SpEventData
    { spEventData_name :: CString
    , spEventData_intValue :: CInt
    , spEventData_floatValue :: CFloat
    , spEventData_stringValue :: CString
    } deriving (Show, Eq)
instance Storable SpEventData where
    alignment _ = #{alignment spEventData}
    sizeOf _    = #{size spEventData}
    peek ptr = do
        a <- #{peek spEventData, name} ptr
        b <- #{peek spEventData, intValue} ptr
        c <- #{peek spEventData, floatValue} ptr
        d <- #{peek spEventData, stringValue} ptr
        return (SpEventData a b c d)
    poke ptr (SpEventData a b c d) = do
        #{poke spEventData, name} ptr a
        #{poke spEventData, intValue} ptr b
        #{poke spEventData, floatValue} ptr c
        #{poke spEventData, stringValue} ptr d

-- #####################
-- "spine/IkConstraint.h"
-- #####################


-- #####################
-- "spine/IkConstraintData.h"
-- #####################


-- #####################
-- "spine/MeshAttachment.h"
-- #####################


-- #####################
-- "spine/PathAttachment.h"
-- #####################


-- #####################
-- "spine/PathConstraint.h"
-- #####################


-- #####################
-- "spine/PathConstraintData.h"
-- #####################


-- #####################
-- "spine/RegionAttachment.h"
-- #####################


-- #####################
-- "spine/Skeleton.h"
-- #####################


-- #####################
-- "spine/SkeletonBinary.h"
-- #####################


-- #####################
-- "spine/SkeletonBounds.h"
-- #####################


-- #####################
-- "spine/SkeletonData.h"
-- #####################


-- #####################
-- "spine/SkeletonJson.h"
-- #####################


-- #####################
-- "spine/Skin.h"
-- #####################


-- #####################
-- "spine/Slot.h"
-- #####################


-- #####################
-- "spine/SlotData.h"
-- #####################


-- #####################
-- "spine/TransformConstraint.h"
-- #####################


-- #####################
-- "spine/TransformConstraintData.h"
-- #####################


-- #####################
-- "spine/VertexAttachment.h"
-- #####################





--
