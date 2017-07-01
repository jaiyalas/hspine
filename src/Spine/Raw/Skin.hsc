{-|
There are two private structs in /Skin.h/, __\_spSkin__ and __\_Entry__.
They should not be used from outside. So they are not be exposed here.
-}
module Spine.Raw.Skin
    ( -- * functions
      spSkin_create_FFI
    , spSkin_dispose_FFI
    , spSkin_addAttachment_FFI
    , spSkin_getAttachment_FFI
    , spSkin_getAttachmentName_FFI
    , spSkin_attachAll_FFI
    ) where
--
#include "spine/Skin.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spSkin_create" spSkin_create_FFI
    :: CString -- ^ name
    -> IO (Ptr SpSkin)

foreign import ccall "spSkin_dispose" spSkin_dispose_FFI
    :: Ptr SpSkin -- ^ self
    -> IO ()

-- | The Skin owns the attachment.
foreign import ccall "spSkin_addAttachment" spSkin_addAttachment_FFI
    :: Ptr SpSkin -- ^ self
    -> CInt -- ^ slotIndex
    -> CString -- ^ name
    -> Ptr SpAttachment -- ^ attachment
    -> IO ()

-- | Returns 0 if the attachment was not found.
foreign import ccall "spSkin_getAttachment" spSkin_getAttachment_FFI
    :: Ptr SpSkin -- ^ self
    -> CInt -- ^ slotIndex
    -> CString -- ^ name
    -> IO (Ptr SpAttachment)

-- | Returns 0 if the slot or attachment was not found.
foreign import ccall "spSkin_getAttachmentName" spSkin_getAttachmentName_FFI
    :: Ptr SpSkin -- ^ self
    -> CInt -- ^ slotIndex
    -> CInt -- ^ attachmentIndex
    -> IO CString

-- | * Attach each attachment in this skin if the corresponding attachment in oldSkin is currently attached.
foreign import ccall "spSkin_attachAll" spSkin_attachAll_FFI
    :: Ptr SpSkin -- ^ self
    -> Ptr SpSkeleton -- ^ skeleton
    -> Ptr SpSkin -- ^ oldspSkin
    -> IO ()
