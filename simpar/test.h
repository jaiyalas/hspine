
typedef struct spEventData {
	const char* const name;
	int intValue;
	float floatValue;
	const char* stringValue;

#ifdef __cplusplus
	spEventData() :
		name(0),
		intValue(0),
		floatValue(0),
		stringValue(0) {
	}
#endif
} spEventData;

spEventData* spEventData_create (const char* name);
void spEventData_dispose (spEventData* self);
