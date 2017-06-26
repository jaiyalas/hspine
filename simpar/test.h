typedef struct spAnimationStateData {
	spSkeletonData* const skeletonData;
	float defaultMix;
	const void* const entries;

#ifdef __cplusplus
	spAnimationStateData() :
		skeletonData(0),
		defaultMix(0),
		entries(0) {
	}
#endif
} spAnimationStateData;
