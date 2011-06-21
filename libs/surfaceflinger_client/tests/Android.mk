# Build the unit tests.
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifneq ($(TARGET_SIMULATOR),true)

# Build the unit tests.
test_src_files := \
    Surface_test.cpp \

shared_libraries := \
	libcutils \
	libutils \
	libbinder \
	libsurfaceflinger_client \
	libstlport \

static_libraries := \
	libgtest \
	libgtest_main \

c_includes := \
    bionic \
    bionic/libstdc++/include \
    external/gtest/include \
    external/stlport/stlport \

module_tags := tests

$(foreach file,$(test_src_files), \
    $(eval include $(CLEAR_VARS)) \
    $(eval LOCAL_SHARED_LIBRARIES := $(shared_libraries)) \
    $(eval LOCAL_STATIC_LIBRARIES := $(static_libraries)) \
    $(eval LOCAL_C_INCLUDES := $(c_includes)) \
    $(eval LOCAL_SRC_FILES := $(file)) \
    $(eval LOCAL_MODULE := $(notdir $(file:%.cpp=%))) \
    $(eval LOCAL_MODULE_TAGS := $(module_tags)) \
    $(eval include $(BUILD_EXECUTABLE)) \
)

# Build the manual test programs.
include $(call all-subdir-makefiles)

endif

# Include subdirectory makefiles
# ============================================================

# If we're building with ONE_SHOT_MAKEFILE (mm, mmm), then what the framework
# team really wants is to build the stuff defined by this makefile.
ifeq (,$(ONE_SHOT_MAKEFILE))
include $(call first-makefiles-under,$(LOCAL_PATH))
endif