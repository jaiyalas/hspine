# hspine

+ 確認連結 spine/\*\*.h 和 libspine-c.a
+ 準備好 Spine.Raw.\* 的空檔案
+ 下一步
    + 連結測試 SFML
    + 參考 spine-sfml

## todo

+ [ ] Animation
+ [ ] AnimationState
+ [ ] AnimationStateData
+ [ ] Atlas
+ [ ] AtlasAttachmentLoader
+ [ ] Attachment
+ [ ] AttachmentLoader
+ [ ] Bone
+ [ ] BoneData
+ [ ] BoundingBoxAttachment
+ [ ] Event
+ [ ] EventData
+ [ ] IkConstraint
+ [ ] IkConstraintData
+ [ ] MeshAttachment
+ [ ] PathAttachment
+ [ ] PathConstraint
+ [ ] PathConstraintData
+ [ ] RegionAttachment
+ [ ] Skeleton
+ [ ] SkeletonBinary
+ [ ] SkeletonBounds
+ [ ] SkeletonData
+ [ ] SkeletonJson
+ [ ] Skin
+ [ ] Slot
+ [ ] SlotData
+ [ ] TransformConstraint
+ [ ] TransformConstraintData
+ [ ] VertexAttachment

## malloc, free and pointer op

+ [Foreign.Marshal.Array](https://hackage.haskell.org/package/base-4.9.1.0/docs/Foreign-Marshal-Array.html)
    + `mallocArray :: Storable a => Int -> IO (Ptr a)`
    + `peekArray :: Storable a => Int -> Ptr a -> IO [a]`
    + `pokeArray :: Storable a => Ptr a -> [a] -> IO ()`
    + `newArray :: Storable a => [a] -> IO (Ptr a) `
    + `withArray :: Storable a => [a] -> (Ptr a -> IO b) -> IO b`
+ [Foreign.Marshal.Alloc](https://hackage.haskell.org/package/base-4.9.1.0/docs/Foreign-Marshal-Alloc.html)
    + `alloca :: Storable a => (Ptr a -> IO b) -> IO b`
    + `malloc :: Storable a => IO (Ptr a)`
    + `free :: Ptr a -> IO ()`
