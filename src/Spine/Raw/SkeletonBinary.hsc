module Spine.Raw.SkeletonBinary
    ( -- * functions
      spSkeletonBinary_createWithLoader_FFI
    , spSkeletonBinary_create_FFI
    , spSkeletonBinary_dispose_FFI
    ) where
--
#include "spine/SkeletonBinary.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spSkeletonBinary_createWithLoader" spSkeletonBinary_createWithLoader_FFI
    :: Ptr SpAttachmentLoader -- ^ attachmentLoader
    -> IO (Ptr SpSkeletonBinary)

foreign import ccall "spSkeletonBinary_create" spSkeletonBinary_create_FFI
    :: Ptr SpAtlas -- ^ atlas
    -> IO (Ptr SpSkeletonBinary)

foreign import ccall "spSkeletonBinary_dispose" spSkeletonBinary_dispose_FFI
    :: Ptr SpSkeletonBinary -- ^ self
    -> IO ()
