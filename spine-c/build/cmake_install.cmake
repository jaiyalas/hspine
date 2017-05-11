# Install script for directory: /Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/dist/lib" TYPE STATIC_LIBRARY FILES "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/build/libspine-c.a")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/dist/lib/libspine-c.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/dist/lib/libspine-c.a")
    execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/dist/lib/libspine-c.a")
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/dist/include" TYPE FILE FILES
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/Animation.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/AnimationState.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/AnimationStateData.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/Atlas.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/AtlasAttachmentLoader.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/Attachment.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/AttachmentLoader.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/Bone.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/BoneData.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/BoundingBoxAttachment.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/Event.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/EventData.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/IkConstraint.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/IkConstraintData.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/MeshAttachment.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/PathAttachment.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/PathConstraint.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/PathConstraintData.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/RegionAttachment.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/Skeleton.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/SkeletonBinary.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/SkeletonBounds.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/SkeletonData.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/SkeletonJson.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/Skin.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/Slot.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/SlotData.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/TransformConstraint.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/TransformConstraintData.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/VertexAttachment.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/extension.h"
    "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/spine-c/include/spine/spine.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/Users/jaiyalas/Project/mega-eye/spine-c-haskell/extra/spine-c/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
