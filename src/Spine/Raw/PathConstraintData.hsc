module Spine.Raw.PathConstraintData
    ( -- * functions
      spPathConstraintData_create_FFI
    , spPathConstraintData_dispose_FFI
    )where
--
#include "spine/PathConstraintData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spPathConstraintData_create" spPathConstraintData_create_FFI
    :: CString -- ^ name
    -> IO (Ptr SpPathConstraintData)

foreign import ccall "spPathConstraintData_dispose" spPathConstraintData_dispose_FFI
    :: Ptr SpPathConstraintData -- ^ self
    -> IO ()
