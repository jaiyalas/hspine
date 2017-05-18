module Spine.Raw.BoneData where
--
#include "spine/BoneData.h"
--
import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String
import Foreign.Storable
--
import Data.Default
import Spine.Raw.Enum
import Spine.Raw.Struct
--

foreign import ccall "spBoneData_create" spBoneData_create_FFI ::
    CInt -> CString -> Ptr SpBoneData -> IO (Ptr SpBoneData)

foreign import ccall "spBoneData_dispose" spBoneData_dispose_FFI ::
    Ptr SpBoneData -> IO ()
