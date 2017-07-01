module Spine.Raw.SkeletonData
    ( -- * functions
      spSkeletonData_create_FFI
    , spSkeletonData_dispose_FFI
    , spSkeletonData_findBone_FFI
    , spSkeletonData_findBoneIndex_FFI
    , spSkeletonData_findSlot_FFI
    , spSkeletonData_findSlotIndex_FFI
    , spSkeletonData_findSkin_FFI
    , spSkeletonData_findEvent_FFI
    , spSkeletonData_findAnimation_FFI
    , spSkeletonData_findIkConstraint_FFI
    , spSkeletonData_findTransformConstraint_FFI
    , spSkeletonData_findPathConstraint_FFI
    ) where
--
#include "spine/SkeletonData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spSkeletonData_create" spSkeletonData_create_FFI
    :: IO (Ptr SpSkeletonData)

foreign import ccall "spSkeletonData_dispose" spSkeletonData_dispose_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> IO ()

foreign import ccall "spSkeletonData_findBone" spSkeletonData_findBone_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ boneName
    -> IO (Ptr SpBoneData)

foreign import ccall "spSkeletonData_findBoneIndex" spSkeletonData_findBoneIndex_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ boneName
    -> IO CInt

foreign import ccall "spSkeletonData_findSlot" spSkeletonData_findSlot_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ slotName
    -> IO (Ptr SpSlotData)

foreign import ccall "spSkeletonData_findSlotIndex" spSkeletonData_findSlotIndex_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ slotName
    -> IO CInt

foreign import ccall "spSkeletonData_findSkin" spSkeletonData_findSkin_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ skinName
    -> IO (Ptr SpSkin)

foreign import ccall "spSkeletonData_findEvent" spSkeletonData_findEvent_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ eventName
    -> IO (Ptr SpEventData)

foreign import ccall "spSkeletonData_findAnimation" spSkeletonData_findAnimation_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ animationName
    -> IO (Ptr SpAnimation)

foreign import ccall "spSkeletonData_findIkConstraint" spSkeletonData_findIkConstraint_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ raintName
    -> IO (Ptr SpIkConstraintData)

foreign import ccall "spSkeletonData_findTransformConstraint" spSkeletonData_findTransformConstraint_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ raintName
    -> IO (Ptr SpTransformConstraintData)

foreign import ccall "spSkeletonData_findPathConstraint" spSkeletonData_findPathConstraint_FFI
    :: Ptr SpSkeletonData -- ^ self
    -> CString -- ^ raintName
    -> IO (Ptr SpPathConstraintData)
