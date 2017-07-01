module Spine.Raw.SkeletonJson
    ( -- * functions
      spSkeletonJson_createWithLoader_FFI
    , spSkeletonJson_create_FFI
    , spSkeletonJson_dispose_FFI
    , spSkeletonJson_readSkeletonData_FFI
    , spSkeletonJson_readSkeletonDataFile_FFI
    ) where
--
#include "spine/SkeletonJson.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spSkeletonJson_createWithLoader" spSkeletonJson_createWithLoader_FFI
    :: Ptr SpAttachmentLoader -- ^ attachmentLoader
    -> IO (Ptr SpSkeletonJson)

foreign import ccall "spSkeletonJson_create" spSkeletonJson_create_FFI
    :: Ptr SpAtlas -- ^ atlas
    -> IO (Ptr SpSkeletonJson)

foreign import ccall "spSkeletonJson_dispose" spSkeletonJson_dispose_FFI
    :: Ptr SpSkeletonJson -- ^ self
    -> IO ()

foreign import ccall "spSkeletonJson_readSkeletonData" spSkeletonJson_readSkeletonData_FFI
    :: Ptr SpSkeletonJson -- ^ self
    -> CString -- ^ json
    -> IO (Ptr SpSkeletonData)

foreign import ccall "spSkeletonJson_readSkeletonDataFile" spSkeletonJson_readSkeletonDataFile_FFI
    :: Ptr SpSkeletonJson -- ^ self
    -> CString -- ^ path
    -> IO (Ptr SpSkeletonData)
