module Spine.Raw.TransformConstraint
    ( -- * functions
      spTransformConstraint_create_FFI
    , spTransformConstraint_dispose_FFI
    , spTransformConstraint_apply_FFI
    ) where

--
#include "spine/TransformConstraint.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spTransformConstraint_create" spTransformConstraint_create_FFI
    :: Ptr SpTransformConstraintData -- ^ data
    -> Ptr SpSkeleton -- ^ skeleton
    -> IO (Ptr SpTransformConstraint)

foreign import ccall "spTransformConstraint_dispose" spTransformConstraint_dispose_FFI
    :: Ptr SpTransformConstraint -- ^ self
    -> IO ()

foreign import ccall "spTransformConstraint_apply" spTransformConstraint_apply_FFI
    :: Ptr SpTransformConstraint -- ^ self
    -> IO ()
