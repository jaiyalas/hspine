module Spine.Raw.Bone
    ( -- * functions
      spBone_setYDown_FFI
    , spBone_isYDown_FFI
    , spBone_create_FFI
    , spBone_dispose_FFI
    , spBone_setToSetupPose_FFI
    , spBone_updateWorldTransform_FFI
    , spBone_updateWorldTransformWith_FFI
    , spBone_getWorldRotationX_FFI
    , spBone_getWorldRotationY_FFI
    , spBone_getWorldScaleX_FFI
    , spBone_getWorldScaleY_FFI
    , spBone_worldToLocalRotationX_FFI
    , spBone_worldToLocalRotationY_FFI
    , spBone_rotateWorld_FFI
    , spBone_updateAppliedTransform_FFI
    , spBone_worldToLocal_FFI
    , spBone_localToWorld_FFI
    ) where
--
#include "spine/Bone.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--

foreign import ccall "spBone_setYDown" spBone_setYDown_FFI
    :: CInt -- ^ yDown :: boolean
    -> IO ()

foreign import ccall "spBone_isYDown" spBone_isYDown_FFI
    :: IO CInt -- ^ boolean

-- | @param parent May be 0.
foreign import ccall "spBone_create" spBone_create_FFI
    :: Ptr SpBoneData -- ^ data
    -> Ptr SpSkeleton -- ^ skeleton
    -> Ptr SpBone -- ^ parent
    -> IO (Ptr SpBone)

foreign import ccall "spBone_dispose" spBone_dispose_FFI
    :: Ptr SpBone -- ^ self
    -> IO ()

foreign import ccall "spBone_setToSetupPose" spBone_setToSetupPose_FFI
    :: Ptr SpBone -- ^ self
    -> IO ()

foreign import ccall "spBone_updateWorldTransform" spBone_updateWorldTransform_FFI
    :: Ptr SpBone -- ^ self
    -> IO ()

foreign import ccall "spBone_updateWorldTransformWith" spBone_updateWorldTransformWith_FFI
    :: Ptr SpBone -- ^ self
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> CFloat -- ^ rotation
    -> CFloat -- ^ scaleX
    -> CFloat -- ^ scaleY
    -> CFloat -- ^ shearX
    -> CFloat -- ^ shearY
    -> IO ()

foreign import ccall "spBone_getWorldRotationX" spBone_getWorldRotationX_FFI
    :: Ptr SpBone -- ^ self
    -> IO CFloat

foreign import ccall "spBone_getWorldRotationY" spBone_getWorldRotationY_FFI
    :: Ptr SpBone -- ^ self
    -> IO CFloat

foreign import ccall "spBone_getWorldScaleX" spBone_getWorldScaleX_FFI
    :: Ptr SpBone -- ^ self
    -> IO CFloat

foreign import ccall "spBone_getWorldScaleY" spBone_getWorldScaleY_FFI
    :: Ptr SpBone -- ^ self
    -> IO CFloat

foreign import ccall "spBone_worldToLocalRotationX" spBone_worldToLocalRotationX_FFI
    :: Ptr SpBone -- ^ self
    -> IO CFloat

foreign import ccall "spBone_worldToLocalRotationY" spBone_worldToLocalRotationY_FFI
    :: Ptr SpBone -- ^ self
    -> IO CFloat

foreign import ccall "spBone_rotateWorld" spBone_rotateWorld_FFI
    :: Ptr SpBone -- ^ self
    -> CFloat -- ^ degrees
    -> IO ()

foreign import ccall "spBone_updateAppliedTransform" spBone_updateAppliedTransform_FFI
    :: Ptr SpBone -- ^ self
    -> IO ()

foreign import ccall "spBone_worldToLocal" spBone_worldToLocal_FFI
    :: Ptr SpBone -- ^ self
    -> CFloat -- ^ worldX
    -> CFloat -- ^ worldY
    -> Ptr CFloat -- ^ localX
    -> Ptr CFloat -- ^ localY
    -> IO ()

foreign import ccall "spBone_localToWorld" spBone_localToWorld_FFI
    :: Ptr SpBone -- ^ self
    -> CFloat -- ^ localX
    -> CFloat -- ^ localY
    -> Ptr CFloat -- ^ worldX
    -> Ptr CFloat -- ^ worldY
    -> IO ()
