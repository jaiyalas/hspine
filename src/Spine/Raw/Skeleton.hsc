module Spine.Raw.Skeleton
    ( -- * functions
      spSkeleton_create_FFI
    , spSkeleton_dispose_FFI
    , spSkeleton_updateCache_FFI
    , spSkeleton_updateWorldTransform_FFI
    , spSkeleton_setToSetupPose_FFI
    , spSkeleton_setBonesToSetupPose_FFI
    , spSkeleton_setSlotsToSetupPose_FFI
    , spSkeleton_findBone_FFI
    , spSkeleton_findBoneIndex_FFI
    , spSkeleton_findSlot_FFI
    , spSkeleton_findSlotIndex_FFI
    , spSkeleton_setSkin_FFI
    , spSkeleton_setSkinByName_FFI
    , spSkeleton_getAttachmentForSlotName_FFI
    , spSkeleton_getAttachmentForSlotIndex_FFI
    , spSkeleton_setAttachment_FFI
    , spSkeleton_findIkConstraint_FFI
    , spSkeleton_findTransformConstraint_FFI
    , spSkeleton_findPathConstraint_FFI
    , spSkeleton_update_FFI
    ) where
--
#include "spine/Skeleton.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spSkeleton_create" spSkeleton_create_FFI
    :: Ptr SpSkeletonData -- ^ data
    -> IO (Ptr SpSkeleton)

foreign import ccall "spSkeleton_dispose" spSkeleton_dispose_FFI
    :: Ptr SpSkeleton -- ^ self
    -> IO ()

-- | Caches information about bones and constraints. Must be called if bones or constraints, or weighted path attachments * are added or removed.
foreign import ccall "spSkeleton_updateCache" spSkeleton_updateCache_FFI
    :: Ptr SpSkeleton -- ^ self
    -> IO ()

foreign import ccall "spSkeleton_updateWorldTransform" spSkeleton_updateWorldTransform_FFI
    :: Ptr SpSkeleton -- ^ self
    -> IO ()

-- | Sets the bones, constraints, and slots to their setup pose values.
foreign import ccall "spSkeleton_setToSetupPose" spSkeleton_setToSetupPose_FFI
    :: Ptr SpSkeleton -- ^ self
    -> IO ()

-- | Sets the bones and constraints to their setup pose values.
foreign import ccall "spSkeleton_setBonesToSetupPose" spSkeleton_setBonesToSetupPose_FFI
    :: Ptr SpSkeleton -- ^ self
    -> IO ()

foreign import ccall "spSkeleton_setSlotsToSetupPose" spSkeleton_setSlotsToSetupPose_FFI
    :: Ptr SpSkeleton -- ^ self
    -> IO ()

-- | Returns 0 if the bone was not found.
foreign import ccall "spSkeleton_findBone" spSkeleton_findBone_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ boneName
    -> IO (Ptr SpBone)

-- | Returns -1 if the bone was not found.
foreign import ccall "spSkeleton_findBoneIndex" spSkeleton_findBoneIndex_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ boneName
    -> IO CInt

-- | Returns 0 if the slot was not found.
foreign import ccall "spSkeleton_findSlot" spSkeleton_findSlot_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ slotName
    -> IO (Ptr SpSlot)

-- | Returns -1 if the slot was not found.
foreign import ccall "spSkeleton_findSlotIndex" spSkeleton_findSlotIndex_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ slotName
    -> IO CInt

-- | Sets the skin used to look up attachments before looking in the SkeletonData defaultSkin. Attachments from the new skin are * attached if the corresponding attachment from the old skin was attached. If there was no old skin, each slot's setup mode * attachment is attached from the new skin. * @param skin May be 0.
foreign import ccall "spSkeleton_setSkin" spSkeleton_setSkin_FFI
    :: Ptr SpSkeleton -- ^ self
    -> Ptr SpSkin -- ^ skin
    -> IO ()

-- | Returns 0 if the skin was not found. See spSkeleton_setSkin. * @param skinName May be 0.
foreign import ccall "spSkeleton_setSkinByName" spSkeleton_setSkinByName_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ skinName
    -> IO CInt

-- | Returns 0 if the slot or attachment was not found.
foreign import ccall "spSkeleton_getAttachmentForSlotName" spSkeleton_getAttachmentForSlotName_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ slotName
    -> CString -- ^ attachmentName
    -> IO (Ptr SpAttachment)

-- | Returns 0 if the slot or attachment was not found.
foreign import ccall "spSkeleton_getAttachmentForSlotIndex" spSkeleton_getAttachmentForSlotIndex_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CInt -- ^ slotIndex
    -> CString -- ^ attachmentName
    -> IO (Ptr SpAttachment)

-- | Returns 0 if the slot or attachment was not found. * @param attachmentName May be 0.
foreign import ccall "spSkeleton_setAttachment" spSkeleton_setAttachment_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ slotName
    -> CString -- ^ attachmentName
    -> IO CInt

-- | Returns 0 if the IK constraint was not found.
foreign import ccall "spSkeleton_findIkConstraint" spSkeleton_findIkConstraint_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ raintName
    -> IO (Ptr SpIkConstraint)

-- | Returns 0 if the transform constraint was not found.
foreign import ccall "spSkeleton_findTransformConstraint" spSkeleton_findTransformConstraint_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ raintName
    -> IO (Ptr SpTransformConstraint)

-- | Returns 0 if the path constraint was not found.
foreign import ccall "spSkeleton_findPathConstraint" spSkeleton_findPathConstraint_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CString -- ^ raintName
    -> IO (Ptr SpPathConstraint)

foreign import ccall "spSkeleton_update" spSkeleton_update_FFI
    :: Ptr SpSkeleton -- ^ self
    -> CFloat -- ^ deltaTime
    -> IO ()
