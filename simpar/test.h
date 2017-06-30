
struct spAtlasPage {
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
};


struct spAtlasRegion {
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
};


struct spAtlas {
	spAtlasPage* pages;
	spAtlasRegion* regions;

	void* rendererObject;
};
