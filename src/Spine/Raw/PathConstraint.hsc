module Spine.Raw.PathConstraint
    ( -- * functions
      spPathConstraint_create_FFI
    , spPathConstraint_dispose_FFI
    , spPathConstraint_apply_FFI
    ) where
--
#include "spine/PathConstraint.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spPathConstraint_create" spPathConstraint_create_FFI
    :: Ptr SpPathConstraintData -- ^ data
    -> Ptr SpSkeleton -- ^ skeleton
    -> IO (Ptr SpPathConstraint)

foreign import ccall "spPathConstraint_dispose" spPathConstraint_dispose_FFI
    :: Ptr SpPathConstraint -- ^ self
    -> IO ()

foreign import ccall "spPathConstraint_apply" spPathConstraint_apply_FFI
    :: Ptr SpPathConstraint -- ^ self
    -> IO ()
