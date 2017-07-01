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
    -- ** extended SpBaseTimeline
    , SpRotateTimeline
    , SpTranslateTimeline
    , SpScaleTimeline
    , SpShearTimeline
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
    -- * spine/IkConstraint.h
    , SpIkConstraint(..)
    -- * spine/IkConstraintData.h
    , SpIkConstraintData(..)
    -- * spine/MeshAttachment.h
    , SpMeshAttachment(..)
    -- * spine/PathAttachment.h
    , SpPathAttachment(..)
    -- * spine/PathConstraint.h
    , SpPathConstraint(..)
    -- * spine/PathConstraintData.h
    , SpPathConstraintData(..)
    -- * spine/RegionAttachment.h
    , SpRegionAttachment(..)
    -- * spine/Skeleton.h
    , SpSkeleton(..)
    -- * spine/SkeletonBinary.h
    , SpSkeletonBinary(..)
    -- * spine/SkeletonBounds.h
    , SpPolygon(..)
    , SpSkeletonBounds(..)
    -- * spine/SkeletonData.h
    , SpSkeletonData(..)
    -- * spine/SkeletonJson.h
    , SpSkeletonJson(..)
    -- * spine/Skin.h
    , SpSkin(..)
    -- * spine/Slot.h
    , SpSlot(..)
    -- * spine/SlotData.h
    , SpSlotData(..)
    -- * spine/TransformConstraint.h
    , SpTransformConstraint(..)
    -- * spine/TransformConstraintData.h
    , SpTransformConstraintData(..)
    -- * spine/VertexAttachment.h
    , SpVertexAttachment(..)
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
import Foreign.C
import Foreign.Ptr
import Foreign.Storable
--
-- import Data.Default
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
    , spTrackEntry_listener :: FunPtr SpAnimationStateListener
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
    , spAnimationState_listener :: FunPtr SpAnimationStateListener
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

-- | SpIkConstraint
data SpIkConstraint = SpIkConstraint
    { spIkConstraint_data :: Ptr SpIkConstraintData
    , spIkConstraint_bonesCount :: CInt
    , spIkConstraint_bones :: Ptr ( Ptr SpBone )
    , spIkConstraint_target :: Ptr SpBone
    , spIkConstraint_bendDirection :: CInt
    , spIkConstraint_mix :: CFloat
    } deriving (Show, Eq)
instance Storable SpIkConstraint where
    alignment _ = #{alignment spIkConstraint}
    sizeOf _    = #{size spIkConstraint}
    peek ptr = do
        a <- #{peek spIkConstraint, data} ptr
        b <- #{peek spIkConstraint, bonesCount} ptr
        c <- #{peek spIkConstraint, bones} ptr
        d <- #{peek spIkConstraint, target} ptr
        e <- #{peek spIkConstraint, bendDirection} ptr
        f <- #{peek spIkConstraint, mix} ptr
        return (SpIkConstraint a b c d e f)
    poke ptr (SpIkConstraint a b c d e f) = do
        #{poke spIkConstraint, data} ptr a
        #{poke spIkConstraint, bonesCount} ptr b
        #{poke spIkConstraint, bones} ptr c
        #{poke spIkConstraint, target} ptr d
        #{poke spIkConstraint, bendDirection} ptr e
        #{poke spIkConstraint, mix} ptr f

-- #####################
-- "spine/IkConstraintData.h"
-- #####################

-- | SpIkConstraintData
data SpIkConstraintData = SpIkConstraintData
    { spIkConstraintData_name :: CString
    , spIkConstraintData_order :: CInt
    , spIkConstraintData_bonesCount :: CInt
    , spIkConstraintData_bones :: Ptr ( Ptr SpBoneData )
    , spIkConstraintData_target :: Ptr SpBoneData
    , spIkConstraintData_bendDirection :: CInt
    , spIkConstraintData_mix :: CFloat
    } deriving (Show, Eq)
instance Storable SpIkConstraintData where
    alignment _ = #{alignment spIkConstraintData}
    sizeOf _    = #{size spIkConstraintData}
    peek ptr = do
        a <- #{peek spIkConstraintData, name} ptr
        b <- #{peek spIkConstraintData, order} ptr
        c <- #{peek spIkConstraintData, bonesCount} ptr
        d <- #{peek spIkConstraintData, bones} ptr
        e <- #{peek spIkConstraintData, target} ptr
        f <- #{peek spIkConstraintData, bendDirection} ptr
        g <- #{peek spIkConstraintData, mix} ptr
        return (SpIkConstraintData a b c d e f g)
    poke ptr (SpIkConstraintData a b c d e f g) = do
        #{poke spIkConstraintData, name} ptr a
        #{poke spIkConstraintData, order} ptr b
        #{poke spIkConstraintData, bonesCount} ptr c
        #{poke spIkConstraintData, bones} ptr d
        #{poke spIkConstraintData, target} ptr e
        #{poke spIkConstraintData, bendDirection} ptr f
        #{poke spIkConstraintData, mix} ptr g

-- #####################
-- "spine/MeshAttachment.h"
-- #####################

-- | SpMeshAttachment
data SpMeshAttachment = SpMeshAttachment
    { spMeshAttachment_super :: SpVertexAttachment
    , spMeshAttachment_rendererObject :: Ptr ()
    , spMeshAttachment_regionOffsetX :: CInt -- ^ Pixels stripped from the bottom left, unrotated.
    , spMeshAttachment_regionOffsetY :: CInt -- ^ Pixels stripped from the bottom left, unrotated.
    , spMeshAttachment_regionWidth :: CInt -- ^ Unrotated, stripped pixel size.
    , spMeshAttachment_regionHeight :: CInt -- ^ Unrotated, stripped pixel size.
    , spMeshAttachment_regionOriginalWidth :: CInt -- ^ Unrotated, unstripped pixel size.
    , spMeshAttachment_regionOriginalHeight :: CInt -- ^ Unrotated, unstripped pixel size.
    , spMeshAttachment_regionU :: CFloat
    , spMeshAttachment_regionV :: CFloat
    , spMeshAttachment_regionU2 :: CFloat
    , spMeshAttachment_regionV2 :: CFloat
    , spMeshAttachment_regionRotate :: CInt -- ^ bool
    , spMeshAttachment_path :: CString
    , spMeshAttachment_regionUVs :: Ptr CFloat
    , spMeshAttachment_uvs :: Ptr CFloat
    , spMeshAttachment_trianglesCount :: CInt
    , spMeshAttachment_triangles :: Ptr CUShort
    , spMeshAttachment_r :: CFloat
    , spMeshAttachment_g :: CFloat
    , spMeshAttachment_b :: CFloat
    , spMeshAttachment_a :: CFloat
    , spMeshAttachment_hullLength :: CInt
    , spMeshAttachment_parentMesh :: Ptr SpMeshAttachment
    , spMeshAttachment_inheritDeform :: CInt -- ^ boolean
    , spMeshAttachment_edgesCount :: CInt -- ^ Nonessential.
    , spMeshAttachment_edges :: Ptr CInt -- ^ Nonessential.
    , spMeshAttachment_width :: CFloat -- ^ Nonessential.
    , spMeshAttachment_height :: CFloat -- ^ Nonessential.
    } deriving (Show, Eq)
instance Storable SpMeshAttachment where
    alignment _ = #{alignment spMeshAttachment}
    sizeOf _    = #{size spMeshAttachment}
    peek ptr = do
        a <- #{peek spMeshAttachment, super} ptr
        b <- #{peek spMeshAttachment, rendererObject} ptr
        c <- #{peek spMeshAttachment, regionOffsetX} ptr
        d <- #{peek spMeshAttachment, regionOffsetY} ptr
        e <- #{peek spMeshAttachment, regionWidth} ptr
        f <- #{peek spMeshAttachment, regionHeight} ptr
        g <- #{peek spMeshAttachment, regionOriginalWidth} ptr
        h <- #{peek spMeshAttachment, regionOriginalHeight} ptr
        i <- #{peek spMeshAttachment, regionU} ptr
        j <- #{peek spMeshAttachment, regionV} ptr
        k <- #{peek spMeshAttachment, regionU2} ptr
        l <- #{peek spMeshAttachment, regionV2} ptr
        m <- #{peek spMeshAttachment, regionRotate} ptr
        n <- #{peek spMeshAttachment, path} ptr
        o <- #{peek spMeshAttachment, regionUVs} ptr
        p <- #{peek spMeshAttachment, uvs} ptr
        q <- #{peek spMeshAttachment, trianglesCount} ptr
        r <- #{peek spMeshAttachment, triangles} ptr
        s <- #{peek spMeshAttachment, r} ptr
        t <- #{peek spMeshAttachment, g} ptr
        u <- #{peek spMeshAttachment, b} ptr
        v <- #{peek spMeshAttachment, a} ptr
        w <- #{peek spMeshAttachment, hullLength} ptr
        x <- #{peek spMeshAttachment, parentMesh} ptr
        y <- #{peek spMeshAttachment, inheritDeform} ptr
        z <- #{peek spMeshAttachment, edgesCount} ptr
        a2 <- #{peek spMeshAttachment, edges} ptr
        b2 <- #{peek spMeshAttachment, width} ptr
        c2 <- #{peek spMeshAttachment, height} ptr
        return (SpMeshAttachment a b c d e f g h i j k l m n o p q r s t u v w x y z a2 b2 c2)
    poke ptr (SpMeshAttachment a b c d e f g h i j k l m n o p q r s t u v w x y z a2 b2 c2) = do
        #{poke spMeshAttachment, super} ptr a
        #{poke spMeshAttachment, rendererObject} ptr b
        #{poke spMeshAttachment, regionOffsetX} ptr c
        #{poke spMeshAttachment, regionOffsetY} ptr d
        #{poke spMeshAttachment, regionWidth} ptr e
        #{poke spMeshAttachment, regionHeight} ptr f
        #{poke spMeshAttachment, regionOriginalWidth} ptr g
        #{poke spMeshAttachment, regionOriginalHeight} ptr h
        #{poke spMeshAttachment, regionU} ptr i
        #{poke spMeshAttachment, regionV} ptr j
        #{poke spMeshAttachment, regionU2} ptr k
        #{poke spMeshAttachment, regionV2} ptr l
        #{poke spMeshAttachment, regionRotate} ptr m
        #{poke spMeshAttachment, path} ptr n
        #{poke spMeshAttachment, regionUVs} ptr o
        #{poke spMeshAttachment, uvs} ptr p
        #{poke spMeshAttachment, trianglesCount} ptr q
        #{poke spMeshAttachment, triangles} ptr r
        #{poke spMeshAttachment, r} ptr s
        #{poke spMeshAttachment, g} ptr t
        #{poke spMeshAttachment, b} ptr u
        #{poke spMeshAttachment, a} ptr v
        #{poke spMeshAttachment, hullLength} ptr w
        #{poke spMeshAttachment, parentMesh} ptr x
        #{poke spMeshAttachment, inheritDeform} ptr y
        #{poke spMeshAttachment, edgesCount} ptr z
        #{poke spMeshAttachment, edges} ptr a2
        #{poke spMeshAttachment, width} ptr b2
        #{poke spMeshAttachment, height} ptr c2

-- #####################
-- "spine/PathAttachment.h"
-- #####################

-- | SpPathAttachment
data SpPathAttachment = SpPathAttachment
    { spPathAttachment_super :: SpVertexAttachment
    , spPathAttachment_lengthsLength :: CInt
    , spPathAttachment_lengths :: Ptr CFloat
    , spPathAttachment_closed :: CInt -- ^ boolean
    , spPathAttachment_constantSpeed :: CInt
    } deriving (Show, Eq)
instance Storable SpPathAttachment where
    alignment _ = #{alignment spPathAttachment}
    sizeOf _    = #{size spPathAttachment}
    peek ptr = do
        a <- #{peek spPathAttachment, super} ptr
        b <- #{peek spPathAttachment, lengthsLength} ptr
        c <- #{peek spPathAttachment, lengths} ptr
        d <- #{peek spPathAttachment, closed} ptr
        e <- #{peek spPathAttachment, constantSpeed} ptr
        return (SpPathAttachment a b c d e)
    poke ptr (SpPathAttachment a b c d e) = do
        #{poke spPathAttachment, super} ptr a
        #{poke spPathAttachment, lengthsLength} ptr b
        #{poke spPathAttachment, lengths} ptr c
        #{poke spPathAttachment, closed} ptr d
        #{poke spPathAttachment, constantSpeed} ptr e

-- #####################
-- "spine/PathConstraint.h"
-- #####################

-- | SpPathConstraint
data SpPathConstraint = SpPathConstraint
    { spPathConstraint_data :: Ptr SpPathConstraintData
    , spPathConstraint_bonesCount :: CInt
    , spPathConstraint_bones :: Ptr ( Ptr SpBone )
    , spPathConstraint_target :: Ptr SpSlot
    , spPathConstraint_position :: CFloat
    , spPathConstraint_spacing :: CFloat
    , spPathConstraint_rotateMix :: CFloat
    , spPathConstraint_translateMix :: CFloat
    , spPathConstraint_spacesCount :: CInt
    , spPathConstraint_spaces :: Ptr CFloat
    , spPathConstraint_positionsCount :: CInt
    , spPathConstraint_positions :: Ptr CFloat
    , spPathConstraint_worldCount :: CInt
    , spPathConstraint_world :: Ptr CFloat
    , spPathConstraint_curvesCount :: CInt
    , spPathConstraint_curves :: Ptr CFloat
    , spPathConstraint_lengthsCount :: CInt
    , spPathConstraint_lengths :: Ptr CFloat
    , spPathConstraint_segments :: Ptr CFloat -- ^ float segments[10]
    } deriving (Show, Eq)
instance Storable SpPathConstraint where
    alignment _ = #{alignment spPathConstraint}
    sizeOf _    = #{size spPathConstraint}
    peek ptr = do
        a <- #{peek spPathConstraint, data} ptr
        b <- #{peek spPathConstraint, bonesCount} ptr
        c <- #{peek spPathConstraint, bones} ptr
        d <- #{peek spPathConstraint, target} ptr
        e <- #{peek spPathConstraint, position} ptr
        f <- #{peek spPathConstraint, spacing} ptr
        g <- #{peek spPathConstraint, rotateMix} ptr
        h <- #{peek spPathConstraint, translateMix} ptr
        i <- #{peek spPathConstraint, spacesCount} ptr
        j <- #{peek spPathConstraint, spaces} ptr
        k <- #{peek spPathConstraint, positionsCount} ptr
        l <- #{peek spPathConstraint, positions} ptr
        m <- #{peek spPathConstraint, worldCount} ptr
        n <- #{peek spPathConstraint, world} ptr
        o <- #{peek spPathConstraint, curvesCount} ptr
        p <- #{peek spPathConstraint, curves} ptr
        q <- #{peek spPathConstraint, lengthsCount} ptr
        r <- #{peek spPathConstraint, lengths} ptr
        s <- #{peek spPathConstraint, segments} ptr
        return (SpPathConstraint a b c d e f g h i j k l m n o p q r s)
    poke ptr (SpPathConstraint a b c d e f g h i j k l m n o p q r s) = do
        #{poke spPathConstraint, data} ptr a
        #{poke spPathConstraint, bonesCount} ptr b
        #{poke spPathConstraint, bones} ptr c
        #{poke spPathConstraint, target} ptr d
        #{poke spPathConstraint, position} ptr e
        #{poke spPathConstraint, spacing} ptr f
        #{poke spPathConstraint, rotateMix} ptr g
        #{poke spPathConstraint, translateMix} ptr h
        #{poke spPathConstraint, spacesCount} ptr i
        #{poke spPathConstraint, spaces} ptr j
        #{poke spPathConstraint, positionsCount} ptr k
        #{poke spPathConstraint, positions} ptr l
        #{poke spPathConstraint, worldCount} ptr m
        #{poke spPathConstraint, world} ptr n
        #{poke spPathConstraint, curvesCount} ptr o
        #{poke spPathConstraint, curves} ptr p
        #{poke spPathConstraint, lengthsCount} ptr q
        #{poke spPathConstraint, lengths} ptr r
        #{poke spPathConstraint, segments} ptr s

-- #####################
-- "spine/PathConstraintData.h"
-- #####################

-- | SpPathConstraintData
data SpPathConstraintData = SpPathConstraintData
    { spPathConstraintData_name :: CString
    , spPathConstraintData_order :: CInt
    , spPathConstraintData_bonesCount :: CInt
    , spPathConstraintData_bones :: Ptr ( Ptr SpBoneData )
    , spPathConstraintData_target :: Ptr SpSlotData
    , spPathConstraintData_positionMode :: SpPositionMode
    , spPathConstraintData_spacingMode :: SpSpacingMode
    , spPathConstraintData_rotateMode :: SpRotateMode
    , spPathConstraintData_offsetRotation :: CFloat
    , spPathConstraintData_position :: CFloat
    , spPathConstraintData_spacing :: CFloat
    , spPathConstraintData_rotateMix :: CFloat
    , spPathConstraintData_translateMix :: CFloat
    } deriving (Show, Eq)
instance Storable SpPathConstraintData where
    alignment _ = #{alignment spPathConstraintData}
    sizeOf _    = #{size spPathConstraintData}
    peek ptr = do
        a <- #{peek spPathConstraintData, name} ptr
        b <- #{peek spPathConstraintData, order} ptr
        c <- #{peek spPathConstraintData, bonesCount} ptr
        d <- #{peek spPathConstraintData, bones} ptr
        e <- #{peek spPathConstraintData, target} ptr
        f <- #{peek spPathConstraintData, positionMode} ptr
        g <- #{peek spPathConstraintData, spacingMode} ptr
        h <- #{peek spPathConstraintData, rotateMode} ptr
        i <- #{peek spPathConstraintData, offsetRotation} ptr
        j <- #{peek spPathConstraintData, position} ptr
        k <- #{peek spPathConstraintData, spacing} ptr
        l <- #{peek spPathConstraintData, rotateMix} ptr
        m <- #{peek spPathConstraintData, translateMix} ptr
        return (SpPathConstraintData a b c d e f g h i j k l m)
    poke ptr (SpPathConstraintData a b c d e f g h i j k l m) = do
        #{poke spPathConstraintData, name} ptr a
        #{poke spPathConstraintData, order} ptr b
        #{poke spPathConstraintData, bonesCount} ptr c
        #{poke spPathConstraintData, bones} ptr d
        #{poke spPathConstraintData, target} ptr e
        #{poke spPathConstraintData, positionMode} ptr f
        #{poke spPathConstraintData, spacingMode} ptr g
        #{poke spPathConstraintData, rotateMode} ptr h
        #{poke spPathConstraintData, offsetRotation} ptr i
        #{poke spPathConstraintData, position} ptr j
        #{poke spPathConstraintData, spacing} ptr k
        #{poke spPathConstraintData, rotateMix} ptr l
        #{poke spPathConstraintData, translateMix} ptr m

-- #####################
-- "spine/RegionAttachment.h"
-- #####################

-- | SpRegionAttachment
data SpRegionAttachment = SpRegionAttachment
    { spRegionAttachment_super :: SpAttachment
    , spRegionAttachment_path :: CString
    , spRegionAttachment_x :: CFloat
    , spRegionAttachment_y :: CFloat
    , spRegionAttachment_scaleX :: CFloat
    , spRegionAttachment_scaleY :: CFloat
    , spRegionAttachment_rotation :: CFloat
    , spRegionAttachment_width :: CFloat
    , spRegionAttachment_height :: CFloat
    , spRegionAttachment_r :: CFloat
    , spRegionAttachment_g :: CFloat
    , spRegionAttachment_b :: CFloat
    , spRegionAttachment_a :: CFloat
    , spRegionAttachment_rendererObject :: Ptr ()
    , spRegionAttachment_regionOffsetX :: CInt -- ^ Pixels stripped from the bottom left, unrotated.
    , spRegionAttachment_regionOffsetY :: CInt -- ^ Pixels stripped from the bottom left, unrotated.
    , spRegionAttachment_regionWidth :: CInt -- ^ Unrotated, stripped pixel size.
    , spRegionAttachment_regionHeight :: CInt -- ^ Unrotated, stripped pixel size.
    , spRegionAttachment_regionOriginalWidth :: CInt -- ^ Unrotated, unstripped pixel size.
    , spRegionAttachment_regionOriginalHeight :: CInt -- ^ Unrotated, unstripped pixel size.
    , spRegionAttachment_offset :: Ptr CFloat -- ^ float offset[8]
    , spRegionAttachment_uvs :: Ptr CFloat -- ^ float uvs[8]
    } deriving (Show, Eq)
instance Storable SpRegionAttachment where
    alignment _ = #{alignment spRegionAttachment}
    sizeOf _    = #{size spRegionAttachment}
    peek ptr = do
        a <- #{peek spRegionAttachment, super} ptr
        b <- #{peek spRegionAttachment, path} ptr
        c <- #{peek spRegionAttachment, x} ptr
        d <- #{peek spRegionAttachment, y} ptr
        e <- #{peek spRegionAttachment, scaleX} ptr
        f <- #{peek spRegionAttachment, scaleY} ptr
        g <- #{peek spRegionAttachment, rotation} ptr
        h <- #{peek spRegionAttachment, width} ptr
        i <- #{peek spRegionAttachment, height} ptr
        j <- #{peek spRegionAttachment, r} ptr
        k <- #{peek spRegionAttachment, g} ptr
        l <- #{peek spRegionAttachment, b} ptr
        m <- #{peek spRegionAttachment, a} ptr
        n <- #{peek spRegionAttachment, rendererObject} ptr
        o <- #{peek spRegionAttachment, regionOffsetX} ptr
        p <- #{peek spRegionAttachment, regionOffsetY} ptr
        q <- #{peek spRegionAttachment, regionWidth} ptr
        r <- #{peek spRegionAttachment, regionHeight} ptr
        s <- #{peek spRegionAttachment, regionOriginalWidth} ptr
        t <- #{peek spRegionAttachment, regionOriginalHeight} ptr
        u <- #{peek spRegionAttachment, offset} ptr
        v <- #{peek spRegionAttachment, uvs} ptr
        return (SpRegionAttachment a b c d e f g h i j k l m n o p q r s t u v)
    poke ptr (SpRegionAttachment a b c d e f g h i j k l m n o p q r s t u v) = do
        #{poke spRegionAttachment, super} ptr a
        #{poke spRegionAttachment, path} ptr b
        #{poke spRegionAttachment, x} ptr c
        #{poke spRegionAttachment, y} ptr d
        #{poke spRegionAttachment, scaleX} ptr e
        #{poke spRegionAttachment, scaleY} ptr f
        #{poke spRegionAttachment, rotation} ptr g
        #{poke spRegionAttachment, width} ptr h
        #{poke spRegionAttachment, height} ptr i
        #{poke spRegionAttachment, r} ptr j
        #{poke spRegionAttachment, g} ptr k
        #{poke spRegionAttachment, b} ptr l
        #{poke spRegionAttachment, a} ptr m
        #{poke spRegionAttachment, rendererObject} ptr n
        #{poke spRegionAttachment, regionOffsetX} ptr o
        #{poke spRegionAttachment, regionOffsetY} ptr p
        #{poke spRegionAttachment, regionWidth} ptr q
        #{poke spRegionAttachment, regionHeight} ptr r
        #{poke spRegionAttachment, regionOriginalWidth} ptr s
        #{poke spRegionAttachment, regionOriginalHeight} ptr t
        #{poke spRegionAttachment, offset} ptr u
        #{poke spRegionAttachment, uvs} ptr v

-- #####################
-- "spine/Skeleton.h"
-- #####################

-- | SpSkeleton
data SpSkeleton = SpSkeleton
    { spSkeleton_data :: Ptr SpSkeletonData
    , spSkeleton_bonesCount :: CInt
    , spSkeleton_bones :: Ptr ( Ptr SpBone )
    , spSkeleton_root :: Ptr SpBone
    , spSkeleton_slotsCount :: CInt
    , spSkeleton_slots :: Ptr ( Ptr SpSlot )
    , spSkeleton_drawOrder :: Ptr ( Ptr SpSlot )
    , spSkeleton_ikConstraintsCount :: CInt
    , spSkeleton_ikConstraints :: Ptr ( Ptr SpIkConstraint )
    , spSkeleton_transformConstraintsCount :: CInt
    , spSkeleton_transformConstraints :: Ptr ( Ptr SpTransformConstraint )
    , spSkeleton_pathConstraintsCount :: CInt
    , spSkeleton_pathConstraints :: Ptr ( Ptr SpPathConstraint )
    , spSkeleton_skin :: Ptr SpSkin
    , spSkeleton_r :: CFloat
    , spSkeleton_g :: CFloat
    , spSkeleton_b :: CFloat
    , spSkeleton_a :: CFloat
    , spSkeleton_time :: CFloat
    , spSkeleton_flipX :: CInt -- ^ boolean
    , spSkeleton_flipY :: CInt -- ^ boolean
    , spSkeleton_x :: CFloat
    , spSkeleton_y :: CFloat
    } deriving (Show, Eq)
instance Storable SpSkeleton where
    alignment _ = #{alignment spSkeleton}
    sizeOf _    = #{size spSkeleton}
    peek ptr = do
        a <- #{peek spSkeleton, data} ptr
        b <- #{peek spSkeleton, bonesCount} ptr
        c <- #{peek spSkeleton, bones} ptr
        d <- #{peek spSkeleton, root} ptr
        e <- #{peek spSkeleton, slotsCount} ptr
        f <- #{peek spSkeleton, slots} ptr
        g <- #{peek spSkeleton, drawOrder} ptr
        h <- #{peek spSkeleton, ikConstraintsCount} ptr
        i <- #{peek spSkeleton, ikConstraints} ptr
        j <- #{peek spSkeleton, transformConstraintsCount} ptr
        k <- #{peek spSkeleton, transformConstraints} ptr
        l <- #{peek spSkeleton, pathConstraintsCount} ptr
        m <- #{peek spSkeleton, pathConstraints} ptr
        n <- #{peek spSkeleton, skin} ptr
        o <- #{peek spSkeleton, r} ptr
        p <- #{peek spSkeleton, g} ptr
        q <- #{peek spSkeleton, b} ptr
        r <- #{peek spSkeleton, a} ptr
        s <- #{peek spSkeleton, time} ptr
        t <- #{peek spSkeleton, flipX} ptr
        u <- #{peek spSkeleton, flipY} ptr
        v <- #{peek spSkeleton, x} ptr
        w <- #{peek spSkeleton, y} ptr
        return (SpSkeleton a b c d e f g h i j k l m n o p q r s t u v w)
    poke ptr (SpSkeleton a b c d e f g h i j k l m n o p q r s t u v w) = do
        #{poke spSkeleton, data} ptr a
        #{poke spSkeleton, bonesCount} ptr b
        #{poke spSkeleton, bones} ptr c
        #{poke spSkeleton, root} ptr d
        #{poke spSkeleton, slotsCount} ptr e
        #{poke spSkeleton, slots} ptr f
        #{poke spSkeleton, drawOrder} ptr g
        #{poke spSkeleton, ikConstraintsCount} ptr h
        #{poke spSkeleton, ikConstraints} ptr i
        #{poke spSkeleton, transformConstraintsCount} ptr j
        #{poke spSkeleton, transformConstraints} ptr k
        #{poke spSkeleton, pathConstraintsCount} ptr l
        #{poke spSkeleton, pathConstraints} ptr m
        #{poke spSkeleton, skin} ptr n
        #{poke spSkeleton, r} ptr o
        #{poke spSkeleton, g} ptr p
        #{poke spSkeleton, b} ptr q
        #{poke spSkeleton, a} ptr r
        #{poke spSkeleton, time} ptr s
        #{poke spSkeleton, flipX} ptr t
        #{poke spSkeleton, flipY} ptr u
        #{poke spSkeleton, x} ptr v
        #{poke spSkeleton, y} ptr w

-- #####################
-- "spine/SkeletonBinary.h"
-- #####################

-- | SpSkeletonBinary
data SpSkeletonBinary = SpSkeletonBinary
    { spSkeletonBinary_scale :: CFloat
    , spSkeletonBinary_attachmentLoader :: Ptr SpAttachmentLoader
    , spSkeletonBinary_error :: CString
    } deriving (Show, Eq)
instance Storable SpSkeletonBinary where
    alignment _ = #{alignment spSkeletonBinary}
    sizeOf _    = #{size spSkeletonBinary}
    peek ptr = do
        a <- #{peek spSkeletonBinary, scale} ptr
        b <- #{peek spSkeletonBinary, attachmentLoader} ptr
        c <- #{peek spSkeletonBinary, error} ptr
        return (SpSkeletonBinary a b c)
    poke ptr (SpSkeletonBinary a b c) = do
        #{poke spSkeletonBinary, scale} ptr a
        #{poke spSkeletonBinary, attachmentLoader} ptr b
        #{poke spSkeletonBinary, error} ptr c

-- #####################
-- "spine/SkeletonBounds.h"
-- #####################

-- | SpPolygon
data SpPolygon = SpPolygon
    { spPolygon_vertices :: Ptr CFloat
    , spPolygon_count :: CInt
    , spPolygon_capacity :: CInt
    } deriving (Show, Eq)
instance Storable SpPolygon where
    alignment _ = #{alignment spPolygon}
    sizeOf _    = #{size spPolygon}
    peek ptr = do
        a <- #{peek spPolygon, vertices} ptr
        b <- #{peek spPolygon, count} ptr
        c <- #{peek spPolygon, capacity} ptr
        return (SpPolygon a b c)
    poke ptr (SpPolygon a b c) = do
        #{poke spPolygon, vertices} ptr a
        #{poke spPolygon, count} ptr b
        #{poke spPolygon, capacity} ptr c

-- | SpSkeletonBounds
data SpSkeletonBounds = SpSkeletonBounds
    { spSkeletonBounds_count :: CInt
    , spSkeletonBounds_boundingBoxes :: Ptr ( Ptr SpBoundingBoxAttachment )
    , spSkeletonBounds_polygons :: Ptr ( Ptr SpPolygon )
    , spSkeletonBounds_minX :: CFloat
    , spSkeletonBounds_minY :: CFloat
    , spSkeletonBounds_maxX :: CFloat
    , spSkeletonBounds_maxY :: CFloat
    } deriving (Show, Eq)
instance Storable SpSkeletonBounds where
    alignment _ = #{alignment spSkeletonBounds}
    sizeOf _    = #{size spSkeletonBounds}
    peek ptr = do
        a <- #{peek spSkeletonBounds, count} ptr
        b <- #{peek spSkeletonBounds, boundingBoxes} ptr
        c <- #{peek spSkeletonBounds, polygons} ptr
        d <- #{peek spSkeletonBounds, minX} ptr
        e <- #{peek spSkeletonBounds, minY} ptr
        f <- #{peek spSkeletonBounds, maxX} ptr
        g <- #{peek spSkeletonBounds, maxY} ptr
        return (SpSkeletonBounds a b c d e f g)
    poke ptr (SpSkeletonBounds a b c d e f g) = do
        #{poke spSkeletonBounds, count} ptr a
        #{poke spSkeletonBounds, boundingBoxes} ptr b
        #{poke spSkeletonBounds, polygons} ptr c
        #{poke spSkeletonBounds, minX} ptr d
        #{poke spSkeletonBounds, minY} ptr e
        #{poke spSkeletonBounds, maxX} ptr f
        #{poke spSkeletonBounds, maxY} ptr g

-- #####################
-- "spine/SkeletonData.h"
-- #####################

-- | SpSkeletonData
data SpSkeletonData = SpSkeletonData
    { spSkeletonData_version :: CString
    , spSkeletonData_hash :: CString
    , spSkeletonData_width :: CFloat
    , spSkeletonData_height :: CFloat
    , spSkeletonData_bonesCount :: CInt
    , spSkeletonData_bones :: Ptr ( Ptr SpBoneData )
    , spSkeletonData_slotsCount :: CInt
    , spSkeletonData_slots :: Ptr ( Ptr SpSlotData )
    , spSkeletonData_skinsCount :: CInt
    , spSkeletonData_skins :: Ptr ( Ptr SpSkin )
    , spSkeletonData_defaultSkin :: Ptr SpSkin
    , spSkeletonData_eventsCount :: CInt
    , spSkeletonData_events :: Ptr ( Ptr SpEventData )
    , spSkeletonData_animationsCount :: CInt
    , spSkeletonData_animations :: Ptr ( Ptr SpAnimation )
    , spSkeletonData_ikConstraintsCount :: CInt
    , spSkeletonData_ikConstraints :: Ptr ( Ptr SpIkConstraintData )
    , spSkeletonData_transformConstraintsCount :: CInt
    , spSkeletonData_transformConstraints :: Ptr ( Ptr SpTransformConstraintData )
    , spSkeletonData_pathConstraintsCount :: CInt
    , spSkeletonData_pathConstraints :: Ptr ( Ptr SpPathConstraintData )
    } deriving (Show, Eq)
instance Storable SpSkeletonData where
    alignment _ = #{alignment spSkeletonData}
    sizeOf _    = #{size spSkeletonData}
    peek ptr = do
        a <- #{peek spSkeletonData, version} ptr
        b <- #{peek spSkeletonData, hash} ptr
        c <- #{peek spSkeletonData, width} ptr
        d <- #{peek spSkeletonData, height} ptr
        e <- #{peek spSkeletonData, bonesCount} ptr
        f <- #{peek spSkeletonData, bones} ptr
        g <- #{peek spSkeletonData, slotsCount} ptr
        h <- #{peek spSkeletonData, slots} ptr
        i <- #{peek spSkeletonData, skinsCount} ptr
        j <- #{peek spSkeletonData, skins} ptr
        k <- #{peek spSkeletonData, defaultSkin} ptr
        l <- #{peek spSkeletonData, eventsCount} ptr
        m <- #{peek spSkeletonData, events} ptr
        n <- #{peek spSkeletonData, animationsCount} ptr
        o <- #{peek spSkeletonData, animations} ptr
        p <- #{peek spSkeletonData, ikConstraintsCount} ptr
        q <- #{peek spSkeletonData, ikConstraints} ptr
        r <- #{peek spSkeletonData, transformConstraintsCount} ptr
        s <- #{peek spSkeletonData, transformConstraints} ptr
        t <- #{peek spSkeletonData, pathConstraintsCount} ptr
        u <- #{peek spSkeletonData, pathConstraints} ptr
        return (SpSkeletonData a b c d e f g h i j k l m n o p q r s t u)
    poke ptr (SpSkeletonData a b c d e f g h i j k l m n o p q r s t u) = do
        #{poke spSkeletonData, version} ptr a
        #{poke spSkeletonData, hash} ptr b
        #{poke spSkeletonData, width} ptr c
        #{poke spSkeletonData, height} ptr d
        #{poke spSkeletonData, bonesCount} ptr e
        #{poke spSkeletonData, bones} ptr f
        #{poke spSkeletonData, slotsCount} ptr g
        #{poke spSkeletonData, slots} ptr h
        #{poke spSkeletonData, skinsCount} ptr i
        #{poke spSkeletonData, skins} ptr j
        #{poke spSkeletonData, defaultSkin} ptr k
        #{poke spSkeletonData, eventsCount} ptr l
        #{poke spSkeletonData, events} ptr m
        #{poke spSkeletonData, animationsCount} ptr n
        #{poke spSkeletonData, animations} ptr o
        #{poke spSkeletonData, ikConstraintsCount} ptr p
        #{poke spSkeletonData, ikConstraints} ptr q
        #{poke spSkeletonData, transformConstraintsCount} ptr r
        #{poke spSkeletonData, transformConstraints} ptr s
        #{poke spSkeletonData, pathConstraintsCount} ptr t
        #{poke spSkeletonData, pathConstraints} ptr u

-- #####################
-- "spine/SkeletonJson.h"
-- #####################

-- | SpSkeletonJson
data SpSkeletonJson = SpSkeletonJson
    { spSkeletonJson_scale :: CFloat
    , spSkeletonJson_attachmentLoader :: Ptr SpAttachmentLoader
    , spSkeletonJson_error :: CString
    } deriving (Show, Eq)
instance Storable SpSkeletonJson where
    alignment _ = #{alignment spSkeletonJson}
    sizeOf _    = #{size spSkeletonJson}
    peek ptr = do
        a <- #{peek spSkeletonJson, scale} ptr
        b <- #{peek spSkeletonJson, attachmentLoader} ptr
        c <- #{peek spSkeletonJson, error} ptr
        return (SpSkeletonJson a b c)
    poke ptr (SpSkeletonJson a b c) = do
        #{poke spSkeletonJson, scale} ptr a
        #{poke spSkeletonJson, attachmentLoader} ptr b
        #{poke spSkeletonJson, error} ptr c

-- #####################
-- "spine/Skin.h"
-- #####################

-- | SpSkin
data SpSkin = SpSkin
    { spSkin_name :: CString
    } deriving (Show, Eq)
instance Storable SpSkin where
    alignment _ = #{alignment spSkin}
    sizeOf _    = #{size spSkin}
    peek ptr = do
        a <- #{peek spSkin, name} ptr
        return (SpSkin a)
    poke ptr (SpSkin a) = do
        #{poke spSkin, name} ptr a

-- #####################
-- "spine/Slot.h"
-- #####################

-- | SpSlot
data SpSlot = SpSlot
    { spSlot_data :: Ptr SpSlotData
    , spSlot_bone :: Ptr SpBone
    , spSlot_r :: CFloat
    , spSlot_g :: CFloat
    , spSlot_b :: CFloat
    , spSlot_a :: CFloat
    , spSlot_attachment :: Ptr SpAttachment
    , spSlot_attachmentVerticesCapacity :: CInt
    , spSlot_attachmentVerticesCount :: CInt
    , spSlot_attachmentVertices :: Ptr CFloat
    } deriving (Show, Eq)
instance Storable SpSlot where
    alignment _ = #{alignment spSlot}
    sizeOf _    = #{size spSlot}
    peek ptr = do
        a <- #{peek spSlot, data} ptr
        b <- #{peek spSlot, bone} ptr
        c <- #{peek spSlot, r} ptr
        d <- #{peek spSlot, g} ptr
        e <- #{peek spSlot, b} ptr
        f <- #{peek spSlot, a} ptr
        g <- #{peek spSlot, attachment} ptr
        h <- #{peek spSlot, attachmentVerticesCapacity} ptr
        i <- #{peek spSlot, attachmentVerticesCount} ptr
        j <- #{peek spSlot, attachmentVertices} ptr
        return (SpSlot a b c d e f g h i j)
    poke ptr (SpSlot a b c d e f g h i j) = do
        #{poke spSlot, data} ptr a
        #{poke spSlot, bone} ptr b
        #{poke spSlot, r} ptr c
        #{poke spSlot, g} ptr d
        #{poke spSlot, b} ptr e
        #{poke spSlot, a} ptr f
        #{poke spSlot, attachment} ptr g
        #{poke spSlot, attachmentVerticesCapacity} ptr h
        #{poke spSlot, attachmentVerticesCount} ptr i
        #{poke spSlot, attachmentVertices} ptr j

-- #####################
-- "spine/SlotData.h"
-- #####################

-- | SpSlotData
data SpSlotData = SpSlotData
    { spSlotData_index :: CInt
    , spSlotData_name :: CString
    , spSlotData_boneData :: Ptr SpBoneData
    , spSlotData_attachmentName :: CString
    , spSlotData_r :: CFloat
    , spSlotData_g :: CFloat
    , spSlotData_b :: CFloat
    , spSlotData_a :: CFloat
    , spSlotData_blendMode :: SpBlendMode
    } deriving (Show, Eq)
instance Storable SpSlotData where
    alignment _ = #{alignment spSlotData}
    sizeOf _    = #{size spSlotData}
    peek ptr = do
        a <- #{peek spSlotData, index} ptr
        b <- #{peek spSlotData, name} ptr
        c <- #{peek spSlotData, boneData} ptr
        d <- #{peek spSlotData, attachmentName} ptr
        e <- #{peek spSlotData, r} ptr
        f <- #{peek spSlotData, g} ptr
        g <- #{peek spSlotData, b} ptr
        h <- #{peek spSlotData, a} ptr
        i <- #{peek spSlotData, blendMode} ptr
        return (SpSlotData a b c d e f g h i)
    poke ptr (SpSlotData a b c d e f g h i) = do
        #{poke spSlotData, index} ptr a
        #{poke spSlotData, name} ptr b
        #{poke spSlotData, boneData} ptr c
        #{poke spSlotData, attachmentName} ptr d
        #{poke spSlotData, r} ptr e
        #{poke spSlotData, g} ptr f
        #{poke spSlotData, b} ptr g
        #{poke spSlotData, a} ptr h
        #{poke spSlotData, blendMode} ptr i

-- #####################
-- "spine/TransformConstraint.h"
-- #####################

-- | SpTransformConstraint
data SpTransformConstraint = SpTransformConstraint
    { spTransformConstraint_data :: Ptr SpTransformConstraintData
    , spTransformConstraint_bonesCount :: CInt
    , spTransformConstraint_bones :: Ptr ( Ptr SpBone )
    , spTransformConstraint_target :: Ptr SpBone
    , spTransformConstraint_rotateMix :: CFloat
    , spTransformConstraint_translateMix :: CFloat
    , spTransformConstraint_scaleMix :: CFloat
    , spTransformConstraint_shearMix :: CFloat
    } deriving (Show, Eq)
instance Storable SpTransformConstraint where
    alignment _ = #{alignment spTransformConstraint}
    sizeOf _    = #{size spTransformConstraint}
    peek ptr = do
        a <- #{peek spTransformConstraint, data} ptr
        b <- #{peek spTransformConstraint, bonesCount} ptr
        c <- #{peek spTransformConstraint, bones} ptr
        d <- #{peek spTransformConstraint, target} ptr
        e <- #{peek spTransformConstraint, rotateMix} ptr
        f <- #{peek spTransformConstraint, translateMix} ptr
        g <- #{peek spTransformConstraint, scaleMix} ptr
        h <- #{peek spTransformConstraint, shearMix} ptr
        return (SpTransformConstraint a b c d e f g h)
    poke ptr (SpTransformConstraint a b c d e f g h) = do
        #{poke spTransformConstraint, data} ptr a
        #{poke spTransformConstraint, bonesCount} ptr b
        #{poke spTransformConstraint, bones} ptr c
        #{poke spTransformConstraint, target} ptr d
        #{poke spTransformConstraint, rotateMix} ptr e
        #{poke spTransformConstraint, translateMix} ptr f
        #{poke spTransformConstraint, scaleMix} ptr g
        #{poke spTransformConstraint, shearMix} ptr h

-- #####################
-- "spine/TransformConstraintData.h"
-- #####################

-- | SpTransformConstraintData
data SpTransformConstraintData = SpTransformConstraintData
    { spTransformConstraintData_name :: CString
    , spTransformConstraintData_order :: CInt
    , spTransformConstraintData_bonesCount :: CInt
    , spTransformConstraintData_bones :: Ptr ( Ptr SpBoneData )
    , spTransformConstraintData_target :: Ptr SpBoneData
    , spTransformConstraintData_rotateMix :: CFloat
    , spTransformConstraintData_translateMix :: CFloat
    , spTransformConstraintData_scaleMix :: CFloat
    , spTransformConstraintData_shearMix :: CFloat
    , spTransformConstraintData_offsetRotation :: CFloat
    , spTransformConstraintData_offsetX :: CFloat
    , spTransformConstraintData_offsetY :: CFloat
    , spTransformConstraintData_offsetScaleX :: CFloat
    , spTransformConstraintData_offsetScaleY :: CFloat
    , spTransformConstraintData_offsetShearY :: CFloat
    } deriving (Show, Eq)
instance Storable SpTransformConstraintData where
    alignment _ = #{alignment spTransformConstraintData}
    sizeOf _    = #{size spTransformConstraintData}
    peek ptr = do
        a <- #{peek spTransformConstraintData, name} ptr
        b <- #{peek spTransformConstraintData, order} ptr
        c <- #{peek spTransformConstraintData, bonesCount} ptr
        d <- #{peek spTransformConstraintData, bones} ptr
        e <- #{peek spTransformConstraintData, target} ptr
        f <- #{peek spTransformConstraintData, rotateMix} ptr
        g <- #{peek spTransformConstraintData, translateMix} ptr
        h <- #{peek spTransformConstraintData, scaleMix} ptr
        i <- #{peek spTransformConstraintData, shearMix} ptr
        j <- #{peek spTransformConstraintData, offsetRotation} ptr
        k <- #{peek spTransformConstraintData, offsetX} ptr
        l <- #{peek spTransformConstraintData, offsetY} ptr
        m <- #{peek spTransformConstraintData, offsetScaleX} ptr
        n <- #{peek spTransformConstraintData, offsetScaleY} ptr
        o <- #{peek spTransformConstraintData, offsetShearY} ptr
        return (SpTransformConstraintData a b c d e f g h i j k l m n o)
    poke ptr (SpTransformConstraintData a b c d e f g h i j k l m n o) = do
        #{poke spTransformConstraintData, name} ptr a
        #{poke spTransformConstraintData, order} ptr b
        #{poke spTransformConstraintData, bonesCount} ptr c
        #{poke spTransformConstraintData, bones} ptr d
        #{poke spTransformConstraintData, target} ptr e
        #{poke spTransformConstraintData, rotateMix} ptr f
        #{poke spTransformConstraintData, translateMix} ptr g
        #{poke spTransformConstraintData, scaleMix} ptr h
        #{poke spTransformConstraintData, shearMix} ptr i
        #{poke spTransformConstraintData, offsetRotation} ptr j
        #{poke spTransformConstraintData, offsetX} ptr k
        #{poke spTransformConstraintData, offsetY} ptr l
        #{poke spTransformConstraintData, offsetScaleX} ptr m
        #{poke spTransformConstraintData, offsetScaleY} ptr n
        #{poke spTransformConstraintData, offsetShearY} ptr o

-- #####################
-- "spine/VertexAttachment.h"
-- #####################

-- | SpVertexAttachment
data SpVertexAttachment = SpVertexAttachment
    { spVertexAttachment_super :: SpAttachment
    , spVertexAttachment_bonesCount :: CInt
    , spVertexAttachment_bones :: Ptr CInt
    , spVertexAttachment_verticesCount :: CInt
    , spVertexAttachment_vertices :: Ptr CFloat
    , spVertexAttachment_worldVerticesLength :: CInt
    } deriving (Show, Eq)
instance Storable SpVertexAttachment where
    alignment _ = #{alignment spVertexAttachment}
    sizeOf _    = #{size spVertexAttachment}
    peek ptr = do
        a <- #{peek spVertexAttachment, super} ptr
        b <- #{peek spVertexAttachment, bonesCount} ptr
        c <- #{peek spVertexAttachment, bones} ptr
        d <- #{peek spVertexAttachment, verticesCount} ptr
        e <- #{peek spVertexAttachment, vertices} ptr
        f <- #{peek spVertexAttachment, worldVerticesLength} ptr
        return (SpVertexAttachment a b c d e f)
    poke ptr (SpVertexAttachment a b c d e f) = do
        #{poke spVertexAttachment, super} ptr a
        #{poke spVertexAttachment, bonesCount} ptr b
        #{poke spVertexAttachment, bones} ptr c
        #{poke spVertexAttachment, verticesCount} ptr d
        #{poke spVertexAttachment, vertices} ptr e
        #{poke spVertexAttachment, worldVerticesLength} ptr f

--
