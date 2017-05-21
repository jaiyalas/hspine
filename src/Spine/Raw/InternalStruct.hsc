module Spine.Raw.InternalStruct where
--
#include "spine/Animation.h"
#include "spine/AnimationState.h"
#include "spine/AnimationStateData.h"
#include "spine/Atlas.h"
#include "spine/AtlasAttachmentLoader.h"
#include "spine/Attachment.h"
#include "spine/AttachmentLoader.h"
#include "spine/Bone.h"
#include "spine/BoneData.h"
#include "spine/BoundingBoxAttachment.h"
#include "spine/Event.h"
#include "spine/EventData.h"
#include "spine/IkConstraint.h"
#include "spine/IkConstraintData.h"
#include "spine/MeshAttachment.h"
#include "spine/PathAttachment.h"
#include "spine/PathConstraint.h"
#include "spine/PathConstraintData.h"
#include "spine/RegionAttachment.h"
#include "spine/Skeleton.h"
#include "spine/SkeletonBinary.h"
#include "spine/SkeletonBounds.h"
#include "spine/SkeletonData.h"
#include "spine/SkeletonJson.h"
#include "spine/Skin.h"
#include "spine/Slot.h"
#include "spine/SlotData.h"
#include "spine/TransformConstraint.h"
#include "spine/TransformConstraintData.h"
#include "spine/VertexAttachment.h"
--
import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String
import Foreign.Storable
--
import Data.Default
import Spine.Raw.InternalEnum
--
#if __GLASGOW_HASKELL__ < 800
#let alignment t = "%lu", (unsigned long)offsetof(struct {char x__; t (y__); }, y__)
#endif
--
--  "spine/Animation"

--  "spine/AnimationState"
--  "spine/AnimationStateData"
--  "spine/Atlas"
--  "spine/AtlasAttachmentLoader"
--  "spine/Attachment"
--  "spine/AttachmentLoader"
--  "spine/Bone"
--  "spine/BoneData"
data SpBoneData = SpBoneData
    { spBoneData_index    :: CInt
    , spBoneData_name     :: CString
    , spBoneData_parent   :: Ptr SpBoneData
    , spBoneData_length   :: CFloat
    , spBoneData_x        :: CFloat
    , spBoneData_y        :: CFloat
    , spBoneData_rotation :: CFloat
    , spBoneData_scaleX   :: CFloat
    , spBoneData_scaleY   :: CFloat
    , spBoneData_shearX   :: CFloat
    , spBoneData_shearY   :: CFloat
    , spBoneData_transformMode :: TransformMode
    } deriving (Show, Eq)
instance Storable SpBoneData where
    alignment _ = #{alignment spBoneData}
    sizeOf _ = #{size spBoneData}
    peek ptr = do
        i <-   #{peek spBoneData, index} ptr
        n <-   #{peek spBoneData, name} ptr
        p <-   #{peek spBoneData, parent} ptr
        l <-   #{peek spBoneData, length} ptr
        x <-   #{peek spBoneData, x} ptr
        y <-   #{peek spBoneData, y} ptr
        r <-   #{peek spBoneData, rotation} ptr
        sx <-  #{peek spBoneData, scaleX} ptr
        sy <-  #{peek spBoneData, scaleY} ptr
        shx <- #{peek spBoneData, shearX} ptr
        shy <- #{peek spBoneData, shearY} ptr
        t <-   #{peek spBoneData, transformMode} ptr
        return (SpBoneData i n p l x y r sx sy shx shy t)
    poke ptr (SpBoneData i n p l x y r sx sy shx shy t) = do
        #{poke spBoneData, index} ptr i
        #{poke spBoneData, name} ptr n
        #{poke spBoneData, parent} ptr p
        #{poke spBoneData, length} ptr l
        #{poke spBoneData, x} ptr x
        #{poke spBoneData, y} ptr y
        #{poke spBoneData, rotation} ptr r
        #{poke spBoneData, scaleX} ptr sx
        #{poke spBoneData, scaleY} ptr sy
        #{poke spBoneData, shearX} ptr shx
        #{poke spBoneData, shearY} ptr shy
        #{poke spBoneData, transformMode} ptr t
instance Default SpBoneData where
    def = SpBoneData 0 nullPtr nullPtr 0 0 0 0 0 0 0 0 TRANSFORMMODE_NORMAL

--  "spine/BoundingBoxAttachment"
--  "spine/Event"
--  "spine/EventData"
--  "spine/IkConstraint"
--  "spine/IkConstraintData"
--  "spine/MeshAttachment"
--  "spine/PathAttachment"
--  "spine/PathConstraint"
--  "spine/PathConstraintData"
--  "spine/RegionAttachment"
--  "spine/Skeleton"
--  "spine/SkeletonBinary"
--  "spine/SkeletonBounds"
--  "spine/SkeletonData"
--  "spine/SkeletonJson"
--  "spine/Skin"
--  "spine/Slot"
--  "spine/SlotData"
--  "spine/TransformConstraint"
--  "spine/TransformConstraintData"
--  "spine/VertexAttachment"
