module Spine.Raw.PathAttachment
    ( -- * functions
      spPathAttachment_create_FFI
    , spPathAttachment_computeWorldVertices_FFI
    , spPathAttachment_computeWorldVertices1_FFI
    ) where
--
#include "spine/PathAttachment.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spPathAttachment_create" spPathAttachment_create_FFI
    :: CString -- ^ name
    -> IO (Ptr SpPathAttachment)

foreign import ccall "spPathAttachment_computeWorldVertices" spPathAttachment_computeWorldVertices_FFI
    :: Ptr SpPathAttachment -- ^ self
    -> Ptr SpSlot -- ^ slot
    -> Ptr CFloat -- ^ worldVertices
    -> IO ()

foreign import ccall "spPathAttachment_computeWorldVertices1" spPathAttachment_computeWorldVertices1_FFI
    :: Ptr SpPathAttachment -- ^ self
    -> Ptr SpSlot -- ^ slot
    -> CInt -- ^ start
    -> CInt -- ^ count
    -> Ptr CFloat -- ^ worldVertices
    -> CInt -- ^ offset
    -> IO ()
