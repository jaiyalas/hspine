module Spine.Raw.IkConstraint where
--
#include "spine/IkConstraint.h"
--
-- import Foreign.C.Types
--



spIkConstraint* spIkConstraint_create (spIkConstraintData* data, const struct spSkeleton* skeleton);

foreign import ccall "spIkConstraint_create" spIkConstraint_create_FFI
    :: Ptr SpIkConstraintData -- ^ data
    -> Ptr SpSkeleton -- ^ skeleton
    -> IO (Ptr SpIkConstraint)


-- void spIkConstraint_dispose (spIkConstraint* self);
-- void spIkConstraint_apply (spIkConstraint* self);
-- void spIkConstraint_apply1 (spBone* bone, float targetX, float targetY, float alpha);
-- void spIkConstraint_apply2 (spBone* parent, spBone* child, float targetX, float targetY, int bendDirection, float alpha);
