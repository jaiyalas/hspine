{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternSynonyms #-}
--
module Spine.Raw.InternalEnum where
--
#include "spine/BoneData.h"
#include "spine/Attachment.h"
#include "spine/SlotData.h"
#include "spine/PathConstraintData.h"
--
import Foreign.C.Types

-- from "spine/BoneData.h"
type TransformMode = CInt
pattern TRANSFORMMODE_NORMAL :: TransformMode
pattern TRANSFORMMODE_NORMAL =
    (#const SP_TRANSFORMMODE_NORMAL)
pattern TRANSFORMMODE_ONLYTRANSLATION :: TransformMode
pattern TRANSFORMMODE_ONLYTRANSLATION =
    (#const SP_TRANSFORMMODE_ONLYTRANSLATION)
pattern TRANSFORMMODE_NOROTATIONORREFLECTION :: TransformMode
pattern TRANSFORMMODE_NOROTATIONORREFLECTION =
    (#const SP_TRANSFORMMODE_NOROTATIONORREFLECTION)
pattern TRANSFORMMODE_NOSCALE :: TransformMode
pattern TRANSFORMMODE_NOSCALE =
    (#const SP_TRANSFORMMODE_NOSCALE)
pattern TRANSFORMMODE_NOSCALEORREFLECTION :: TransformMode
pattern TRANSFORMMODE_NOSCALEORREFLECTION =
    (#const SP_TRANSFORMMODE_NOSCALEORREFLECTION)

-- from "spine/Attachment.h"
type AttachmentType = CInt
pattern ATTACHMENT_REGION :: AttachmentType
pattern ATTACHMENT_REGION =
    (#const SP_ATTACHMENT_REGION)
pattern ATTACHMENT_BOUNDING_BOX :: AttachmentType
pattern ATTACHMENT_BOUNDING_BOX =
    (#const SP_ATTACHMENT_BOUNDING_BOX)
pattern ATTACHMENT_MESH :: AttachmentType
pattern ATTACHMENT_MESH =
    (#const SP_ATTACHMENT_MESH)
pattern ATTACHMENT_LINKED_MESH :: AttachmentType
pattern ATTACHMENT_LINKED_MESH =
    (#const SP_ATTACHMENT_LINKED_MESH)
pattern ATTACHMENT_PATH :: AttachmentType
pattern ATTACHMENT_PATH =
    (#const SP_ATTACHMENT_PATH)

-- from "spine/SlotData.h"
type BlendMode = CInt
pattern BLEND_MODE_NORMAL :: BlendMode
pattern BLEND_MODE_NORMAL = (#const SP_BLEND_MODE_NORMAL)
pattern BLEND_MODE_ADDITIVE :: BlendMode
pattern BLEND_MODE_ADDITIVE = (#const SP_BLEND_MODE_ADDITIVE)
pattern BLEND_MODE_MULTIPLY :: BlendMode
pattern BLEND_MODE_MULTIPLY = (#const SP_BLEND_MODE_MULTIPLY)
pattern BLEND_MODE_SCREEN :: BlendMode
pattern BLEND_MODE_SCREEN = (#const SP_BLEND_MODE_SCREEN)

-- from "spine/PathConstraintData.h"
type PositionMode = CInt
pattern POSITION_MODE_FIXED :: PositionMode
pattern POSITION_MODE_FIXED = (#const SP_POSITION_MODE_FIXED)
pattern POSITION_MODE_PERCENT :: PositionMode
pattern POSITION_MODE_PERCENT = (#const SP_POSITION_MODE_PERCENT)
type SpacingMode = CInt
pattern SPACING_MODE_LENGTH :: SpacingMode
pattern SPACING_MODE_LENGTH = (#const SP_SPACING_MODE_LENGTH)
pattern SPACING_MODE_FIXED :: SpacingMode
pattern SPACING_MODE_FIXED = (#const SP_SPACING_MODE_FIXED)
pattern SPACING_MODE_PERCENT :: SpacingMode
pattern SPACING_MODE_PERCENT = (#const SP_SPACING_MODE_PERCENT)
type RotateMode = CInt
pattern ROTATE_MODE_TANGENT :: SpacingMode
pattern ROTATE_MODE_TANGENT = (#const SP_ROTATE_MODE_TANGENT)
pattern ROTATE_MODE_CHAIN :: SpacingMode
pattern ROTATE_MODE_CHAIN = (#const SP_ROTATE_MODE_CHAIN)
pattern ROTATE_MODE_CHAIN_SCALE :: SpacingMode
pattern ROTATE_MODE_CHAIN_SCALE = (#const SP_ROTATE_MODE_CHAIN_SCALE)
