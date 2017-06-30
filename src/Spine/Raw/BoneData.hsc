module Spine.Raw.BoneData
    ( -- * functions
      spBoneData_create
    , spBoneData_dispose
    ) where
--
#include "spine/BoneData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--

foreign import ccall "spBoneData_create" spBoneData_create_FFI
    :: CInt -- ^ index
    -> CString -- ^ name
    -> Ptr SpBoneData -- ^ parent
    -> IO Ptr SpBoneData

foreign import ccall "spBoneData_dispose" spBoneData_dispose_FFI
    :: Ptr SpBoneData -- ^ self
    -> IO ()
