SWIFTC=swiftc
UNAME=$(shell uname)

ifeq ($(UNAME), Darwin)
XCODE=$(shell xcode-select -p)
SDK=$(XCODE)/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk
TARGET=x86_64-apple-macosx10.10
SWIFTC=swiftc -target $(TARGET) -sdk $(SDK) -Xlinker -all_load
endif

curassow:
	swift build

spectre:
	cd Spectre && swift build

tests: curassow spectre
	$(SWIFTC) -o run-tests \
		Tests/HTTPParserSpecs.swift \
		-I.build/debug \
		-ISpectre/.build/debug -Xlinker Spectre/.build/debug/Spectre.a
	./run-tests

test: tests
