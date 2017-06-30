module Spine.Raw.AttachmentLoader
    ( -- * functions
      spAttachmentLoader_dispose
    , spAttachmentLoader_createAttachment
    , spAttachmentLoader_configureAttachment
    , spAttachmentLoader_disposeAttachment
    ) where
--
#include "spine/AttachmentLoader.h"
--
import Foreign.C.Types
--
import Foreign.C.Types
import Spine.Raw.InternalStruct
--
foreign import ccall "spAttachmentLoader_dispose" spAttachmentLoader_dispose_FFI
    :: Ptr SpAttachmentLoader -- ^ self
    -> IO ()

-- | Called to create each attachment. Returns 0 to not load an attachment. If 0 is returned and _spAttachmentLoader_setError was called, an error occurred.
foreign import ccall "spAttachmentLoader_createAttachment" spAttachmentLoader_createAttachment_FFI
    :: Ptr SpAttachmentLoader -- ^ self
    -> Ptr SpSkin -- ^ skin
    -> SpAttachmentType -- ^ type
    -> CString -- ^ name
    -> CString -- ^ path
    -> IO Ptr SpAttachment

-- | Called after the attachment has been fully configured.
foreign import ccall "spAttachmentLoader_configureAttachment" spAttachmentLoader_configureAttachment_FFI
    :: Ptr SpAttachmentLoader -- ^ self
    -> Ptr SpAttachment -- ^ attachment
    -> IO ()

-- | Called just before the attachment is disposed. This can release allocations made in spAttachmentLoader_configureAttachment.
foreign import ccall "spAttachmentLoader_disposeAttachment" spAttachmentLoader_disposeAttachment_FFI
    :: Ptr SpAttachmentLoader -- ^ self
    -> Ptr SpAttachment -- ^ attachment
    -> IO ()
