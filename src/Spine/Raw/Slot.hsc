module Spine.Raw.Slot
    ( -- * functions
      spSlot_create_FFI
    , spSlot_dispose_FFI
    , spSlot_setAttachment_FFI
    , spSlot_setAttachmentTime_FFI
    , spSlot_getAttachmentTime_FFI
    , spSlot_setToSetupPose_FFI
    ) where

--
#include "spine/Slot.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spSlot_create" spSlot_create_FFI
    :: Ptr SpSlotData -- ^ data
    -> Ptr SpBone -- ^ bone
    -> IO (Ptr SpSlot)

foreign import ccall "spSlot_dispose" spSlot_dispose_FFI
    :: Ptr SpSlot -- ^ self
    -> IO ()

-- | @param attachment May be 0 to clear the attachment for the slot.
foreign import ccall "spSlot_setAttachment" spSlot_setAttachment_FFI
    :: Ptr SpSlot -- ^ self
    -> Ptr SpAttachment -- ^ attachment
    -> IO ()

foreign import ccall "spSlot_setAttachmentTime" spSlot_setAttachmentTime_FFI
    :: Ptr SpSlot -- ^ self
    -> CFloat -- ^ time
    -> IO ()

foreign import ccall "spSlot_getAttachmentTime" spSlot_getAttachmentTime_FFI
    :: Ptr SpSlot -- ^ self
    -> IO CFloat

foreign import ccall "spSlot_setToSetupPose" spSlot_setToSetupPose_FFI
    :: Ptr SpSlot -- ^ self
    -> IO ()
