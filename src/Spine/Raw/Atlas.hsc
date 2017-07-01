module Spine.Raw.Atlas
    ( -- * functions
      spAtlasPage_create_FFI
    , spAtlasPage_dispose_FFI
    , spAtlasRegion_create_FFI
    , spAtlasRegion_dispose_FFI
    , spAtlas_create_FFI
    , spAtlas_createFromFile_FFI
    , spAtlas_dispose_FFI
    , spAtlas_findRegion_FFI
    ) where
--
#include "spine/Atlas.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spAtlasPage_create" spAtlasPage_create_FFI
    :: Ptr SpAtlas -- ^ atlas
    -> CString -- ^ name
    -> IO (Ptr SpAtlasPage)

foreign import ccall "spAtlasPage_dispose" spAtlasPage_dispose_FFI
    :: Ptr SpAtlasPage -- ^ self
    -> IO ()

foreign import ccall "spAtlasRegion_create" spAtlasRegion_create_FFI
    :: IO (Ptr SpAtlasRegion)

foreign import ccall "spAtlasRegion_dispose" spAtlasRegion_dispose_FFI
    :: Ptr SpAtlasRegion -- ^ self
    -> IO ()

-- | Image files referenced in the atlas file will be prefixed with dir.
foreign import ccall "spAtlas_create" spAtlas_create_FFI
    :: CString -- ^ data
    -> CInt -- ^ length
    -> CString -- ^ dir
    -> Ptr () -- ^ rendererObject
    -> IO (Ptr SpAtlas)

-- | Image files referenced in the atlas file will be prefixed with the directory containing the atlas file.
foreign import ccall "spAtlas_createFromFile" spAtlas_createFromFile_FFI
    :: CString -- ^ path
    -> Ptr () -- ^ rendererObject
    -> IO (Ptr SpAtlas)

foreign import ccall "spAtlas_dispose" spAtlas_dispose_FFI
    :: Ptr SpAtlas -- ^ atlas
    -> IO ()

-- | Returns 0 if the region was not found.
foreign import ccall "spAtlas_findRegion" spAtlas_findRegion_FFI
    :: Ptr SpAtlas -- ^ self
    -> CString -- ^ name
    -> IO (Ptr SpAtlasRegion)
--
