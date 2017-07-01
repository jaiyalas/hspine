module Spine.Raw.VertexAttachment
    ( -- * functions
      spVertexAttachment_computeWorldVertices_FFI
    , spVertexAttachment_computeWorldVertices1_FFI
    ) where
--
#include "spine/TransformConstraintData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spVertexAttachment_computeWorldVertices" spVertexAttachment_computeWorldVertices_FFI
    :: Ptr SpVertexAttachment -- ^ self
    -> Ptr SpSlot -- ^ slot
    -> Ptr CFloat -- ^ worldVertices
    -> IO ()

foreign import ccall "spVertexAttachment_computeWorldVertices1" spVertexAttachment_computeWorldVertices1_FFI
    :: Ptr SpVertexAttachment -- ^ self
    -> CInt -- ^ start
    -> CInt -- ^ count
    -> Ptr SpSlot -- ^ slot
    -> Ptr CFloat -- ^ worldVertices
    -> CInt -- ^ offset
    -> IO ()
