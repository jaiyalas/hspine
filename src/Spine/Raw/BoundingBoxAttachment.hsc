module Spine.Raw.BoundingBoxAttachment
    ( -- * functions
      spBoundingBoxAttachment_create_FFI
    , spBoundingBoxAttachment_computeWorldVertices_FFI
    ) where
--
#include "spine/BoundingBoxAttachment.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--

foreign import ccall "spBoundingBoxAttachment_create" spBoundingBoxAttachment_create_FFI
    :: CString -- ^ name
    -> IO (Ptr SpBoundingBoxAttachment)

foreign import ccall "spBoundingBoxAttachment_computeWorldVertices" spBoundingBoxAttachment_computeWorldVertices_FFI
    :: Ptr SpBoundingBoxAttachment -- ^ self
    -> Ptr SpSlot -- ^ slot
    -> Ptr CFloat -- ^ worldVertices
    -> IO ()
