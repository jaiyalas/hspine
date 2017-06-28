foreign import ccall "spAnimation_create" spAnimation_create_FFI
    :: CString -- ^ name
    -> CInt -- ^ timelinesCount
    -> IO Ptr SpAnimation

foreign import ccall "spAnimation_dispose" spAnimation_dispose_FFI
    :: Ptr SpAnimation -- ^ self
    -> IO ()

-- | * Poses the skeleton at the specified time for this animation.  * @param lastTime The last time the animation was applied.  * @param events Any triggered events are added. May be null.
foreign import ccall "spAnimation_apply" spAnimation_apply_FFI
    :: Ptr SpAnimation -- ^ self
    -> Ptr SpSkeleton -- ^ skeleton
    -> CFloat -- ^ lastTime
    -> CFloat -- ^ time
    -> CInt -- ^ loop
    -> Ptr ( Ptr SpEvent ) -- ^ events
    -> Ptr CInt -- ^ eventsCount
    -> CFloat -- ^ alpha
    -> CInt -- ^ setupPose
    -> CInt -- ^ mixingOut
    -> IO ()

foreign import ccall "spTimeline_dispose" spTimeline_dispose_FFI
    :: Ptr SpTimeline -- ^ self
    -> IO ()

foreign import ccall "spTimeline_apply" spTimeline_apply_FFI
    :: Ptr SpTimeline -- ^ self
    -> Ptr SpSkeleton -- ^ skeleton
    -> CFloat -- ^ lastTime
    -> CFloat -- ^ time
    -> Ptr ( Ptr SpEvent ) -- ^ firedEvents
    -> Ptr CInt -- ^ eventsCount
    -> CFloat -- ^ alpha
    -> CInt -- ^ setupPose
    -> CInt -- ^ mixingOut
    -> IO ()

foreign import ccall "spTimeline_getPropertyId" spTimeline_getPropertyId_FFI
    :: Ptr SpTimeline -- ^ self
    -> IO CInt

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

foreign import ccall "spTranslateTimeline_create" spTranslateTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpTranslateTimeline

foreign import ccall "spTranslateTimeline_setFrame" spTranslateTimeline_setFrame_FFI
    :: Ptr SpTranslateTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO ()

foreign import ccall "spScaleTimeline_create" spScaleTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpScaleTimeline

foreign import ccall "spScaleTimeline_setFrame" spScaleTimeline_setFrame_FFI
    :: Ptr SpScaleTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO ()

foreign import ccall "spShearTimeline_create" spShearTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpShearTimeline

foreign import ccall "spShearTimeline_setFrame" spShearTimeline_setFrame_FFI
    :: Ptr SpShearTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ x
    -> CFloat -- ^ y
    -> IO ()

foreign import ccall "spColorTimeline_create" spColorTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpColorTimeline

foreign import ccall "spColorTimeline_setFrame" spColorTimeline_setFrame_FFI
    :: Ptr SpColorTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ r
    -> CFloat -- ^ g
    -> CFloat -- ^ b
    -> CFloat -- ^ a
    -> IO ()

foreign import ccall "spAttachmentTimeline_create" spAttachmentTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpAttachmentTimeline

-- | @param attachmentName May be 0.
foreign import ccall "spAttachmentTimeline_setFrame" spAttachmentTimeline_setFrame_FFI
    :: Ptr SpAttachmentTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CString -- ^ attachmentName
    -> IO ()

foreign import ccall "spEventTimeline_create" spEventTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpEventTimeline

foreign import ccall "spEventTimeline_setFrame" spEventTimeline_setFrame_FFI
    :: Ptr SpEventTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> Ptr SpEvent -- ^ event
    -> IO ()

foreign import ccall "spDrawOrderTimeline_create" spDrawOrderTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> CInt -- ^ slotsCount
    -> IO Ptr SpDrawOrderTimeline

foreign import ccall "spDrawOrderTimeline_setFrame" spDrawOrderTimeline_setFrame_FFI
    :: Ptr SpDrawOrderTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> Ptr CInt -- ^ drawOrder
    -> IO ()

foreign import ccall "spDeformTimeline_create" spDeformTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> CInt -- ^ frameVerticesCount
    -> IO Ptr SpDeformTimeline

foreign import ccall "spDeformTimeline_setFrame" spDeformTimeline_setFrame_FFI
    :: Ptr SpDeformTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> Ptr CFloat -- ^ vertices
    -> IO ()

foreign import ccall "spIkConstraintTimeline_create" spIkConstraintTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpIkConstraintTimeline

foreign import ccall "spIkConstraintTimeline_setFrame" spIkConstraintTimeline_setFrame_FFI
    :: Ptr SpIkConstraintTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ mix
    -> CInt -- ^ bendDirection
    -> IO ()

foreign import ccall "spTransformConstraintTimeline_create" spTransformConstraintTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpTransformConstraintTimeline

foreign import ccall "spTransformConstraintTimeline_setFrame" spTransformConstraintTimeline_setFrame_FFI
    :: Ptr SpTransformConstraintTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ rotateMix
    -> CFloat -- ^ translateMix
    -> CFloat -- ^ scaleMix
    -> CFloat -- ^ shearMix
    -> IO ()

foreign import ccall "spPathConstraintPositionTimeline_create" spPathConstraintPositionTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpPathConstraintPositionTimeline

foreign import ccall "spPathConstraintPositionTimeline_setFrame" spPathConstraintPositionTimeline_setFrame_FFI
    :: Ptr SpPathConstraintPositionTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ value
    -> IO ()

foreign import ccall "spPathConstraintSpacingTimeline_create" spPathConstraintSpacingTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpPathConstraintSpacingTimeline

foreign import ccall "spPathConstraintSpacingTimeline_setFrame" spPathConstraintSpacingTimeline_setFrame_FFI
    :: Ptr SpPathConstraintSpacingTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ value
    -> IO ()

foreign import ccall "spPathConstraintMixTimeline_create" spPathConstraintMixTimeline_create_FFI
    :: CInt -- ^ framesCount
    -> IO Ptr SpPathConstraintMixTimeline

foreign import ccall "spPathConstraintMixTimeline_setFrame" spPathConstraintMixTimeline_setFrame_FFI
    :: Ptr SpPathConstraintMixTimeline -- ^ self
    -> CInt -- ^ frameIndex
    -> CFloat -- ^ time
    -> CFloat -- ^ rotateMix
    -> CFloat -- ^ translateMix
    -> IO ()



    , SpAnimation_create
    , SpAnimation_dispose
    , SpAnimation_apply
    , SpTimeline_dispose
    , SpTimeline_apply
    , SpTimeline_getPropertyId
    , SpCurveTimeline_setLinear
    , SpCurveTimeline_setStepped
    , SpCurveTimeline_setCurve
    , SpCurveTimeline_getCurvePercent
    , SpRotateTimeline_create
    , SpRotateTimeline_setFrame
    , SpTranslateTimeline_create
    , SpTranslateTimeline_setFrame
    , SpScaleTimeline_create
    , SpScaleTimeline_setFrame
    , SpShearTimeline_create
    , SpShearTimeline_setFrame
    , SpColorTimeline_create
    , SpColorTimeline_setFrame
    , SpAttachmentTimeline_create
    , SpAttachmentTimeline_setFrame
    , SpEventTimeline_create
    , SpEventTimeline_setFrame
    , SpDrawOrderTimeline_create
    , SpDrawOrderTimeline_setFrame
    , SpDeformTimeline_create
    , SpDeformTimeline_setFrame
    , SpIkConstraintTimeline_create
    , SpIkConstraintTimeline_setFrame
    , SpTransformConstraintTimeline_create
    , SpTransformConstraintTimeline_setFrame
    , SpPathConstraintPositionTimeline_create
    , SpPathConstraintPositionTimeline_setFrame
    , SpPathConstraintSpacingTimeline_create
    , SpPathConstraintSpacingTimeline_setFrame
    , SpPathConstraintMixTimeline_create
    , SpPathConstraintMixTimeline_setFrame
