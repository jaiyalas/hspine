void spCurveTimeline_setLinear (spCurveTimeline* self, int frameIndex);
void spCurveTimeline_setStepped (spCurveTimeline* self, int frameIndex);

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


/* Sets the control handle positions for an interpolation bezier curve used to transition from this keyframe to the next.
 * cx1 and cx2 are from 0 to 1, representing the percent of time between the two keyframes. cy1 and cy2 are the percent of
 * the difference between the keyframe's values. */
void spCurveTimeline_setCurve (spCurveTimeline* self, int frameIndex, float cx1, float cy1, float cx2, float cy2);
float spCurveTimeline_getCurvePercent (const spCurveTimeline* self, int frameIndex, float percent);

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

spRotateTimeline* spRotateTimeline_create (int framesCount);

void spRotateTimeline_setFrame (spRotateTimeline* self, int frameIndex, float time, float angle);
