module Spine.Raw.BoundingBoxAttachment
    ( -- * functions
      spBoundingBoxAttachment_create
    , spBoundingBoxAttachment_computeWorldVertices
    ) where
--
#include "spine/BoundingBoxAttachment.h"
--
import Foreign.C.Types
import Spine.Raw.InternalStruct
--

foreign import ccall "spBoundingBoxAttachment_create" spBoundingBoxAttachment_create_FFI
    :: CString -- ^ name
    -> IO Ptr SpBoundingBoxAttachment

foreign import ccall "spBoundingBoxAttachment_computeWorldVertices" spBoundingBoxAttachment_computeWorldVertices_FFI
    :: Ptr SpBoundingBoxAttachment -- ^ self
    -> Ptr SpSlot -- ^ slot
    -> Ptr CFloat -- ^ worldVertices
    -> IO ()
