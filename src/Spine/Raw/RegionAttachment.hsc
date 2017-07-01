module Spine.Raw.RegionAttachment
    ( -- functions
      spRegionAttachment_create_FFI
    , spRegionAttachment_setUVs_FFI
    , spRegionAttachment_updateOffset_FFI
    , spRegionAttachment_computeWorldVertices_FFI
    )where
--
#include "spine/RegionAttachment.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spRegionAttachment_create" spRegionAttachment_create_FFI
    :: CString -- ^ name
    -> IO (Ptr SpRegionAttachment)

foreign import ccall "spRegionAttachment_setUVs" spRegionAttachment_setUVs_FFI
    :: Ptr SpRegionAttachment -- ^ self
    -> CFloat -- ^ u
    -> CFloat -- ^ v
    -> CFloat -- ^ u2
    -> CFloat -- ^ v2
    -> CInt -- ^ rotate :: boolean
    -> IO ()

foreign import ccall "spRegionAttachment_updateOffset" spRegionAttachment_updateOffset_FFI
    :: Ptr SpRegionAttachment -- ^ self
    -> IO ()

foreign import ccall "spRegionAttachment_computeWorldVertices" spRegionAttachment_computeWorldVertices_FFI
    :: Ptr SpRegionAttachment -- ^ self
    -> Ptr SpBone -- ^ bone
    -> Ptr CFloat -- ^ vertices
    -> IO ()
