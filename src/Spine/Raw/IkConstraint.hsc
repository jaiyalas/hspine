module Spine.Raw.IkConstraint
    ( -- * functions
      spIkConstraint_create_FFI
    , spIkConstraint_dispose_FFI
    , spIkConstraint_apply_FFI
    , spIkConstraint_apply1_FFI
    , spIkConstraint_apply2_FFI
    ) where
--
#include "spine/IkConstraint.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spIkConstraint_create" spIkConstraint_create_FFI
    :: Ptr SpIkConstraintData -- ^ data
    -> Ptr SpSkeleton -- ^ skeleton
    -> IO (Ptr SpIkConstraint)

foreign import ccall "spIkConstraint_dispose" spIkConstraint_dispose_FFI
    :: Ptr SpIkConstraint -- ^ self
    -> IO ()

foreign import ccall "spIkConstraint_apply" spIkConstraint_apply_FFI
    :: Ptr SpIkConstraint -- ^ self
    -> IO ()

foreign import ccall "spIkConstraint_apply1" spIkConstraint_apply1_FFI
    :: Ptr SpBone -- ^ bone
    -> CFloat -- ^ targetX
    -> CFloat -- ^ targetY
    -> CFloat -- ^ alpha
    -> IO ()

foreign import ccall "spIkConstraint_apply2" spIkConstraint_apply2_FFI
    :: Ptr SpBone -- ^ parent
    -> Ptr SpBone -- ^ child
    -> CFloat -- ^ targetX
    -> CFloat -- ^ targetY
    -> CInt -- ^ bendDirection
    -> CFloat -- ^ alpha
    -> IO ()
