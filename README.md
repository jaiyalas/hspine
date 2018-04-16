# hspine

[![Haskell](http://b.repl.ca/v1/language-haskell-green.png)](http://haskell.org)

The `hspine` is a haskell binding for the runtime library of well-known 2D animation tool - [*spine*](https://github.com/EsotericSoftware/spine-runtimes).

+ `/spine-c` - the source code of spine-c 3.5
+ `/simpar` - to trnaslating spine-c into .hsc semi-automatively
+ `/src` - the hspine library

## Building

> stack steup
> stack build

## Progress

### todo

+ [ ] loading spine files
+ [ ] rendering with SDL

### done

+ [x] Spine.Raw.*
    + [x] Animation
    + [x] AnimationState
    + [x] AnimationStateData
    + [x] Atlas
    + [x] AtlasAttachmentLoader
    + [x] Attachment
    + [x] AttachmentLoader
    + [x] Bone
    + [x] BoneData
    + [x] BoundingBoxAttachment
    + [x] Event
    + [x] EventData
    + [x] IkConstraint
    + [x] IkConstraintData
    + [x] MeshAttachment
    + [x] PathAttachment
    + [x] PathConstraint
    + [x] PathConstraintData
    + [x] RegionAttachment
    + [x] Skeleton
    + [x] SkeletonBinary
    + [x] SkeletonBounds
    + [x] SkeletonData
    + [x] SkeletonJson
    + [x] Skin
    + [x] Slot
    + [x] SlotData
    + [x] TransformConstraint
    + [x] TransformConstraintData
    + [x] VertexAttachment
+ [x] Ensure that `spine/\*\*.h` and `libspine-c.a` works.
+ [x] Ready blank files under `Spine.Raw.\*`

# reference

## spine documentation

+ [Spine User Guide](http://esotericsoftware.com/spine-user-guide)
+ [Spine Runtimes Guide](http://esotericsoftware.com/spine-runtimes-guide)
    + [Runtime Architecture](http://esotericsoftware.com/spine-runtime-architecture)
    + [Loading Skeleton Data](http://esotericsoftware.com/spine-loading-skeleton-data)
    + [Applying Animations](http://esotericsoftware.com/spine-applying-animations)
    + [Runtime Skeletons](http://esotericsoftware.com/spine-runtime-skeletons)
    + [Runtime Skins](http://esotericsoftware.com/spine-runtime-skins)
    + [API Reference](http://esotericsoftware.com/spine-api-reference)
+ [Spine-C Runtime Documentation](http://esotericsoftware.com/spine-c)
+ Export Format
    + [JSON export format](http://esotericsoftware.com/spine-json-format)
    + [Binary export format](http://esotericsoftware.com/spine-binary-format)
    + [Atlas export format](http://esotericsoftware.com/spine-atlas-format)
