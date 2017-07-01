

typedef struct spVertexAttachment {
	spAttachment super;

	int bonesCount;
	int* bones;

	int verticesCount;
	float* vertices;

	int worldVerticesLength;
} spVertexAttachment;

void spVertexAttachment_computeWorldVertices (spVertexAttachment* self, spSlot* slot, float* worldVertices);
void spVertexAttachment_computeWorldVertices1 (spVertexAttachment* self, int start, int count, spSlot* slot, float* worldVertices, int offset);
