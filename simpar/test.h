
struct spTrackEntry {
	spAnimation* animation;
	spTrackEntry* next;
	spTrackEntry* mixingFrom;
	spAnimationStateListener listener;
	int trackIndex;
	int loop; /* boolean */
	float eventThreshold;
	float attachmentThreshold;
	float drawOrderThreshold;
	float animationStart;
	float animationEnd;
	float animationLast;
	float nextAnimationLast;
	float delay;
	float trackTime;
	float trackLast;
	float nextTrackLast;
	float trackEnd;
	float timeScale;
	float alpha;
	float mixTime;
	float mixDuration;
	float mixAlpha;
	int* timelinesFirst; /* boolean */
	int timelinesFirstCount;
	float* timelinesRotation;
	int timelinesRotationCount;
	void* rendererObject;
	void* userData;

#ifdef __cplusplus
	spTrackEntry() :
		animation(0),
		next(0), mixingFrom(0),
		listener(0),
		trackIndex(0),
		loop(0),
		eventThreshold(0), attachmentThreshold(0), drawOrderThreshold(0),
		animationStart(0), animationEnd(0), animationLast(0), nextAnimationLast(0),
		delay(0), trackTime(0), trackLast(0), nextTrackLast(0), trackEnd(0), timeScale(0),
		alpha(0), mixTime(0), mixDuration(0), mixAlpha(0),
		timelinesFirst(0),
		timelinesFirstCount(0),
		timelinesRotation(0),
		timelinesRotationCount(0) {
	}
#endif
};

struct spAnimationState {
	spAnimationStateData* const data;

	int tracksCount;
	spTrackEntry** tracks;

	spAnimationStateListener listener;

	float timeScale;

	void* rendererObject;

#ifdef __cplusplus
	spAnimationState() :
		data(0),
		tracksCount(0),
		tracks(0),
		listener(0),
		timeScale(0) {
	}
#endif
};
