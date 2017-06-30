module Spine.Raw.Attachment
    ( -- * functions
      spAttachment_dispose
    ) where
--
#include "spine/Attachment.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spAttachment_dispose" spAttachment_dispose_FFI
    :: Ptr SpAttachment -- ^ self
    -> IO ()
