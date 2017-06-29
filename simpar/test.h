
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

spAnimationStateData* spAnimationStateData_create (spSkeletonData* skeletonData);
void spAnimationStateData_dispose (spAnimationStateData* self);

void spAnimationStateData_setMixByName (spAnimationStateData* self, const char* fromName, const char* toName, float duration);
void spAnimationStateData_setMix (spAnimationStateData* self, spAnimation* from, spAnimation* to, float duration);
/* Returns 0 if there is no mixing between the animations. */
float spAnimationStateData_getMix (spAnimationStateData* self, spAnimation* from, spAnimation* to);
