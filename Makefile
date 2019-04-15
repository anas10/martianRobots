# Usage:
# make	# compile all binary in debug mode

all: build

build:
	swift build

build_release:
	swift build -c release -Xswiftc -static-stdlib

xcodeproj:
	swift package generate-xcodeproj

test:
	swift test 2>&1 | xcpretty

clean:
	rm -rf .build