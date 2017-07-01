module Spine.Raw.MeshAttachment
    ( -- * functions
      spMeshAttachment_create_FFI
    , spMeshAttachment_updateUVs_FFI
    , spMeshAttachment_computeWorldVertices_FFI
    , spMeshAttachment_setParentMesh_FFI
    ) where
--
#include "spine/MeshAttachment.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spMeshAttachment_create" spMeshAttachment_create_FFI
    :: CString -- ^ name
    -> IO (Ptr SpMeshAttachment)

foreign import ccall "spMeshAttachment_updateUVs" spMeshAttachment_updateUVs_FFI
    :: Ptr SpMeshAttachment -- ^ self
    -> IO ()

foreign import ccall "spMeshAttachment_computeWorldVertices" spMeshAttachment_computeWorldVertices_FFI
    :: Ptr SpMeshAttachment -- ^ self
    -> Ptr SpSlot -- ^ slot
    -> Ptr CFloat -- ^ worldVertices
    -> IO ()

foreign import ccall "spMeshAttachment_setParentMesh" spMeshAttachment_setParentMesh_FFI
    :: Ptr SpMeshAttachment -- ^ self
    -> Ptr SpMeshAttachment -- ^ parentMesh
    -> IO ()
