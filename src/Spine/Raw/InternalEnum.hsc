{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PatternSynonyms #-}
--
module Spine.Raw.InternalEnum
    (
    -- * "spine/Animation.h"
    -- ** TimelineType
      SpTimelineType
    , pattern SP_TIMELINE_ROTATE
    , pattern SP_TIMELINE_TRANSLATE
    , pattern SP_TIMELINE_SCALE
    , pattern SP_TIMELINE_SHEAR
    , pattern SP_TIMELINE_ATTACHMENT
    , pattern SP_TIMELINE_COLOR
    , pattern SP_TIMELINE_DEFORM
    , pattern SP_TIMELINE_EVENT
    , pattern SP_TIMELINE_DRAWORDER
    , pattern SP_TIMELINE_IKCONSTRAINT
    , pattern SP_TIMELINE_TRANSFORMCONSTRAINT
    , pattern SP_TIMELINE_PATHCONSTRAINTPOSITION
    , pattern SP_TIMELINE_PATHCONSTRAINTSPACING
    , pattern SP_TIMELINE_PATHCONSTRAINTMIX
    -- * "spine/AnimationState.h"
    -- ** EventType
    , SpEventType
    , pattern SP_ANIMATION_START
    , pattern SP_ANIMATION_INTERRUPT
    , pattern SP_ANIMATION_END
    , pattern SP_ANIMATION_COMPLETE
    , pattern SP_ANIMATION_DISPOSE
    , pattern SP_ANIMATION_EVENT
    -- * "spine/Atlas.h"
    -- ** AtlasFormat
    , SpAtlasFormat
    , pattern SP_ATLAS_UNKNOWN_FORMAT
    , pattern SP_ATLAS_ALPHA
    , pattern SP_ATLAS_INTENSITY
    , pattern SP_ATLAS_LUMINANCE_ALPHA
    , pattern SP_ATLAS_RGB565
    , pattern SP_ATLAS_RGBA4444
    , pattern SP_ATLAS_RGB888
    , pattern SP_ATLAS_RGBA8888
    -- ** AtlasFilter
    , SpAtlasFilter
    , pattern SP_ATLAS_UNKNOWN_FILTER
    , pattern SP_ATLAS_NEAREST
    , pattern SP_ATLAS_LINEAR
    , pattern SP_ATLAS_MIPMAP
    , pattern SP_ATLAS_MIPMAP_NEAREST_NEAREST
    , pattern SP_ATLAS_MIPMAP_LINEAR_NEAREST
    , pattern SP_ATLAS_MIPMAP_NEAREST_LINEAR
    , pattern SP_ATLAS_MIPMAP_LINEAR_LINEAR
    -- ** AtlasWrap
    , SpAtlasWrap
    , pattern SP_ATLAS_MIRROREDREPEAT
    , pattern SP_ATLAS_CLAMPTOEDGE
    , pattern SP_ATLAS_REPEAT
    -- * "spine/Attachment.h"
    -- ** AttachmentType
    , SpAttachmentType
    , pattern SP_ATTACHMENT_REGION
    , pattern SP_ATTACHMENT_BOUNDING_BOX
    , pattern SP_ATTACHMENT_MESH
    , pattern SP_ATTACHMENT_LINKED_MESH
    , pattern SP_ATTACHMENT_PATH
    -- * "spine/BoneData.h"
    -- ** TransformMode
    , SpTransformMode
    , pattern SP_TRANSFORMMODE_NORMAL
    , pattern SP_TRANSFORMMODE_ONLYTRANSLATION
    , pattern SP_TRANSFORMMODE_NOROTATIONORREFLECTION
    , pattern SP_TRANSFORMMODE_NOSCALE
    , pattern SP_TRANSFORMMODE_NOSCALEORREFLECTION
    -- * "spine/PathConstraintData.h"
    -- ** PositionMode
    , SpPositionMode
    , pattern SP_POSITION_MODE_FIXED
    , pattern SP_POSITION_MODE_PERCENT
    -- ** SpacingMode
    , SpSpacingMode
    , pattern SP_SPACING_MODE_LENGTH
    , pattern SP_SPACING_MODE_FIXED
    , pattern SP_SPACING_MODE_PERCENT
    -- ** RotateMode
    , SpRotateMode
    , pattern SP_ROTATE_MODE_TANGENT
    , pattern SP_ROTATE_MODE_CHAIN
    , pattern SP_ROTATE_MODE_CHAIN_SCALE
    -- * "spine/RegionAttachment.h"
    -- ** VertexIndex
    , SpVertexIndex
    , pattern SP_VERTEX_X1
    , pattern SP_VERTEX_Y1
    , pattern SP_VERTEX_X2
    , pattern SP_VERTEX_Y2
    , pattern SP_VERTEX_X3
    , pattern SP_VERTEX_Y3
    , pattern SP_VERTEX_X4
    , pattern SP_VERTEX_Y4
    -- * "spine/SlotData.h"
    -- ** BlendMode
    , SpBlendMode
    , pattern SP_BLEND_MODE_NORMAL
    , pattern SP_BLEND_MODE_ADDITIVE
    , pattern SP_BLEND_MODE_MULTIPLY
    , pattern SP_BLEND_MODE_SCREEN
    ) where
--
import Foreign.C.Types
--
#include "spine/Animation.h"
#include "spine/AnimationState.h"
#include "spine/Atlas.h"
#include "spine/Attachment.h"
#include "spine/BoneData.h"
#include "spine/PathConstraintData.h"
#include "spine/RegionAttachment.h"
#include "spine/SlotData.h"
--

-- from "spine/Animation.h"
type  SpTimelineType = CInt
pattern SP_TIMELINE_ROTATE :: TimelineType
pattern SP_TIMELINE_ROTATE = #{const SP_TIMELINE_ROTATE}
pattern SP_TIMELINE_TRANSLATE :: TimelineType
pattern SP_TIMELINE_TRANSLATE = #{const SP_TIMELINE_TRANSLATE}
pattern SP_TIMELINE_SCALE :: TimelineType
pattern SP_TIMELINE_SCALE = #{const SP_TIMELINE_SCALE}
pattern SP_TIMELINE_SHEAR :: TimelineType
pattern SP_TIMELINE_SHEAR = #{const SP_TIMELINE_SHEAR}
pattern SP_TIMELINE_ATTACHMENT :: TimelineType
pattern SP_TIMELINE_ATTACHMENT = #{const SP_TIMELINE_ATTACHMENT}
pattern SP_TIMELINE_COLOR :: TimelineType
pattern SP_TIMELINE_COLOR = #{const SP_TIMELINE_COLOR}
pattern SP_TIMELINE_DEFORM :: TimelineType
pattern SP_TIMELINE_DEFORM = #{const SP_TIMELINE_DEFORM}
pattern SP_TIMELINE_EVENT :: TimelineType
pattern SP_TIMELINE_EVENT = #{const SP_TIMELINE_EVENT}
pattern SP_TIMELINE_DRAWORDER :: TimelineType
pattern SP_TIMELINE_DRAWORDER = #{const SP_TIMELINE_DRAWORDER}
pattern SP_TIMELINE_IKCONSTRAINT :: TimelineType
pattern SP_TIMELINE_IKCONSTRAINT = #{const SP_TIMELINE_IKCONSTRAINT}
pattern SP_TIMELINE_TRANSFORMCONSTRAINT :: TimelineType
pattern SP_TIMELINE_TRANSFORMCONSTRAINT = #{const SP_TIMELINE_TRANSFORMCONSTRAINT}
pattern SP_TIMELINE_PATHCONSTRAINTPOSITION :: TimelineType
pattern SP_TIMELINE_PATHCONSTRAINTPOSITION = #{const SP_TIMELINE_PATHCONSTRAINTPOSITION}
pattern SP_TIMELINE_PATHCONSTRAINTSPACING :: TimelineType
pattern SP_TIMELINE_PATHCONSTRAINTSPACING = #{const SP_TIMELINE_PATHCONSTRAINTSPACING}
pattern SP_TIMELINE_PATHCONSTRAINTMIX :: TimelineType
pattern SP_TIMELINE_PATHCONSTRAINTMIX = #{const SP_TIMELINE_PATHCONSTRAINTMIX}

-- from "spine/AnimationState.h"
type  SpEventType = CInt
pattern SP_ANIMATION_START :: EventType
pattern SP_ANIMATION_START = #{const SP_ANIMATION_START}
pattern SP_ANIMATION_INTERRUPT :: EventType
pattern SP_ANIMATION_INTERRUPT = #{const SP_ANIMATION_INTERRUPT}
pattern SP_ANIMATION_END :: EventType
pattern SP_ANIMATION_END = #{const SP_ANIMATION_END}
pattern SP_ANIMATION_COMPLETE :: EventType
pattern SP_ANIMATION_COMPLETE = #{const SP_ANIMATION_COMPLETE}
pattern SP_ANIMATION_DISPOSE :: EventType
pattern SP_ANIMATION_DISPOSE = #{const SP_ANIMATION_DISPOSE}
pattern SP_ANIMATION_EVENT :: EventType
pattern SP_ANIMATION_EVENT = #{const SP_ANIMATION_EVENT}

-- from "spine/Atlas.h"
type  SpAtlasFormat = CInt
pattern SP_ATLAS_UNKNOWN_FORMAT :: AtlasFormat
pattern SP_ATLAS_UNKNOWN_FORMAT = #{const SP_ATLAS_UNKNOWN_FORMAT}
pattern SP_ATLAS_ALPHA :: AtlasFormat
pattern SP_ATLAS_ALPHA = #{const SP_ATLAS_ALPHA}
pattern SP_ATLAS_INTENSITY :: AtlasFormat
pattern SP_ATLAS_INTENSITY = #{const SP_ATLAS_INTENSITY}
pattern SP_ATLAS_LUMINANCE_ALPHA :: AtlasFormat
pattern SP_ATLAS_LUMINANCE_ALPHA = #{const SP_ATLAS_LUMINANCE_ALPHA}
pattern SP_ATLAS_RGB565 :: AtlasFormat
pattern SP_ATLAS_RGB565 = #{const SP_ATLAS_RGB565}
pattern SP_ATLAS_RGBA4444 :: AtlasFormat
pattern SP_ATLAS_RGBA4444 = #{const SP_ATLAS_RGBA4444}
pattern SP_ATLAS_RGB888 :: AtlasFormat
pattern SP_ATLAS_RGB888 = #{const SP_ATLAS_RGB888}
pattern SP_ATLAS_RGBA8888 :: AtlasFormat
pattern SP_ATLAS_RGBA8888 = #{const SP_ATLAS_RGBA8888}
type  SpAtlasFilter = CInt
pattern SP_ATLAS_UNKNOWN_FILTER :: AtlasFilter
pattern SP_ATLAS_UNKNOWN_FILTER = #{const SP_ATLAS_UNKNOWN_FILTER}
pattern SP_ATLAS_NEAREST :: AtlasFilter
pattern SP_ATLAS_NEAREST = #{const SP_ATLAS_NEAREST}
pattern SP_ATLAS_LINEAR :: AtlasFilter
pattern SP_ATLAS_LINEAR = #{const SP_ATLAS_LINEAR}
pattern SP_ATLAS_MIPMAP :: AtlasFilter
pattern SP_ATLAS_MIPMAP = #{const SP_ATLAS_MIPMAP}
pattern SP_ATLAS_MIPMAP_NEAREST_NEAREST :: AtlasFilter
pattern SP_ATLAS_MIPMAP_NEAREST_NEAREST = #{const SP_ATLAS_MIPMAP_NEAREST_NEAREST}
pattern SP_ATLAS_MIPMAP_LINEAR_NEAREST :: AtlasFilter
pattern SP_ATLAS_MIPMAP_LINEAR_NEAREST = #{const SP_ATLAS_MIPMAP_LINEAR_NEAREST}
pattern SP_ATLAS_MIPMAP_NEAREST_LINEAR :: AtlasFilter
pattern SP_ATLAS_MIPMAP_NEAREST_LINEAR = #{const SP_ATLAS_MIPMAP_NEAREST_LINEAR}
pattern SP_ATLAS_MIPMAP_LINEAR_LINEAR :: AtlasFilter
pattern SP_ATLAS_MIPMAP_LINEAR_LINEAR = #{const SP_ATLAS_MIPMAP_LINEAR_LINEAR}
type  SpAtlasWrap = CInt
pattern SP_ATLAS_MIRROREDREPEAT :: AtlasWrap
pattern SP_ATLAS_MIRROREDREPEAT = #{const SP_ATLAS_MIRROREDREPEAT}
pattern SP_ATLAS_CLAMPTOEDGE :: AtlasWrap
pattern SP_ATLAS_CLAMPTOEDGE = #{const SP_ATLAS_CLAMPTOEDGE}
pattern SP_ATLAS_REPEAT :: AtlasWrap
pattern SP_ATLAS_REPEAT = #{const SP_ATLAS_REPEAT}

-- from "spine/Attachment.h"
type  SpAttachmentType = CInt
pattern SP_ATTACHMENT_REGION :: AttachmentType
pattern SP_ATTACHMENT_REGION = #{const SP_ATTACHMENT_REGION}
pattern SP_ATTACHMENT_BOUNDING_BOX :: AttachmentType
pattern SP_ATTACHMENT_BOUNDING_BOX = #{const SP_ATTACHMENT_BOUNDING_BOX}
pattern SP_ATTACHMENT_MESH :: AttachmentType
pattern SP_ATTACHMENT_MESH = #{const SP_ATTACHMENT_MESH}
pattern SP_ATTACHMENT_LINKED_MESH :: AttachmentType
pattern SP_ATTACHMENT_LINKED_MESH = #{const SP_ATTACHMENT_LINKED_MESH}
pattern SP_ATTACHMENT_PATH :: AttachmentType
pattern SP_ATTACHMENT_PATH = #{const SP_ATTACHMENT_PATH}

-- from "spine/BoneData.h"
type  SpTransformMode = CInt
pattern SP_TRANSFORMMODE_NORMAL :: TransformMode
pattern SP_TRANSFORMMODE_NORMAL = #{const SP_TRANSFORMMODE_NORMAL}
pattern SP_TRANSFORMMODE_ONLYTRANSLATION :: TransformMode
pattern SP_TRANSFORMMODE_ONLYTRANSLATION = #{const SP_TRANSFORMMODE_ONLYTRANSLATION}
pattern SP_TRANSFORMMODE_NOROTATIONORREFLECTION :: TransformMode
pattern SP_TRANSFORMMODE_NOROTATIONORREFLECTION = #{const SP_TRANSFORMMODE_NOROTATIONORREFLECTION}
pattern SP_TRANSFORMMODE_NOSCALE :: TransformMode
pattern SP_TRANSFORMMODE_NOSCALE = #{const SP_TRANSFORMMODE_NOSCALE}
pattern SP_TRANSFORMMODE_NOSCALEORREFLECTION :: TransformMode
pattern SP_TRANSFORMMODE_NOSCALEORREFLECTION = #{const SP_TRANSFORMMODE_NOSCALEORREFLECTION}

-- from "spine/PathConstraintData.h"
type  SpPositionMode = CInt
pattern SP_POSITION_MODE_FIXED :: PositionMode
pattern SP_POSITION_MODE_FIXED = #{const SP_POSITION_MODE_FIXED}
pattern SP_POSITION_MODE_PERCENT :: PositionMode
pattern SP_POSITION_MODE_PERCENT = #{const SP_POSITION_MODE_PERCENT}
type  SpSpacingMode = CInt
pattern SP_SPACING_MODE_LENGTH :: SpacingMode
pattern SP_SPACING_MODE_LENGTH = #{const SP_SPACING_MODE_LENGTH}
pattern SP_SPACING_MODE_FIXED :: SpacingMode
pattern SP_SPACING_MODE_FIXED = #{const SP_SPACING_MODE_FIXED}
pattern SP_SPACING_MODE_PERCENT :: SpacingMode
pattern SP_SPACING_MODE_PERCENT = #{const SP_SPACING_MODE_PERCENT}
type  SpRotateMode = CInt
pattern SP_ROTATE_MODE_TANGENT :: RotateMode
pattern SP_ROTATE_MODE_TANGENT = #{const SP_ROTATE_MODE_TANGENT}
pattern SP_ROTATE_MODE_CHAIN :: RotateMode
pattern SP_ROTATE_MODE_CHAIN = #{const SP_ROTATE_MODE_CHAIN}
pattern SP_ROTATE_MODE_CHAIN_SCALE :: RotateMode
pattern SP_ROTATE_MODE_CHAIN_SCALE = #{const SP_ROTATE_MODE_CHAIN_SCALE}

-- from "spine/RegionAttachment.h"
type  SpVertexIndex = CInt
pattern SP_VERTEX_X1 :: VertexIndex
pattern SP_VERTEX_X1 = #{const SP_VERTEX_X1} -- = 0
pattern SP_VERTEX_Y1 :: VertexIndex
pattern SP_VERTEX_Y1 = #{const SP_VERTEX_Y1}
pattern SP_VERTEX_X2 :: VertexIndex
pattern SP_VERTEX_X2 = #{const SP_VERTEX_X2}
pattern SP_VERTEX_Y2 :: VertexIndex
pattern SP_VERTEX_Y2 = #{const SP_VERTEX_Y2}
pattern SP_VERTEX_X3 :: VertexIndex
pattern SP_VERTEX_X3 = #{const SP_VERTEX_X3}
pattern SP_VERTEX_Y3 :: VertexIndex
pattern SP_VERTEX_Y3 = #{const SP_VERTEX_Y3}
pattern SP_VERTEX_X4 :: VertexIndex
pattern SP_VERTEX_X4 = #{const SP_VERTEX_X4}
pattern SP_VERTEX_Y4 :: VertexIndex
pattern SP_VERTEX_Y4 = #{const SP_VERTEX_Y4}

-- from "spine/SlotData.h"
type  SpBlendMode = CInt
pattern SP_BLEND_MODE_NORMAL :: BlendMode
pattern SP_BLEND_MODE_NORMAL = #{const SP_BLEND_MODE_NORMAL}
pattern SP_BLEND_MODE_ADDITIVE :: BlendMode
pattern SP_BLEND_MODE_ADDITIVE = #{const SP_BLEND_MODE_ADDITIVE}
pattern SP_BLEND_MODE_MULTIPLY :: BlendMode
pattern SP_BLEND_MODE_MULTIPLY = #{const SP_BLEND_MODE_MULTIPLY}
pattern SP_BLEND_MODE_SCREEN :: BlendMode
pattern SP_BLEND_MODE_SCREEN = #{const SP_BLEND_MODE_SCREEN}
