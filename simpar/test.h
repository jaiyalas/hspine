typedef struct spAnimation {
	const char* const name;
	float duration;

	int timelinesCount;
	spTimeline** timelines;

#ifdef __cplusplus
	spAnimation() :
		name(0),
		duration(0),
		timelinesCount(0),
		timelines(0) {
	}
#endif
} spAnimation;

struct spTimeline {
	const spTimelineType type;
	const void* const vtable;

#ifdef __cplusplus
	spTimeline() :
		type(SP_TIMELINE_SCALE),
		vtable(0) {
	}
#endif
};

typedef struct spCurveTimeline {
	spTimeline super;
	float* curves; /* type, x, y, ... */

#ifdef __cplusplus
	spCurveTimeline() :
		super(),
		curves(0) {
	}
#endif
} spCurveTimeline;

typedef struct spBaseTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, angle, ... for rotate. time, x, y, ... for translate and scale. */
	int boneIndex;

#ifdef __cplusplus
	spBaseTimeline() :
		super(),
		framesCount(0),
		frames(0),
		boneIndex(0) {
	}
#endif
} spBaseTimeline;

typedef struct spColorTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, r, g, b, a, ... */
	int slotIndex;

#ifdef __cplusplus
	spColorTimeline() :
		super(),
		framesCount(0),
		frames(0),
		slotIndex(0) {
	}
#endif
} spColorTimeline;


typedef struct spAttachmentTimeline {
	spTimeline super;
	int const framesCount;
	float* const frames; /* time, ... */
	int slotIndex;
	const char** const attachmentNames;

#ifdef __cplusplus
	spAttachmentTimeline() :
		super(),
		framesCount(0),
		frames(0),
		slotIndex(0),
		attachmentNames(0) {
	}
#endif
} spAttachmentTimeline;


typedef struct spEventTimeline {
	spTimeline super;
	int const framesCount;
	float* const frames; /* time, ... */
	spEvent** const events;

#ifdef __cplusplus
	spEventTimeline() :
		super(),
		framesCount(0),
		frames(0),
		events(0) {
	}
#endif
} spEventTimeline;

typedef struct spDrawOrderTimeline {
	spTimeline super;
	int const framesCount;
	float* const frames; /* time, ... */
	const int** const drawOrders;
	int const slotsCount;

#ifdef __cplusplus
	spDrawOrderTimeline() :
		super(),
		framesCount(0),
		frames(0),
		drawOrders(0),
		slotsCount(0) {
	}
#endif
} spDrawOrderTimeline;

typedef struct spDeformTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, ... */
	int const frameVerticesCount;
	const float** const frameVertices;
	int slotIndex;
	spAttachment* attachment;

#ifdef __cplusplus
	spDeformTimeline() :
		super(),
		framesCount(0),
		frames(0),
		frameVerticesCount(0),
		frameVertices(0),
		slotIndex(0) {
	}
#endif
} spDeformTimeline;

typedef struct spIkConstraintTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, mix, bendDirection, ... */
	int ikConstraintIndex;

#ifdef __cplusplus
	spIkConstraintTimeline() :
		super(),
		framesCount(0),
		frames(0),
		ikConstraintIndex(0) {
	}
#endif
} spIkConstraintTimeline;

typedef struct spTransformConstraintTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */
	int transformConstraintIndex;

#ifdef __cplusplus
	spTransformConstraintTimeline() :
		super(),
		framesCount(0),
		frames(0),
		transformConstraintIndex(0) {
	}
#endif
} spTransformConstraintTimeline;

typedef struct spPathConstraintPositionTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */
	int pathConstraintIndex;

#ifdef __cplusplus
	spPathConstraintPositionTimeline() :
		super(),
		framesCount(0),
		frames(0),
		pathConstraintIndex(0) {
	}
#endif
} spPathConstraintPositionTimeline;

typedef struct spPathConstraintSpacingTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */
	int pathConstraintIndex;

#ifdef __cplusplus
	spPathConstraintSpacingTimeline() :
		super(),
		framesCount(0),
		frames(0),
		pathConstraintIndex(0) {
	}
#endif
} spPathConstraintSpacingTimeline;

typedef struct spPathConstraintMixTimeline {
	spCurveTimeline super;
	int const framesCount;
	float* const frames; /* time, rotate mix, translate mix, scale mix, shear mix, ... */
	int pathConstraintIndex;

#ifdef __cplusplus
	spPathConstraintMixTimeline() :
		super(),
		framesCount(0),
		frames(0),
		pathConstraintIndex(0) {
	}
#endif
} spPathConstraintMixTimeline;
