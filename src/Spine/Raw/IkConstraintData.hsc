module Spine.Raw.IkConstraintData
    ( -- * functions
      spIkConstraintData_create_FFI
    , spIkConstraintData_dispose_FFI
    ) where
--
#include "spine/IkConstraintData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spIkConstraintData_create" spIkConstraintData_create_FFI
    :: CString -- ^ name
    -> IO (Ptr SpIkConstraintData)

foreign import ccall "spIkConstraintData_dispose" spIkConstraintData_dispose_FFI
    :: Ptr SpIkConstraintData -- ^ self
    -> IO ()
