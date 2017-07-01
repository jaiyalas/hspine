module Spine.Raw.SkeletonBounds
    ( -- * fuunctions
      spPolygon_create_FFI
    , spPolygon_dispose_FFI
    , spPolygon_containsPoint_FFI
    , spPolygon_intersectsSegment_FFI
    , spSkeletonBounds_create_FFI
    , spSkeletonBounds_dispose_FFI
    , spSkeletonBounds_update_FFI
    , spSkeletonBounds_aabbContainsPoint_FFI
    , spSkeletonBounds_aabbIntersectsSegment_FFI
    , spSkeletonBounds_aabbIntersectsSkeleton_FFI
    , spSkeletonBounds_containsPoint_FFI
    , spSkeletonBounds_intersectsSegment_FFI
    , spSkeletonBounds_getPolygon_FFI
    ) where
--
#include "spine/SkeletonBounds.h"
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw.InternalStruct
--
foreign import ccall "spPolygon_create" spPolygon_create_FFI
    :: CInt -- ^ capacity
    -> IO (Ptr SpPolygon)

foreign import ccall "spPolygon_dispose" spPolygon_dispose_FFI
    :: Ptr SpPolygon -- ^ self
    -> IO ()

foreign import ccall "spPolygon_containsPoint" spPolygon_containsPoint_FFI
    :: Ptr SpPolygon -- ^ polygon
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO CInt -- ^ :: boolean

foreign import ccall "spPolygon_intersectsSegment" spPolygon_intersectsSegment_FFI
    :: Ptr SpPolygon -- ^ polygon
    -> CFloat -- ^ x1
    -> CFloat -- ^ y1
    -> CFloat -- ^ x2
    -> CFloat -- ^ y2
    -> IO CInt -- ^ :: boolean

foreign import ccall "spSkeletonBounds_create" spSkeletonBounds_create_FFI
    :: IO (Ptr SpSkeletonBounds)

foreign import ccall "spSkeletonBounds_dispose" spSkeletonBounds_dispose_FFI
    :: Ptr SpSkeletonBounds -- ^ self
    -> IO ()

foreign import ccall "spSkeletonBounds_update" spSkeletonBounds_update_FFI
    :: Ptr SpSkeletonBounds -- ^ self
    -> Ptr SpSkeleton -- ^ skeleton
    -> CInt -- ^ updateAabb :: boolean
    -> IO ()

-- | * Returns true if the axis aligned bounding box contains the point.
foreign import ccall "spSkeletonBounds_aabbContainsPoint" spSkeletonBounds_aabbContainsPoint_FFI
    :: Ptr SpSkeletonBounds -- ^ self
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO CInt -- ^ :: boolean

-- | * Returns true if the axis aligned bounding box intersects the line segment.
foreign import ccall "spSkeletonBounds_aabbIntersectsSegment" spSkeletonBounds_aabbIntersectsSegment_FFI
    :: Ptr SpSkeletonBounds -- ^ self
    -> CFloat -- ^ x1
    -> CFloat -- ^ y1
    -> CFloat -- ^ x2
    -> CFloat -- ^ y2
    -> IO CInt -- ^ :: boolean

-- | * Returns true if the axis aligned bounding box intersects the axis aligned bounding box of the specified bounds.
foreign import ccall "spSkeletonBounds_aabbIntersectsSkeleton" spSkeletonBounds_aabbIntersectsSkeleton_FFI
    :: Ptr SpSkeletonBounds -- ^ self
    -> Ptr SpSkeletonBounds -- ^ bounds
    -> IO CInt -- ^ :: boolean

-- | * Returns the first bounding box attachment that contains the point, or null. When doing many checks, it is usually more * efficient to only call this method if spSkeletonBounds_aabbContainsPoint returns true.
foreign import ccall "spSkeletonBounds_containsPoint" spSkeletonBounds_containsPoint_FFI
    :: Ptr SpSkeletonBounds -- ^ self
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO (Ptr SpBoundingBoxAttachment)

-- | * Returns the first bounding box attachment that contains the line segment, or null. When doing many checks, it is usually * more efficient to only call this method if spSkeletonBounds_aabbIntersectsSegment returns true.
foreign import ccall "spSkeletonBounds_intersectsSegment" spSkeletonBounds_intersectsSegment_FFI
    :: Ptr SpSkeletonBounds -- ^ self
    -> CFloat -- ^ x1
    -> CFloat -- ^ y1
    -> CFloat -- ^ x2
    -> CFloat -- ^ y2
    -> IO (Ptr SpBoundingBoxAttachment)

-- | * Returns the polygon for the specified bounding box, or null.
foreign import ccall "spSkeletonBounds_getPolygon" spSkeletonBounds_getPolygon_FFI
    :: Ptr SpSkeletonBounds -- ^ self
    -> Ptr SpBoundingBoxAttachment -- ^ boundingBox
    -> IO (Ptr SpPolygon)
