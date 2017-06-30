module Spine.Raw.AnimationStateData
    ( -- * functions
      spAnimationStateData_create
    , spAnimationStateData_dispose
    , spAnimationStateData_setMixByName
    , spAnimationStateData_setMix
    , spAnimationStateData_getMix
    ) where
--
#include "spine/AnimationStateData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spAnimationStateData_create" spAnimationStateData_create_FFI
    :: Ptr SpSkeletonData -- ^ skeletonData
    -> IO Ptr SpAnimationStateData

foreign import ccall "spAnimationStateData_dispose" spAnimationStateData_dispose_FFI
    :: Ptr SpAnimationStateData -- ^ self
    -> IO ()

foreign import ccall "spAnimationStateData_setMixByName" spAnimationStateData_setMixByName_FFI
    :: Ptr SpAnimationStateData -- ^ self
    -> CString -- ^ fromName
    -> CString -- ^ toName
    -> CFloat -- ^ duration
    -> IO ()

foreign import ccall "spAnimationStateData_setMix" spAnimationStateData_setMix_FFI
    :: Ptr SpAnimationStateData -- ^ self
    -> Ptr SpAnimation -- ^ from
    -> Ptr SpAnimation -- ^ to
    -> CFloat -- ^ duration
    -> IO ()

-- | Returns 0 if there is no mixing between the animations.
foreign import ccall "spAnimationStateData_getMix" spAnimationStateData_getMix_FFI
    :: Ptr SpAnimationStateData -- ^ self
    -> Ptr SpAnimation -- ^ from
    -> Ptr SpAnimation -- ^ to
    -> IO CFloat
--
