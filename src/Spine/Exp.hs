module Spine.Exp where
--
import Foreign.C
import Foreign.Ptr
--
import Spine.Raw
--
import SDL
--
--
-- class SkeletonDrawable {
-- public:
-- 	Skeleton* skeleton;
-- 	AnimationState* state;
-- 	float timeScale;
-- 	Uint64 lastUpdate;
--
-- 	VertexArray vertexArray;
-- 	intArray indices;
--
-- 	SkeletonDrawable (SkeletonData* skeleton, AnimationStateData* stateData = 0);
-- 	~SkeletonDrawable ();
--
-- 	void update (Uint64 now);
--
-- 	virtual void draw (SDL_Renderer *renderer);
--
-- };
data SkeletonDrawable = SkeletonDrawable
    { skeletonDrawable_skeleton :: Ptr Skeleton
    , state :: Ptr AnimationState
    , timeScale :: CFloat
    , lastUpdate :: Word64 -- Uint64
    , vertexArray :: [SDL.Vertex] -- VertexArray
    , indices :: [Int] -- intArray
    } deriving (Show, Eq)
--
