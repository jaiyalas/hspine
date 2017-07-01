module Spine.Raw.AnimationState
    ( -- *
      spAnimationState_create_FFI
    , spAnimationState_dispose_FFI
    , spAnimationState_update_FFI
    , spAnimationState_apply_FFI
    , spAnimationState_clearTracks_FFI
    , spAnimationState_clearTrack_FFI
    , spAnimationState_setAnimationByName_FFI
    , spAnimationState_setAnimation_FFI
    , spAnimationState_addAnimationByName_FFI
    , spAnimationState_addAnimation_FFI
    , spAnimationState_setEmptyAnimation_FFI
    , spAnimationState_addEmptyAnimation_FFI
    , spAnimationState_setEmptyAnimations_FFI
    , spAnimationState_getCurrent_FFI
    , spAnimationState_clearListenerNotifications_FFI
    , spTrackEntry_getAnimationTime_FFI
    , spAnimationState_disposeStatics_FFI
    ) where
--
#include "spine/AnimationState.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
-- | @param data May be 0 for no mixing.
foreign import ccall "spAnimationState_create" spAnimationState_create_FFI
    :: Ptr SpAnimationStateData -- ^ data
    -> IO (Ptr SpAnimationState)

foreign import ccall "spAnimationState_dispose" spAnimationState_dispose_FFI
    :: Ptr SpAnimationState -- ^ self
    -> IO ()

foreign import ccall "spAnimationState_update" spAnimationState_update_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CFloat -- ^ delta
    -> IO ()

foreign import ccall "spAnimationState_apply" spAnimationState_apply_FFI
    :: Ptr SpAnimationState -- ^ self
    -> Ptr SpSkeleton -- ^ skeleton
    -> IO ()

foreign import ccall "spAnimationState_clearTracks" spAnimationState_clearTracks_FFI
    :: Ptr SpAnimationState -- ^ self
    -> IO ()

foreign import ccall "spAnimationState_clearTrack" spAnimationState_clearTrack_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CInt -- ^ trackIndex
    -> IO ()

-- | * Set the current animation. Any queued animations are cleared.
foreign import ccall "spAnimationState_setAnimationByName" spAnimationState_setAnimationByName_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CInt -- ^ trackIndex
    -> CString -- ^ animationName
    -> CInt -- ^ loop :: boolean
    -> IO (Ptr SpTrackEntry)

foreign import ccall "spAnimationState_setAnimation" spAnimationState_setAnimation_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CInt -- ^ trackIndex
    -> Ptr SpAnimation -- ^ animation
    -> CInt -- ^ loop :: boolean
    -> IO (Ptr SpTrackEntry)

-- | * Adds an animation to be played delay seconds after the current or last queued animation, taking into account any mix  * duration.
foreign import ccall "spAnimationState_addAnimationByName" spAnimationState_addAnimationByName_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CInt -- ^ trackIndex
    -> CString -- ^ animationName
    -> CInt -- ^ loop :: boolean
    -> CFloat -- ^ delay
    -> IO (Ptr SpTrackEntry)

foreign import ccall "spAnimationState_addAnimation" spAnimationState_addAnimation_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CInt -- ^ trackIndex
    -> Ptr SpAnimation -- ^ animation
    -> CInt -- ^ loop :: boolean
    -> CFloat -- ^ delay
    -> IO (Ptr SpTrackEntry)

foreign import ccall "spAnimationState_setEmptyAnimation" spAnimationState_setEmptyAnimation_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CInt -- ^ trackIndex
    -> CFloat -- ^ mixDuration
    -> IO (Ptr SpTrackEntry)

foreign import ccall "spAnimationState_addEmptyAnimation" spAnimationState_addEmptyAnimation_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CInt -- ^ trackIndex
    -> CFloat -- ^ mixDuration
    -> CFloat -- ^ delay
    -> IO (Ptr SpTrackEntry)

foreign import ccall "spAnimationState_setEmptyAnimations" spAnimationState_setEmptyAnimations_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CFloat -- ^ mixDuration
    -> IO ()

foreign import ccall "spAnimationState_getCurrent" spAnimationState_getCurrent_FFI
    :: Ptr SpAnimationState -- ^ self
    -> CInt -- ^ trackIndex
    -> IO (Ptr SpTrackEntry)

foreign import ccall "spAnimationState_clearListenerNotifications" spAnimationState_clearListenerNotifications_FFI
    :: Ptr SpAnimationState -- ^ self
    -> IO ()

foreign import ccall "spTrackEntry_getAnimationTime" spTrackEntry_getAnimationTime_FFI
    :: Ptr SpTrackEntry -- ^ entry
    -> IO CFloat

-- | * Use this to dispose static memory before your app exits to appease your memory leak detector
foreign import ccall "spAnimationState_disposeStatics" spAnimationState_disposeStatics_FFI
    :: IO ()
