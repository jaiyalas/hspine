module Spine.Raw.Attachment
    ( -- * functions
      spAttachment_dispose_FFI
    ) where
--
#include "spine/Attachment.h"
--
import Foreign.C
import Foreign.Ptr
import Foreign.Storable
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spAttachment_dispose" spAttachment_dispose_FFI
    :: Ptr SpAttachment -- ^ self
    -> IO ()
