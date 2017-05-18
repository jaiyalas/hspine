{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternSynonyms #-}
--
module Spine.Raw.InternalEnum
    (
    -- * "spine/AnimationState.h"
    -- ** EventType
      EventType
    , pattern ANIMATION_START
    , pattern ANIMATION_INTERRUPT
    , pattern ANIMATION_END
    , pattern ANIMATION_COMPLETE
    , pattern ANIMATION_DISPOSE
    , pattern ANIMATION_EVENT
    -- * "spine/Atlas.h"
    -- ** AtlasFormat
    , AtlasFormat
    , pattern ATLAS_UNKNOWN_FORMAT
    , pattern ATLAS_ALPHA
    , pattern ATLAS_INTENSITY
    , pattern ATLAS_LUMINANCE_ALPHA
    , pattern ATLAS_RGB565
    , pattern ATLAS_RGBA4444
    , pattern ATLAS_RGB888
    , pattern ATLAS_RGBA8888
    -- ** AtlasFilter
    , AtlasFilter
    , pattern ATLAS_UNKNOWN_FILTER
    , pattern ATLAS_NEAREST
    , pattern ATLAS_LINEAR
    , pattern ATLAS_MIPMAP
    , pattern ATLAS_MIPMAP_NEAREST_NEAREST
    , pattern ATLAS_MIPMAP_LINEAR_NEAREST
    , pattern ATLAS_MIPMAP_NEAREST_LINEAR
    , pattern ATLAS_MIPMAP_LINEAR_LINEAR
    -- ** AtlasWrap
    , AtlasWrap
    , pattern ATLAS_MIRROREDREPEAT
    , pattern ATLAS_CLAMPTOEDGE
    , pattern ATLAS_REPEAT
    -- * "spine/Attachment.h"
    -- ** AttachmentType
    , AttachmentType
    , pattern ATTACHMENT_REGION
    , pattern ATTACHMENT_BOUNDING_BOX
    , pattern ATTACHMENT_MESH
    , pattern ATTACHMENT_LINKED_MESH
    , pattern ATTACHMENT_PATH
    -- * "spine/BoneData.h"
    -- ** TransformMode
    , TransformMode
    , pattern TRANSFORMMODE_NORMAL
    , pattern TRANSFORMMODE_ONLYTRANSLATION
    , pattern TRANSFORMMODE_NOROTATIONORREFLECTION
    , pattern TRANSFORMMODE_NOSCALE
    , pattern TRANSFORMMODE_NOSCALEORREFLECTION
    -- * "spine/PathConstraintData.h"
    -- ** PositionMode
    , PositionMode
    , pattern POSITION_MODE_FIXED
    , pattern POSITION_MODE_PERCENT
    -- ** SpacingMode
    , SpacingMode
    , pattern SPACING_MODE_LENGTH
    , pattern SPACING_MODE_FIXED
    , pattern SPACING_MODE_PERCENT
    -- ** RotateMode
    , RotateMode
    , pattern ROTATE_MODE_TANGENT
    , pattern ROTATE_MODE_CHAIN
    , pattern ROTATE_MODE_CHAIN_SCALE
    -- * "spine/RegionAttachment.h"
    -- ** VertexIndex
    , VertexIndex
    , pattern VERTEX_X1
    , pattern VERTEX_Y1
    , pattern VERTEX_X2
    , pattern VERTEX_Y2
    , pattern VERTEX_X3
    , pattern VERTEX_Y3
    , pattern VERTEX_X4
    , pattern VERTEX_Y4
    -- * "spine/SlotData.h"
    -- ** BlendMode
    , BlendMode
    , pattern BLEND_MODE_NORMAL
    , pattern BLEND_MODE_ADDITIVE
    , pattern BLEND_MODE_MULTIPLY
    , pattern BLEND_MODE_SCREEN
    ) where
--
import Foreign.C.Types
--
#include "spine/AnimationState.h"
#include "spine/Atlas.h"
#include "spine/Attachment.h"
#include "spine/BoneData.h"
#include "spine/PathConstraintData.h"
#include "spine/RegionAttachment.h"
#include "spine/SlotData.h"
--

-- from "spine/AnimationState.h"
type EventType = CInt
pattern ANIMATION_START :: EventType
pattern ANIMATION_START = #{const SP_ANIMATION_START}
pattern ANIMATION_INTERRUPT :: EventType
pattern ANIMATION_INTERRUPT = #{const SP_ANIMATION_INTERRUPT}
pattern ANIMATION_END :: EventType
pattern ANIMATION_END = #{const SP_ANIMATION_END}
pattern ANIMATION_COMPLETE :: EventType
pattern ANIMATION_COMPLETE = #{const SP_ANIMATION_COMPLETE}
pattern ANIMATION_DISPOSE :: EventType
pattern ANIMATION_DISPOSE = #{const SP_ANIMATION_DISPOSE}
pattern ANIMATION_EVENT :: EventType
pattern ANIMATION_EVENT = #{const SP_ANIMATION_EVENT}

-- from "spine/Atlas.h"
type AtlasFormat = CInt
pattern ATLAS_UNKNOWN_FORMAT :: AtlasFormat
pattern ATLAS_UNKNOWN_FORMAT = #{const SP_ATLAS_UNKNOWN_FORMAT}
pattern ATLAS_ALPHA :: AtlasFormat
pattern ATLAS_ALPHA = #{const SP_ATLAS_ALPHA}
pattern ATLAS_INTENSITY :: AtlasFormat
pattern ATLAS_INTENSITY = #{const SP_ATLAS_INTENSITY}
pattern ATLAS_LUMINANCE_ALPHA :: AtlasFormat
pattern ATLAS_LUMINANCE_ALPHA = #{const SP_ATLAS_LUMINANCE_ALPHA}
pattern ATLAS_RGB565 :: AtlasFormat
pattern ATLAS_RGB565 = #{const SP_ATLAS_RGB565}
pattern ATLAS_RGBA4444 :: AtlasFormat
pattern ATLAS_RGBA4444 = #{const SP_ATLAS_RGBA4444}
pattern ATLAS_RGB888 :: AtlasFormat
pattern ATLAS_RGB888 = #{const SP_ATLAS_RGB888}
pattern ATLAS_RGBA8888 :: AtlasFormat
pattern ATLAS_RGBA8888 = #{const SP_ATLAS_RGBA8888}
type AtlasFilter = CInt
pattern ATLAS_UNKNOWN_FILTER :: AtlasFilter
pattern ATLAS_UNKNOWN_FILTER = #{const SP_ATLAS_UNKNOWN_FILTER}
pattern ATLAS_NEAREST :: AtlasFilter
pattern ATLAS_NEAREST = #{const SP_ATLAS_NEAREST}
pattern ATLAS_LINEAR :: AtlasFilter
pattern ATLAS_LINEAR = #{const SP_ATLAS_LINEAR}
pattern ATLAS_MIPMAP :: AtlasFilter
pattern ATLAS_MIPMAP = #{const SP_ATLAS_MIPMAP}
pattern ATLAS_MIPMAP_NEAREST_NEAREST :: AtlasFilter
pattern ATLAS_MIPMAP_NEAREST_NEAREST = #{const SP_ATLAS_MIPMAP_NEAREST_NEAREST}
pattern ATLAS_MIPMAP_LINEAR_NEAREST :: AtlasFilter
pattern ATLAS_MIPMAP_LINEAR_NEAREST = #{const SP_ATLAS_MIPMAP_LINEAR_NEAREST}
pattern ATLAS_MIPMAP_NEAREST_LINEAR :: AtlasFilter
pattern ATLAS_MIPMAP_NEAREST_LINEAR = #{const SP_ATLAS_MIPMAP_NEAREST_LINEAR}
pattern ATLAS_MIPMAP_LINEAR_LINEAR :: AtlasFilter
pattern ATLAS_MIPMAP_LINEAR_LINEAR = #{const SP_ATLAS_MIPMAP_LINEAR_LINEAR}
type AtlasWrap = CInt
pattern ATLAS_MIRROREDREPEAT :: AtlasWrap
pattern ATLAS_MIRROREDREPEAT = #{const SP_ATLAS_MIRROREDREPEAT}
pattern ATLAS_CLAMPTOEDGE :: AtlasWrap
pattern ATLAS_CLAMPTOEDGE = #{const SP_ATLAS_CLAMPTOEDGE}
pattern ATLAS_REPEAT :: AtlasWrap
pattern ATLAS_REPEAT = #{const SP_ATLAS_REPEAT}

-- from "spine/Attachment.h"
type AttachmentType = CInt
pattern ATTACHMENT_REGION :: AttachmentType
pattern ATTACHMENT_REGION = #{const SP_ATTACHMENT_REGION}
pattern ATTACHMENT_BOUNDING_BOX :: AttachmentType
pattern ATTACHMENT_BOUNDING_BOX = #{const SP_ATTACHMENT_BOUNDING_BOX}
pattern ATTACHMENT_MESH :: AttachmentType
pattern ATTACHMENT_MESH = #{const SP_ATTACHMENT_MESH}
pattern ATTACHMENT_LINKED_MESH :: AttachmentType
pattern ATTACHMENT_LINKED_MESH = #{const SP_ATTACHMENT_LINKED_MESH}
pattern ATTACHMENT_PATH :: AttachmentType
pattern ATTACHMENT_PATH = #{const SP_ATTACHMENT_PATH}

-- from "spine/BoneData.h"
type TransformMode = CInt
pattern TRANSFORMMODE_NORMAL :: TransformMode
pattern TRANSFORMMODE_NORMAL = #{const SP_TRANSFORMMODE_NORMAL}
pattern TRANSFORMMODE_ONLYTRANSLATION :: TransformMode
pattern TRANSFORMMODE_ONLYTRANSLATION = #{const SP_TRANSFORMMODE_ONLYTRANSLATION}
pattern TRANSFORMMODE_NOROTATIONORREFLECTION :: TransformMode
pattern TRANSFORMMODE_NOROTATIONORREFLECTION = #{const SP_TRANSFORMMODE_NOROTATIONORREFLECTION}
pattern TRANSFORMMODE_NOSCALE :: TransformMode
pattern TRANSFORMMODE_NOSCALE = #{const SP_TRANSFORMMODE_NOSCALE}
pattern TRANSFORMMODE_NOSCALEORREFLECTION :: TransformMode
pattern TRANSFORMMODE_NOSCALEORREFLECTION = #{const SP_TRANSFORMMODE_NOSCALEORREFLECTION}

-- from "spine/PathConstraintData.h"
type PositionMode = CInt
pattern POSITION_MODE_FIXED :: PositionMode
pattern POSITION_MODE_FIXED = #{const SP_POSITION_MODE_FIXED}
pattern POSITION_MODE_PERCENT :: PositionMode
pattern POSITION_MODE_PERCENT = #{const SP_POSITION_MODE_PERCENT}
type SpacingMode = CInt
pattern SPACING_MODE_LENGTH :: SpacingMode
pattern SPACING_MODE_LENGTH = #{const SP_SPACING_MODE_LENGTH}
pattern SPACING_MODE_FIXED :: SpacingMode
pattern SPACING_MODE_FIXED = #{const SP_SPACING_MODE_FIXED}
pattern SPACING_MODE_PERCENT :: SpacingMode
pattern SPACING_MODE_PERCENT = #{const SP_SPACING_MODE_PERCENT}
type RotateMode = CInt
pattern ROTATE_MODE_TANGENT :: RotateMode
pattern ROTATE_MODE_TANGENT = #{const SP_ROTATE_MODE_TANGENT}
pattern ROTATE_MODE_CHAIN :: RotateMode
pattern ROTATE_MODE_CHAIN = #{const SP_ROTATE_MODE_CHAIN}
pattern ROTATE_MODE_CHAIN_SCALE :: RotateMode
pattern ROTATE_MODE_CHAIN_SCALE = #{const SP_ROTATE_MODE_CHAIN_SCALE}

-- from "spine/RegionAttachment.h"
type VertexIndex = CInt
pattern VERTEX_X1 :: VertexIndex
pattern VERTEX_X1 = #{const SP_VERTEX_X1} -- = 0
pattern VERTEX_Y1 :: VertexIndex
pattern VERTEX_Y1 = #{const SP_VERTEX_Y1}
pattern VERTEX_X2 :: VertexIndex
pattern VERTEX_X2 = #{const SP_VERTEX_X2}
pattern VERTEX_Y2 :: VertexIndex
pattern VERTEX_Y2 = #{const SP_VERTEX_Y2}
pattern VERTEX_X3 :: VertexIndex
pattern VERTEX_X3 = #{const SP_VERTEX_X3}
pattern VERTEX_Y3 :: VertexIndex
pattern VERTEX_Y3 = #{const SP_VERTEX_Y3}
pattern VERTEX_X4 :: VertexIndex
pattern VERTEX_X4 = #{const SP_VERTEX_X4}
pattern VERTEX_Y4 :: VertexIndex
pattern VERTEX_Y4 = #{const SP_VERTEX_Y4}

-- from "spine/SlotData.h"
type BlendMode = CInt
pattern BLEND_MODE_NORMAL :: BlendMode
pattern BLEND_MODE_NORMAL = #{const SP_BLEND_MODE_NORMAL}
pattern BLEND_MODE_ADDITIVE :: BlendMode
pattern BLEND_MODE_ADDITIVE = #{const SP_BLEND_MODE_ADDITIVE}
pattern BLEND_MODE_MULTIPLY :: BlendMode
pattern BLEND_MODE_MULTIPLY = #{const SP_BLEND_MODE_MULTIPLY}
pattern BLEND_MODE_SCREEN :: BlendMode
pattern BLEND_MODE_SCREEN = #{const SP_BLEND_MODE_SCREEN}
