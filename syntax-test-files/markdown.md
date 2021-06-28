Firefox for iOS [![codebeat badge](https://codebeat.co/badges/67e58b6d-bc89-4f22-ba8f-7668a9c15c5a)](https://codebeat.co/projects/github-com-mozilla-firefox-ios) [![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=57bf25c0f096bc01001e21e0&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/57bf25c0f096bc01001e21e0/build/latest) [![codecov](https://codecov.io/gh/mozilla-mobile/firefox-ios/branch/master/graph/badge.svg)](https://codecov.io/gh/mozilla-mobile/firefox-ios/branch/master)
===============

Download on the [App Store](https://itunes.apple.com/app/firefox-web-browser/id989804926).

This branch (master)
-----------

This branch is for mainline development that will ship in *v17.0*.

This branch only works with Xcode 10.2.x and supports iOS 11.0 and above

This branch is written in Swift 4.2

Please make sure you aim your pull requests in the right direction.

For bug fixes and features for a specific release use the version branch.

Getting involved
----------------

Want to contribute but don't know where to start? Here is a list of [issues that are contributor friendly](https://github.com/mozilla-mobile/firefox-ios/issues?q=is%3Aissue+is%3Aopen+label%3A%22Contributor+OK+%F0%9F%A4%9D%22)

Building the code
-----------------

1. Install the latest [Xcode developer tools](https://developer.apple.com/xcode/downloads/) from Apple.
1. Install Carthage
    ```shell
    brew update
    brew install carthage
    ```
1. Clone the repository:
    ```shell
    git clone https://github.com/mozilla-mobile/firefox-ios
    ```
1. Pull in the project dependencies:
    ```shell
    cd firefox-ios
    sh ./bootstrap.sh
    ```
1. Open `Client.xcodeproj` in Xcode.
1. Build the `Fennec` scheme in Xcode.

## Building User Scripts

User Scripts (JavaScript injected into the `WKWebView`) are compiled, concatenated and minified using [webpack](https://webpack.js.org/). User Scripts to be aggregated are placed in the following directories:

```
/Client
|-- /Frontend
    |-- /UserContent
        |-- /UserScripts
            |-- /AllFrames
            |   |-- /AtDocumentEnd
            |   |-- /AtDocumentStart
            |-- /MainFrame
                |-- /AtDocumentEnd
                |-- /AtDocumentStart
```

This reduces the total possible number of User Scripts down to four. The compiled output from concatenating and minifying the User Scripts placed in these folders resides in `/Client/Assets` and are named accordingly:

* `AllFramesAtDocumentEnd.js`
* `AllFramesAtDocumentStart.js`
* `MainFrameAtDocumentEnd.js`
* `MainFrameAtDocumentStart.js`

To simplify the build process, these compiled files are checked-in to this repository. When adding or editing User Scripts, these files can be re-compiled with `webpack` manually. This requires Node.js to be installed and all required `npm` packages can be installed by running `npm install` in the root directory of the project. User Scripts can be compiled by running the following `npm` command in the root directory of the project:

```
npm run build
```

## Contributor guidelines

### Creating a pull request
* All pull requests must be associated with a specific Issue. If an issue doesn't exist please first create it.

### Swift style
* Swift code should generally follow the conventions listed at https://github.com/raywenderlich/swift-style-guide.
  * Exception: we use 4-space indentation instead of 2.
  * This is a loose standard. We do our best to follow this style

### Whitespace
* New code should not contain any trailing whitespace.
* We recommend enabling both the "Automatically trim trailing whitespace" and "Including whitespace-only lines" preferences in Xcode (under Text Editing).
* <code>git rebase --whitespace=fix</code> can also be used to remove whitespace from your commits before issuing a pull request.

### Commits
* Each commit should have a single clear purpose. If a commit contains multiple unrelated changes, those changes should be split into separate commits.
* If a commit requires another commit to build properly, those commits should be squashed.
* Follow-up commits for any review comments should be squashed. Do not include "Fixed PR comments", merge commits, or other "temporary" commits in pull requests.
