spAtlasPage* spAtlasPage_create (spAtlas* atlas, const char* name);
void spAtlasPage_dispose (spAtlasPage* self);


spAtlasRegion* spAtlasRegion_create ();
void spAtlasRegion_dispose (spAtlasRegion* self);

/* Image files referenced in the atlas file will be prefixed with dir. */
spAtlas* spAtlas_create (const char* data, int length, const char* dir, void* rendererObject);
/* Image files referenced in the atlas file will be prefixed with the directory containing the atlas file. */
spAtlas* spAtlas_createFromFile (const char* path, void* rendererObject);
void spAtlas_dispose (spAtlas* atlas);

/* Returns 0 if the region was not found. */
spAtlasRegion* spAtlas_findRegion (const spAtlas* self, const char* name);


typedef struct spAtlasPage{
	const spAtlas* atlas;
	const char* name;
	spAtlasFormat format;
	spAtlasFilter minFilter;
	spAtlasFilter magFilter;
	spAtlasWrap uWrap;
	spAtlasWrap vWrap;
	void* rendererObject;
	int width;
    int height;
	spAtlasPage* next;
} spAtlasPage;

typedef struct spAtlas{
	spAtlasPage* pages;
	spAtlasRegion* regions;

	void* rendererObject;
} spAtlas;


typedef struct spAtlasRegion{
	const char* name;
	int x;
	int y;
	int width;
	int height;

	float u;
	float v;
	float u2;
	float v2;

	int offsetX;
	int offsetY;
	int originalWidth;
	int originalHeight;
	int index;
	int rotate; /* boolean */
	int flip; /* boolean */
	int* splits;
	int* pads;
	spAtlasPage* page;
	spAtlasRegion* next;
} spAtlasRegion;
