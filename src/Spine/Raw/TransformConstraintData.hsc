module Spine.Raw.TransformConstraintData
    ( -- * functions
      spTransformConstraintData_create_FFI
    , spTransformConstraintData_dispose_FFI
    ) where
--
#include "spine/TransformConstraintData.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spTransformConstraintData_create" spTransformConstraintData_create_FFI
    :: CString -- ^ name
    -> IO (Ptr SpTransformConstraintData)

foreign import ccall "spTransformConstraintData_dispose" spTransformConstraintData_dispose_FFI
    :: Ptr SpTransformConstraintData -- ^ self
    -> IO ()
