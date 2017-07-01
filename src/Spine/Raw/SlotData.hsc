module Spine.Raw.SlotData
    ( -- * functions
      spSlotData_create_FFI
    , spSlotData_dispose_FFI
    , spSlotData_setAttachmentName_FFI
    ) where
--
#include "spine/SlotData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spSlotData_create" spSlotData_create_FFI
    :: CInt -- ^ index
    -> CString -- ^ name
    -> Ptr SpBoneData -- ^ boneData
    -> IO (Ptr SpSlotData)

foreign import ccall "spSlotData_dispose" spSlotData_dispose_FFI
    :: Ptr SpSlotData -- ^ self
    -> IO ()

-- | @param attachmentName May be 0 for no setup pose attachment.
foreign import ccall "spSlotData_setAttachmentName" spSlotData_setAttachmentName_FFI
    :: Ptr SpSlotData -- ^ self
    -> CString -- ^ attachmentName
    -> IO ()
