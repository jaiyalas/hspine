
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
