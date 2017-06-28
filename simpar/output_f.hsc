foreign import ccall "spCurveTimeline_setLinear" spCurveTimeline_setLinear_FFI
    :: Ptr SpCurveTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> IO ()

foreign import ccall "spCurveTimeline_setStepped" spCurveTimeline_setStepped_FFI
    :: Ptr SpCurveTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> IO ()

-- | Sets the control handle positions for an interpolation bezier curve used to transition from this keyframe to the next.  * cx1 and cx2 are from 0 to 1, representing the percent of time between the two keyframes. cy1 and cy2 are the percent of  * the difference between the keyframe's values.
foreign import ccall "spCurveTimeline_setCurve" spCurveTimeline_setCurve_FFI
    :: Ptr SpCurveTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ cx1
    -> CFloat -- ^ cy1
    -> CFloat -- ^ cx2
    -> CFloat -- ^ cy2
    -> IO ()

foreign import ccall "spCurveTimeline_getCurvePercent" spCurveTimeline_getCurvePercent_FFI
    :: Ptr SpCurveTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ percent
    -> IO CFloat

foreign import ccall "spRotateTimeline_create" spRotateTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpRotateTimeline

foreign import ccall "spRotateTimeline_setFrame" spRotateTimeline_setFrame_FFI
    :: Ptr SpRotateTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ angle
    -> IO ()

