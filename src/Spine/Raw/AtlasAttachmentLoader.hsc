module Spine.Raw.AtlasAttachmentLoader
    ( -- * functions
      spAtlasAttachmentLoader_create
    ) where
--
#include "spine/AtlasAttachmentLoader.h"
--
import Foreign.C.Types
--
import Foreign.C.Types
import Spine.Raw.InternalStruct
--
foreign import ccall "spAtlasAttachmentLoader_create" spAtlasAttachmentLoader_create_FFI
    :: Ptr SpAtlas -- ^ atlas
    -> IO Ptr SpAtlasAttachmentLoader
